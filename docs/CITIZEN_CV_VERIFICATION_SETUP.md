# Citizen Science API - CV Verification Service Setup

## 🎯 Tổng quan

Hệ thống Citizen Science hoạt động theo **2-phase architecture**:

```
Phase 1: INGESTION (Fast Response)
├── User POST report → Citizen API
├── Background: Enrich Weather + AQ
├── Save to Stellio
└── Initial: aiVerified=false, aiConfidence=0.0

Phase 2: VERIFICATION (Background Service)
├── CV Agent poll Stellio every 30s
├── Query: aiVerified=false
├── Download image → YOLOX detect
├── Calculate confidence score
└── PATCH Stellio: aiVerified=true, aiConfidence=0.X
```

## 🚀 Production Deployment

### Option 1: Docker Compose (RECOMMENDED)

CV Verification Service đã được thêm vào `docker-compose.yml`:

```bash
# Start tất cả services (bao gồm CV verification)
docker compose up -d

# Check CV verification service status
docker compose logs -f cv-verification-service

# Stop all services
docker compose down
```

**CV Service sẽ tự động:**
- Chạy liên tục như background daemon
- Poll Stellio mỗi 30s
- Verify tất cả reports có `aiVerified=false`
- Update `aiConfidence` tự động

### Option 2: Manual Start (Development)

```bash
# Terminal 1: Start Citizen API
cd D:\olp\Builder-Layer-End
python -m uvicorn src.agents.ingestion.citizen_ingestion_agent:app --host 0.0.0.0 --port 8001

# Terminal 2: Start CV Verification Service
python start_cv_verification_service.py
```

### Option 3: Systemd Service (Linux Production)

```bash
# Create systemd service file
sudo nano /etc/systemd/system/cv-verification.service
```

```ini
[Unit]
Description=CV Agent Citizen Verification Service
After=network.target stellio.service

[Service]
Type=simple
User=appuser
WorkingDirectory=/opt/builder-layer-end
Environment="PYTHONPATH=/opt/builder-layer-end"
ExecStart=/usr/bin/python3 start_cv_verification_service.py
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

```bash
# Enable and start service
sudo systemctl daemon-reload
sudo systemctl enable cv-verification
sudo systemctl start cv-verification

# Check status
sudo systemctl status cv-verification

# View logs
sudo journalctl -u cv-verification -f
```

## 📋 Configuration

Kiểm tra `config/cv_config.yaml`:

```yaml
citizen_verification:
  enabled: true                    # PHẢI BẬT!
  poll_interval: 30                # Poll every 30s
  stellio_url: "http://localhost:8080"
  query: "type=CitizenObservation&q=aiVerified==false"
  max_reports_per_batch: 10        # Process max 10/batch
  
  verification_rules:
    traffic_jam:
      required_objects: ["car", "bus", "truck", "motorcycle"]
      min_count: 5                 # Min 5 vehicles
      confidence_threshold: 0.3
      
    accident:
      required_objects: ["car", "truck", "bus", "motorcycle"]
      min_count: 1
      use_accident_model: true     # Use specialized model
      confidence_threshold: 0.4
```

## ✅ Verification Flow

### User gửi report:

```bash
curl -X POST http://localhost:8001/api/v1/citizen-reports \
  -H "Content-Type: application/json" \
  -d '{
    "userId": "user123",
    "reportType": "accident",
    "description": "Tai nạn giao thông",
    "latitude": 10.7769,
    "longitude": 106.7009,
    "imageUrl": "https://example.com/accident.jpg"
  }'

# Response: 202 Accepted
# {
#   "reportId": "abc-123",
#   "status": "pending_verification",
#   "aiVerified": false,
#   "aiConfidence": 0.0
# }
```

### CV Service tự động verify (sau max 30s):

```
🤖 CV Verification Service
================================================================================
Iteration #42 - 2025-11-23 14:30:00
================================================================================
📊 Query Stellio: type=CitizenObservation&q=aiVerified==false
✅ Found 1 unverified report
📥 Downloading image: https://example.com/accident.jpg
🔍 Running YOLOX detection...
   Detected: car (0.85), motorcycle (0.78), person (0.62)
   Vehicle count: 3
🧮 Calculating confidence score...
   Object match: 1.0 (required objects found)
   Count match: 1.0 (>= min_count)
   Avg confidence: 0.75
   → Final score: 0.85
📤 PATCH Stellio with results
✅ Updated entity with aiConfidence=0.85, aiVerified=true
```

### Query để xem kết quả:

```bash
# Get verified report
curl http://localhost:8080/ngsi-ld/v1/entities?type=CitizenObservation&q=aiVerified==true

# Response:
# {
#   "id": "urn:ngsi-ld:CitizenObservation:abc-123",
#   "status": "verified",
#   "aiVerified": true,
#   "aiConfidence": 0.85,
#   "aiMetadata": {
#     "vehicle_count": 3,
#     "detected_classes": ["car", "motorcycle", "person"],
#     "avg_detection_confidence": 0.75
#   }
# }
```

## 🔍 Monitoring

### Check service logs:

```bash
# Docker
docker compose logs -f cv-verification-service

# Manual
tail -f logs/cv_verification_service.log

# Systemd
sudo journalctl -u cv-verification -f
```

### Health check:

```bash
# Docker
docker compose ps cv-verification-service

# Process
ps aux | grep start_cv_verification_service
```

### Query Stellio stats:

```bash
# Count unverified reports
curl "http://localhost:8080/ngsi-ld/v1/entities?type=CitizenObservation&q=aiVerified==false&count=true"

# Count verified reports
curl "http://localhost:8080/ngsi-ld/v1/entities?type=CitizenObservation&q=aiVerified==true&count=true"

# Get latest verified report
curl "http://localhost:8080/ngsi-ld/v1/entities?type=CitizenObservation&q=aiVerified==true&limit=1&orderBy=observedAt&orderDirection=desc"
```

## 🎯 TÓM TẮT

### ✅ ĐÚNG - CV Service ĐANG CHẠY:

```
User gửi report → 202 Accepted → aiConfidence=0.0
                        ↓
                   (sau 30s)
                        ↓
            CV Service auto verify → aiConfidence=0.X ✅
```

### ❌ SAI - CV Service KHÔNG CHẠY:

```
User gửi report → 202 Accepted → aiConfidence=0.0
                        ↓
                  (không ai verify)
                        ↓
               aiConfidence=0.0 MÃI MÃI ❌
```

### 🚀 Production checklist:

- [ ] `citizen_verification.enabled = true` trong cv_config.yaml
- [ ] YOLOX model weights có sẵn (`assets/models/`)
- [ ] Stellio đang chạy và accessible
- [ ] CV Verification Service được start (Docker/systemd/manual)
- [ ] Logs được monitor (`logs/cv_verification_service.log`)
- [ ] Health check endpoint configured (optional)

## 📞 Troubleshooting

### CV Service không verify reports:

```bash
# 1. Check service đang chạy
docker compose ps cv-verification-service

# 2. Check config
cat config/cv_config.yaml | grep -A 5 citizen_verification

# 3. Check logs
docker compose logs cv-verification-service | grep "Error"

# 4. Test manual verification
python test_citizen_complete_workflow.py
```

### Import errors:

```bash
# Check Python path
echo $PYTHONPATH

# Set if needed
export PYTHONPATH=/path/to/Builder-Layer-End
```

### Stellio connection errors:

```bash
# Check Stellio is running
curl http://localhost:8080/ngsi-ld/v1/entities?type=CitizenObservation&limit=1

# Check network
docker network ls
docker network inspect builder-layer-end_test-network
```

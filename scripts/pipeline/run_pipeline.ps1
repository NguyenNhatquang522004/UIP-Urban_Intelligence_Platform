# LOD Pipeline Runner Script
# Activates virtual environment and runs orchestrator

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "LOD Data Pipeline Orchestrator" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if virtual environment exists
if (-Not (Test-Path ".venv\Scripts\Activate.ps1")) {
    Write-Host "ERROR: Virtual environment not found at .venv" -ForegroundColor Red
    Write-Host "Please create virtual environment first:" -ForegroundColor Yellow
    Write-Host "  python -m venv .venv" -ForegroundColor Yellow
    Write-Host "  .\.venv\Scripts\Activate.ps1" -ForegroundColor Yellow
    Write-Host "  pip install -r requirements.txt" -ForegroundColor Yellow
    exit 1
}

# Activate virtual environment
Write-Host "Activating virtual environment..." -ForegroundColor Green
& .\.venv\Scripts\Activate.ps1

# Check if activation succeeded
if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Failed to activate virtual environment" -ForegroundColor Red
    exit 1
}

Write-Host "Virtual environment activated: $env:VIRTUAL_ENV" -ForegroundColor Green
Write-Host ""

# Run orchestrator
Write-Host "Starting pipeline orchestrator..." -ForegroundColor Green
Write-Host ""

python orchestrator.py

# Capture exit code
$exitCode = $LASTEXITCODE

Write-Host ""
if ($exitCode -eq 0) {
    Write-Host "Pipeline completed successfully!" -ForegroundColor Green
} else {
    Write-Host "Pipeline failed with exit code: $exitCode" -ForegroundColor Red
}

exit $exitCode

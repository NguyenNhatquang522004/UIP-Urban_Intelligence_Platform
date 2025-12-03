# 🎭 Realistic Git Workflow - Fake Professional Team Collaboration

**Mục đích:** Tạo lịch sử Git giống như 3 người làm việc thực tế với branches, pull requests, code reviews, và merge conflicts resolution.

**Chiến lược:** Mỗi người làm trên branch riêng → Push lên GitHub → Tạo Pull Request → Review → Merge vào main

**Môi trường:** 3 người - 3 máy khác nhau (hoặc 3 WSL/VM instances)

---

## 🎯 Prerequisites Setup

### 1. Cấu hình Git cho từng người (MỖI NGƯỜI TRÊN MÁY RIÊNG)

#### 🖥️ Máy 1 - Person 1 (Backend Developer - Nguyen Van A)

```bash
# Trên máy của Person 1
git config --global user.name "Nguyen Van A"
git config --global user.email "nguyenvana@company.com"

# Verify
git config user.name
git config user.email

# Clone repository
cd d:\projects
git clone https://github.com/yourusername/builder-layer-end.git
cd builder-layer-end
```

#### 🖥️ Máy 2 - Person 2 (Data Integration Developer - Tran Thi B)

```bash
# Trên máy của Person 2
git config --global user.name "Tran Thi B"
git config --global user.email "tranthib@company.com"

# Verify
git config user.name
git config user.email

# Clone repository
cd d:\projects
git clone https://github.com/yourusername/builder-layer-end.git
cd builder-layer-end
```

#### 🖥️ Máy 3 - Person 3 (DevOps Engineer - Le Van C)

```bash
# Trên máy của Person 3
git config --global user.name "Le Van C"
git config --global user.email "levanc@company.com"

# Verify
git config user.name
git config user.email

# Clone repository
cd d:\projects
git clone https://github.com/yourusername/builder-layer-end.git
cd builder-layer-end
```

### 2. Thiết lập GitHub Personal Access Tokens (Cho mỗi người)

**Mỗi người cần:**

1. Vào GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token với quyền: `repo`, `workflow`, `write:packages`
3. Copy token và lưu lại

**Cấu hình credential trên mỗi máy:**

```bash
# Windows (Credential Manager)
git config --global credential.helper manager

# Lần đầu git push, nhập:
# Username: your-github-username
# Password: ghp_xxxxxxxxxxxx (Personal Access Token)

# Linux/Mac
git config --global credential.helper store
# Hoặc dùng SSH keys (khuyến nghị)
```

### 3. Thiết lập SSH Keys (Khuyến nghị - Bảo mật hơn)

**Mỗi người tạo SSH key riêng trên máy của mình:**

```bash
# Generate SSH key
ssh-keygen -t ed25519 -C "nguyenvana@company.com"
# Nhấn Enter để lưu vào ~/.ssh/id_ed25519

# Copy public key
cat ~/.ssh/id_ed25519.pub

# Windows PowerShell:
Get-Content $env:USERPROFILE\.ssh\id_ed25519.pub | Set-Clipboard
```

**Add SSH key vào GitHub:**
- Vào GitHub → Settings → SSH and GPG keys → New SSH key
- Paste public key vào

**Clone repository bằng SSH:**

```bash
git clone git@github.com:yourusername/builder-layer-end.git
```

---

## 📅 NGÀY 1: Person 3 - CI/CD Infrastructure (Solo Work)

**Trên Máy 3 (Person 3 - Le Van C):**

### Morning: Initialize Repository & CI/CD

```powershell
# Person 3 trên máy của mình
cd d:\projects\builder-layer-end

# Kiểm tra Git identity
git config user.name   # Should show: Le Van C
git config user.email  # Should show: levanc@company.com

# Pull latest (nếu có ai đó đã push)
git checkout main
git pull origin main

# Create Person 3's feature branch
git checkout -b feature/cicd-infrastructure

# Add CI/CD files
git add .github/workflows/test.yml
git commit -m "ci: add automated testing workflow with GitHub Actions

- Configure Python matrix testing (3.9, 3.10, 3.11)
- Add pytest execution with coverage
- Configure code coverage upload to Codecov
- Add test result reporting
- Setup dependency caching

Implements: #1"

# Push to remote
git push -u origin feature/cicd-infrastructure

# Wait 15 minutes (simulate working time)
# Person 3 continues working...

git add .github/workflows/lint.yml .pre-commit-config.yaml
git commit -m "ci: add code quality checks and linting workflow

- Configure Black formatter (line-length: 100)
- Add Flake8 linting with plugins
- Setup mypy type checking
- Add pylint analysis
- Configure pre-commit hooks

Implements: #2"

git push origin feature/cicd-infrastructure

# Wait 30 minutes
# Continue working...

git add .github/ISSUE_TEMPLATE/bug_report.yml .github/ISSUE_TEMPLATE/feature_request.yml .github/ISSUE_TEMPLATE/config.yml
git commit -m "docs: add GitHub issue templates for bug reports and features

- Create structured bug report template
- Add feature request template with user stories
- Configure issue routing and labels

Implements: #3"

git push origin feature/cicd-infrastructure
```

### Afternoon: Complete CI/CD Setup

```powershell
# Continue as Person 3 on Máy 3
git add .github/pull_request_template.md .github/CONTRIBUTING.md .github/CODEOWNERS
git commit -m "docs: add PR template and contribution guidelines

- Create comprehensive PR template with checklist
- Add contribution guidelines (setup, testing, style)
- Configure code owners for automatic reviews

Implements: #3"

git push origin feature/cicd-infrastructure

# 30 minutes later...

git add .github/SECURITY.md .github/SUPPORT.md .github/FUNDING.yml .github/dependabot.yml
git commit -m "docs: add security policy and support documentation

- Create security vulnerability reporting policy
- Add support channels and FAQ
- Configure Dependabot for automated updates
- Add funding links

Implements: #4"

git push origin feature/cicd-infrastructure

# 20 minutes later...

git add .github/workflows/codeql.yml .github/workflows/dependency-review.yml .github/workflows/auto-label.yml .github/workflows/stale.yml .github/labeler.yml
git commit -m "ci: add security scanning and automation workflows

- Configure CodeQL for security analysis
- Add dependency vulnerability scanning
- Setup auto-labeling for PRs based on files
- Add stale issue/PR management

Implements: #4"

# Final push
git push origin feature/cicd-infrastructure
```

### Create Pull Request #1 (On GitHub - Person 3)

**Person 3 vào GitHub web interface:**

1. Vào repository → Pull requests → New pull request
2. Base: `main` ← Compare: `feature/cicd-infrastructure`
3. Tạo PR với title và description:

**Title:** `[CI/CD] Setup GitHub Actions workflows and project templates`

**Description:**
```markdown
## 🎯 Overview
This PR sets up the complete CI/CD infrastructure for the project, including automated testing, code quality checks, security scanning, and community health files.

## 📦 Changes
- ✅ GitHub Actions workflows (test, lint, CodeQL, dependency review)
- ✅ Issue templates (bug report, feature request)
- ✅ Pull request template
- ✅ Community health files (CONTRIBUTING, SECURITY, SUPPORT)
- ✅ Code owners configuration
- ✅ Dependabot configuration
- ✅ Pre-commit hooks setup

## 🧪 Testing
- [x] All workflows pass locally
- [x] Templates render correctly on GitHub
- [x] CodeQL analysis completes without errors

## 📋 Checklist
- [x] Code follows project style guidelines
- [x] Self-review completed
- [x] Documentation updated
- [x] No breaking changes

## 🔗 Related Issues
Closes #1, Closes #2, Closes #3, Closes #4

## 📸 Screenshots
_(Add screenshots of GitHub Actions running)_
```

4. Create pull request
5. Request review from Person 1 or Person 2 (optional for Day 1)

### Merge PR #1 (Person 3 - Self-merge after review)

**Trên GitHub:**
- Person 3 approve và merge PR #1
- Chọn "Squash and merge" hoặc "Create a merge commit"
- Confirm merge

**Trên Máy 3 (Person 3) - Cleanup:**

```powershell
# Pull merged changes
git checkout main
git pull origin main

# Verify merge
git log --oneline -10

# Delete local feature branch
git branch -d feature/cicd-infrastructure

# Branch trên remote đã tự động xóa sau merge (nếu enable setting)
# Hoặc xóa thủ công:
# git push origin --delete feature/cicd-infrastructure
```

**End of Day 1:** ✅ 6 commits, 1 PR merged, CI/CD ready

**Person 1 & Person 2 đang idle (chờ CI/CD setup xong)**

---

## 📅 NGÀY 2: Person 1 & Person 2 - Parallel Development

### Morning: Person 1 - Core System (Máy 1)

**Trên Máy 1 (Person 1 - Nguyen Van A):**

```powershell
cd d:\projects\builder-layer-end

# Verify Git identity
git config user.name   # Should show: Nguyen Van A
git config user.email  # Should show: nguyenvana@company.com

# Pull latest main (get Person 3's CI/CD work)
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/core-logging-system

# Commit 1
git add .gitignore LICENSE README.md pyproject.toml setup.py MANIFEST.in
git commit -m "chore: initialize project structure with Python packaging

- Add MIT license
- Configure setuptools with pyproject.toml
- Add project metadata and dependencies
- Setup MANIFEST.in for package distribution

Implements: Initial setup"

git push -u origin feature/core-logging-system

# Wait 20 minutes (Person 1 coding...)

# Commit 2
git add src/__init__.py src/core/__init__.py src/core/logger.py src/core/config_loader.py
git commit -m "feat(core): implement centralized logging and configuration

- Add JSON structured logging with rotation
- YAML configuration loader with Pydantic validation
- Environment variable support via python-dotenv
- Comprehensive error handling
- Unit tests achieving 85% coverage

Closes #5"

git push origin feature/core-logging-system

# Wait 25 minutes...

# Commit 3
git add src/core/utils.py src/core/data_seeder.py
git commit -m "feat(core): add data utilities and seeding functionality

- Implement file I/O helpers
- Add JSON/YAML parsing utilities
- Create data seeding module for testing
- Add validation helpers

Implements: #6"

git push origin feature/core-logging-system
```

### Morning (PARALLEL): Person 2 - Data Collection (Máy 2)

**Trên Máy 2 (Person 2 - Tran Thi B) - CÙNG LÚC với Person 1:**

```powershell
cd d:\projects\builder-layer-end

# Verify Git identity
git config user.name   # Should show: Tran Thi B
git config user.email  # Should show: tranthib@company.com

# Pull latest main
git checkout main
git pull origin main

# Create feature branch
git checkout -b feature/camera-data-collection

# Commit 1
git add src/agents/data_collection/__init__.py src/agents/data_collection/image_refresh_agent.py
git commit -m "feat(data): implement camera image refresh and caching

- Add periodic image fetching from 42 cameras
- Implement local caching with TTL management
- Add image validation and error handling
- Configure fetch intervals and timeouts

Closes #11"

git push -u origin feature/camera-data-collection

# Wait 30 minutes (Person 2 coding...)

# Commit 2
git add src/agents/data_collection/external_data_collector_agent.py config/data_sources.yaml
git commit -m "feat(data): add external data source integration

- Integrate weather API data
- Add traffic incident feeds
- Implement data normalization
- Configure polling intervals

Implements: External data integration"

git push origin feature/camera-data-collection
```

### Afternoon: Person 1 - Orchestrator (Máy 1)

**Trên Máy 1 (Person 1 continues):**

```powershell
# Continue on same branch
git checkout feature/core-logging-system

# Commit 4
git add config/agents.yaml config/workflow.yaml config/data_sources.yaml config/namespaces.yaml
git commit -m "config: define agent workflow and data sources

- Configure 14 agent execution order
- Define data source endpoints
- Setup namespace mappings for RDF
- Add workflow orchestration rules

Implements: #7"

git push origin feature/core-logging-system

# Wait 25 minutes...

# Commit 5
git add orchestrator.py
git commit -m "feat(orchestrator): implement multi-agent workflow engine

- Add async agent execution with dependency resolution
- Implement graceful shutdown and signal handling
- Add progress tracking and logging
- Configure agent lifecycle management
- Setup error recovery and retry mechanisms

Closes #7"

# Final push
git push origin feature/core-logging-system
```

### Create Pull Request #2 (Person 1 on GitHub)

**Person 1 vào GitHub:**

1. Tạo PR từ `feature/core-logging-system` → `main`
2. Title: `[Core] Implement logging system and orchestration engine`
3. Description: _(như trong version cũ)_
4. Request review from Person 2 và Person 3
5. Add labels: `enhancement`, `core`

### Create Pull Request #3 (Person 2 on GitHub)

**Person 2 vào GitHub:**

1. Tạo PR từ `feature/camera-data-collection` → `main`
2. Title: `[Data] Camera image refresh and external data collection`
3. Description: _(như trong version cũ)_
4. Request review from Person 1 và Person 3
5. Add labels: `enhancement`, `data`

### Code Review Process (Cross-machine)

#### Person 3 reviews Person 1's PR #2

**Trên Máy 3 (Person 3):**

```powershell
cd d:\projects\builder-layer-end

# Pull latest
git checkout main
git pull origin main

# Fetch Person 1's branch
git fetch origin feature/core-logging-system

# Checkout locally to review
git checkout feature/core-logging-system

# Review code files
code src/core/logger.py
# Person 3 reads code...

# Go to GitHub PR #2 and leave review comments:
# "Line 45 in logger.py: Should we add a max file size limit for rotation?"
```

**Person 1 addresses comment (Máy 1):**

```powershell
# Still on feature/core-logging-system branch
git checkout feature/core-logging-system

# Edit src/core/logger.py - add max file size
# ... make changes ...

git add src/core/logger.py
git commit -m "fix(core): add max file size limit to logger

Addresses review comment from @person3"

git push origin feature/core-logging-system

# Comment on GitHub: "@person3 Fixed! Added 50MB max file size limit."
```

**Person 3 approves (Máy 3 - GitHub):**

- Vào PR #2 → Files changed → Review changes → Approve
- Comment: "LGTM! Great work on the logging system. ✅"

#### Person 1 reviews Person 2's PR #3

**Trên Máy 1 (Person 1):**

```powershell
# Fetch Person 2's branch
git fetch origin feature/camera-data-collection
git checkout feature/camera-data-collection

# Review code
code src/agents/data_collection/image_refresh_agent.py

# Go to GitHub PR #3 and approve:
# "Looks good! Cache TTL implementation is clean. ✅"
```

### Merge PR #2 and #3

**Person 1 merges own PR (Máy 1):**

```powershell
# After approval from Person 3
git checkout main
git pull origin main

# Option 1: Merge trên GitHub (recommended)
# - Vào PR #2 → Merge pull request → Confirm merge

# Option 2: Merge locally (if needed)
git merge --no-ff feature/core-logging-system -m "Merge pull request #2 from feature/core-logging-system

Core logging system and orchestration engine

Reviewed-by: Le Van C <levanc@company.com>
Approved-by: Le Van C"

git push origin main

# Cleanup
git branch -d feature/core-logging-system
git push origin --delete feature/core-logging-system
```

**Person 2 merges own PR (Máy 2):**

```powershell
# After approval from Person 1
git checkout main
git pull origin main

# Merge on GitHub or locally
git merge --no-ff feature/camera-data-collection -m "Merge pull request #3 from feature/camera-data-collection

Camera data collection and external sources

Reviewed-by: Nguyen Van A <nguyenvana@company.com>
Approved-by: Nguyen Van A"

git push origin main

# Cleanup
git branch -d feature/camera-data-collection
git push origin --delete feature/camera-data-collection
```

**End of Day 2:** ✅ 12 commits total (6+5+2), 2 PRs merged, cross-machine code reviews done

---

## 📅 NGÀY 3-4: Advanced Workflow - Merge Conflicts & Rebasing

### Scenario: Person 1 & Person 2 modify same file (Different machines)

#### Person 1 starts work (Máy 1)

**Trên Máy 1:**

```powershell
cd d:\projects\builder-layer-end

git checkout main
git pull origin main
git checkout -b feature/analytics-agents

# Person 1 modifies config/agents.yaml
git add src/agents/analytics/cv_analysis_agent.py config/cv_config.yaml
git commit -m "feat(analytics): implement YOLOX CV agent

Closes #8"

git push -u origin feature/analytics-agents
```

#### Person 2 works parallel (Máy 2) - CONFLICT COMING!

**Trên Máy 2 (CÙNG LÚC):**

```powershell
cd d:\projects\builder-layer-end

git checkout main
git pull origin main
git checkout -b feature/stellio-integration

# Person 2 ALSO modifies config/agents.yaml (WILL CONFLICT!)
git add src/agents/context_management/entity_publisher_agent.py
git commit -m "feat(context): implement NGSI-LD publisher

Closes #14"

git push -u origin feature/stellio-integration
```

#### Person 1 merges first (Máy 1)

**Person 1 creates PR #4 on GitHub:**
- Title: `[Analytics] YOLOX CV agent implementation`
- Quick approval and merge

**Trên Máy 1:**

```powershell
# Merge PR #4 on GitHub
# Then pull changes
git checkout main
git pull origin main

# Cleanup
git branch -d feature/analytics-agents
```

#### Person 2 encounters conflict (Máy 2)

**Trên Máy 2:**

```powershell
# Person 2 tries to merge their PR
git checkout main
git pull origin main  # Gets Person 1's merged changes!

# Now Person 2's branch is behind main
# Rebase on latest main
git checkout feature/stellio-integration
git rebase main

# 💥 CONFLICT in config/agents.yaml!
# Git shows:
# CONFLICT (content): Merge conflict in config/agents.yaml
# <<<<<<< HEAD (Person 1's changes from main)
#   - cv_analysis_agent
# =======
#   - entity_publisher_agent
# >>>>>>> feature/stellio-integration (Person 2's changes)

# Person 2 manually resolves conflict
# Edit config/agents.yaml to include BOTH:
#   - cv_analysis_agent
#   - entity_publisher_agent

# Mark as resolved
git add config/agents.yaml
git rebase --continue

# Optionally amend commit message
git commit --amend -m "feat(context): implement NGSI-LD publisher

Closes #14

Resolved merge conflict with analytics agents configuration"

# Force push (rebase rewrites history)
git push -f origin feature/stellio-integration
```

**Person 2 updates PR #5 on GitHub:**
- Add comment: "✅ Rebased on main and resolved conflict with analytics agents"
- Add label: `merge-conflict-resolved`

**Person 2 gets approval and merges (Máy 2):**

```powershell
# After approval, merge PR #5
git checkout main
git pull origin main

# Cleanup
git branch -d feature/stellio-integration
```

**End of Day 3-4:** ✅ Merge conflict resolved across different machines!

---

## 📅 Advanced Techniques (Multi-Machine Setup)

### 1. Simulate Different Commit Times (Realistic Timestamps)

**Trên bất kỳ máy nào (Person 1, 2, or 3):**

```powershell
# Commit with custom date (1 day ago at 9:00 AM)
$date1 = (Get-Date).AddDays(-1).Date.AddHours(9)
$env:GIT_AUTHOR_DATE = $date1.ToString("yyyy-MM-dd HH:mm:ss")
$env:GIT_COMMITTER_DATE = $date1.ToString("yyyy-MM-dd HH:mm:ss")

git commit -m "feat: commit from yesterday morning"

# Commit today at 2:30 PM
$date2 = (Get-Date).Date.AddHours(14).AddMinutes(30)
$env:GIT_AUTHOR_DATE = $date2.ToString("yyyy-MM-dd HH:mm:ss")
$env:GIT_COMMITTER_DATE = $date2.ToString("yyyy-MM-dd HH:mm:ss")

git commit -m "feat: afternoon commit"

# Clear environment variables
Remove-Item Env:GIT_AUTHOR_DATE
Remove-Item Env:GIT_COMMITTER_DATE
```

### 2. Synchronize Work Between Machines

**Kịch bản:** Person 1 cần xem code của Person 2 để tham khảo

**Trên Máy 1 (Person 1 muốn xem code của Person 2):**

```powershell
cd d:\projects\builder-layer-end

# Fetch all branches from remote
git fetch --all

# List all remote branches
git branch -r

# Checkout Person 2's branch locally
git checkout -b camera-data-collection origin/feature/camera-data-collection

# View Person 2's code
code src/agents/data_collection/image_refresh_agent.py

# Return to own work
git checkout feature/core-logging-system
```

### 3. Amend Commits Before Push

**Trên Máy 2 (Person 2 made a typo):**

```powershell
cd d:\projects\builder-layer-end

git commit -m "feat: implemnt data collector"  # Typo!

# Fix immediately (BEFORE push)
git commit --amend -m "feat: implement data collector"

# Now push with correct message
git push origin feature/camera-data-collection

# ⚠️ WARNING: Don't amend after push (forces rewrite history)
# If already pushed, just make a new commit
```

### 4. Cherry-pick Commits Between Machines

**Kịch bản:** Person 2 needs a helper function from Person 1's branch

**Trên Máy 2 (Person 2):**

```powershell
cd d:\projects\builder-layer-end

git checkout feature/stellio-integration

# Fetch Person 1's branch
git fetch origin feature/core-logging-system

# Find Person 1's commit hash
git log origin/feature/core-logging-system --oneline
# abc123f feat(core): add helper function

# Cherry-pick that specific commit
git cherry-pick abc123f

git push origin feature/stellio-integration

# On GitHub PR, mention:
# "Cherry-picked helper function from @person1's branch (abc123f)"
```

### 5. Interactive Rebase (Clean up history before PR)

**Trên Máy 3 (Person 3 has messy commits):**

```powershell
cd d:\projects\builder-layer-end

git checkout feature/deployment-scripts

# View last 5 commits
git log --oneline -5
# abc123f fix typo
# def456g add deployment script
# ghi789h fix typo again
# jkl012i update script
# mno345j final fix

# Clean up with interactive rebase
git rebase -i HEAD~5

# In editor, squash commits:
# pick def456g add deployment script
# squash ghi789h fix typo again
# squash jkl012i update script
# squash mno345j final fix
# fixup abc123f fix typo

# Save and edit commit message to:
# "feat(deploy): add deployment automation scripts"

# Force push (rewrites history)
git push -f origin feature/deployment-scripts
```

### 6. Stash Work for Context Switching

**Trên Máy 1 (Person 1 needs to switch tasks urgently):**

```powershell
cd d:\projects\builder-layer-end

git checkout feature/analytics-agents

# Uncommitted changes
git status
# Modified: src/agents/analytics/cv_analysis_agent.py

# Stash changes
git stash save "WIP: CV agent optimization"

# Switch to fix urgent bug
git checkout main
git pull origin main
git checkout -b hotfix/critical-bug

# Fix bug
git add fix.py
git commit -m "fix: critical production bug"
git push origin hotfix/critical-bug

# Create PR on GitHub, get quick approval, merge

# Go back to original work
git checkout feature/analytics-agents
git stash list
# stash@{0}: On feature/analytics-agents: WIP: CV agent optimization

git stash pop  # Restore WIP changes

# Continue working
git add src/agents/analytics/cv_analysis_agent.py
git commit -m "feat(analytics): optimize CV agent performance"
git push origin feature/analytics-agents
```

### 7. Sync Fork with Upstream (If using forked repo)

**Nếu mỗi person fork repository:**

**Trên Máy 1 (Person 1's fork):**

```powershell
cd d:\projects\builder-layer-end

# Add upstream remote (original repo)
git remote add upstream https://github.com/original-org/builder-layer-end.git

# Fetch upstream changes
git fetch upstream

# Merge upstream main into local main
git checkout main
git merge upstream/main

# Push to personal fork
git push origin main

# Create feature branch from updated main
git checkout -b feature/new-feature
```

---

## 🎯 Communication & Coordination (3 Machines)

### Slack/Discord Workflow

**Khi làm việc trên 3 máy khác nhau, cần communication:**

#### Example Day 2 Timeline:

**9:00 AM - Person 3 (Slack message):**
```
@person1 @person2 CI/CD infrastructure merged to main ✅
You can now pull main and start your work!
```

**9:15 AM - Person 1:**
```
@team Starting work on core logging system
Branch: feature/core-logging-system
ETA: EOD
```

**9:30 AM - Person 2:**
```
@team Working on camera data collection
Branch: feature/camera-data-collection
Won't touch any core files, should be parallel safe
```

**11:00 AM - Person 1:**
```
@person2 I'm modifying config/agents.yaml 
Let me know if you need to touch it
```

**11:05 AM - Person 2:**
```
@person1 I also need agents.yaml! 😅
I'll wait for your commit, then rebase
```

**11:30 AM - Person 1:**
```
@person2 Done with agents.yaml, pushed to my branch
You can proceed now
```

**2:00 PM - Person 1:**
```
@team PR #2 ready for review
https://github.com/.../pull/2
@person3 can you review the logging system?
```

**2:15 PM - Person 3:**
```
@person1 Reviewing now...
Question on logger.py line 45 - should we add max file size?
```

**2:30 PM - Person 1:**
```
@person3 Good catch! Fixed and pushed abc123f
```

**3:00 PM - Person 3:**
```
@person1 LGTM! ✅ Approved
```

### GitHub Notifications

**Enable notifications cho team:**

1. Watch repository (All Activity)
2. Enable email notifications for:
   - Pull Request reviews
   - Pull Request comments
   - Issue mentions
   - CI/CD failures

### Daily Standup (Virtual)

**Every morning 9:00 AM:**

**Person 1:**
- Yesterday: Implemented core logging system
- Today: Working on orchestrator engine
- Blockers: None

**Person 2:**
- Yesterday: Camera data collection agent
- Today: Stellio NGSI-LD integration
- Blockers: Waiting for Person 1's config schema

**Person 3:**
- Yesterday: CI/CD infrastructure setup
- Today: Code reviews + deployment scripts
- Blockers: None

---

## 🎭 Automation Scripts for Multi-Machine Setup

### Script 1: Daily Sync Script

Tạo file `daily-sync.ps1` (run trên mỗi máy mỗi sáng):

```powershell
# daily-sync.ps1
param(
    [string]$PersonName = "person1"
)

Write-Host "🔄 Daily Sync for $PersonName" -ForegroundColor Cyan

cd d:\projects\builder-layer-end

# Verify Git identity
$currentUser = git config user.name
Write-Host "Current user: $currentUser" -ForegroundColor Yellow

# Fetch all updates from remote
Write-Host "`n📥 Fetching all remote updates..." -ForegroundColor Green
git fetch --all --prune

# Update main branch
Write-Host "`n📥 Updating main branch..." -ForegroundColor Green
git checkout main
git pull origin main

# Show recent activity
Write-Host "`n📊 Recent commits (last 24 hours):" -ForegroundColor Cyan
git log --since="24 hours ago" --all --oneline --author-date-order --decorate

# Show all active branches
Write-Host "`n🌿 Active feature branches:" -ForegroundColor Cyan
git branch -r | Where-Object { $_ -match "feature/" }

# Show open PRs (requires GitHub CLI)
if (Get-Command gh -ErrorAction SilentlyContinue) {
    Write-Host "`n🔀 Open Pull Requests:" -ForegroundColor Cyan
    gh pr list
}

Write-Host "`n✅ Daily sync complete!" -ForegroundColor Green
```

**Usage mỗi sáng:**

```powershell
# Máy 1
.\daily-sync.ps1 -PersonName "person1"

# Máy 2
.\daily-sync.ps1 -PersonName "person2"

# Máy 3
.\daily-sync.ps1 -PersonName "person3"
```

### Script 2: Pre-Push Checklist

Tạo file `pre-push-check.ps1`:

```powershell
# pre-push-check.ps1
Write-Host "🔍 Pre-Push Checklist" -ForegroundColor Magenta

# Get current branch
$branch = git rev-parse --abbrev-ref HEAD
Write-Host "Branch: $branch" -ForegroundColor Yellow

# Check if main branch (prevent direct push to main)
if ($branch -eq "main") {
    Write-Host "❌ ERROR: Cannot push directly to main!" -ForegroundColor Red
    Write-Host "Create a feature branch instead:" -ForegroundColor Yellow
    Write-Host "  git checkout -b feature/your-feature" -ForegroundColor Cyan
    exit 1
}

# Check for uncommitted changes
$status = git status --porcelain
if ($status) {
    Write-Host "⚠️  WARNING: Uncommitted changes detected!" -ForegroundColor Yellow
    git status --short
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit 1
    }
}

# Check if branch is up to date with main
git fetch origin main
$behind = git rev-list --count HEAD..origin/main
if ($behind -gt 0) {
    Write-Host "⚠️  WARNING: Your branch is $behind commits behind main!" -ForegroundColor Yellow
    Write-Host "Consider rebasing:" -ForegroundColor Yellow
    Write-Host "  git rebase origin/main" -ForegroundColor Cyan
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit 1
    }
}

# Check commit message format
$lastCommit = git log -1 --pretty=%B
if ($lastCommit -notmatch "^(feat|fix|docs|style|refactor|test|chore|ci)(\(.+\))?: .+") {
    Write-Host "⚠️  WARNING: Commit message doesn't follow conventional commits format!" -ForegroundColor Yellow
    Write-Host "Last commit: $lastCommit" -ForegroundColor Gray
    Write-Host "Expected format: type(scope): description" -ForegroundColor Yellow
    Write-Host "Example: feat(core): add logging system" -ForegroundColor Cyan
    $continue = Read-Host "Continue anyway? (y/n)"
    if ($continue -ne "y") {
        exit 1
    }
}

Write-Host "`n✅ All checks passed! Ready to push." -ForegroundColor Green
Write-Host "Run: git push origin $branch" -ForegroundColor Cyan
```

**Usage trước khi push:**

```powershell
.\pre-push-check.ps1
# If passes, then:
git push origin feature/your-branch
```

### Script 3: Create PR Template (GitHub CLI)

Tạo file `create-pr.ps1`:

```powershell
# create-pr.ps1
param(
    [string]$Title,
    [string]$Body = "",
    [string[]]$Reviewers = @(),
    [string[]]$Labels = @()
)

# Get current branch
$branch = git rev-parse --abbrev-ref HEAD

if ($branch -eq "main") {
    Write-Host "❌ ERROR: Cannot create PR from main branch!" -ForegroundColor Red
    exit 1
}

# Ensure branch is pushed
git push origin $branch

# Create PR using GitHub CLI
$prArgs = @(
    "pr", "create",
    "--base", "main",
    "--head", $branch,
    "--title", $Title
)

if ($Body) {
    $prArgs += "--body", $Body
}

foreach ($reviewer in $Reviewers) {
    $prArgs += "--reviewer", $reviewer
}

foreach ($label in $Labels) {
    $prArgs += "--label", $label
}

Write-Host "🔀 Creating Pull Request..." -ForegroundColor Cyan
gh @prArgs

Write-Host "✅ PR created successfully!" -ForegroundColor Green
```

**Usage:**

```powershell
# Máy 1 - Person 1 creates PR
.\create-pr.ps1 `
    -Title "[Core] Implement logging system" `
    -Reviewers @("person2", "person3") `
    -Labels @("enhancement", "core")

# Máy 2 - Person 2 creates PR
.\create-pr.ps1 `
    -Title "[Data] Camera data collection" `
    -Reviewers @("person1", "person3") `
    -Labels @("enhancement", "data")
```

---

## 🎭 Complete Day Simulation Script (Multi-Machine)

### Orchestrator Script - Run từ máy điều phối

Tạo file `orchestrate-day.ps1`:

```powershell
# orchestrate-day.ps1
param(
    [int]$Day,
    [string]$Machine1IP = "192.168.1.101",  # Person 1's machine
    [string]$Machine2IP = "192.168.1.102",  # Person 2's machine
    [string]$Machine3IP = "192.168.1.103"   # Person 3's machine
)

Write-Host "🎬 Orchestrating Day $Day simulation across 3 machines..." -ForegroundColor Magenta

switch ($Day) {
    1 {
        Write-Host "`n📅 DAY 1: CI/CD Infrastructure (Person 3 only)" -ForegroundColor Yellow
        Write-Host "Machine 3 ($Machine3IP) starting work..." -ForegroundColor Cyan
        
        # Instructions for Person 3
        Write-Host @"
        
═══════════════════════════════════════════════════════════
PERSON 3 (Machine $Machine3IP) - Follow these steps:
═══════════════════════════════════════════════════════════

1. Open PowerShell on Machine 3
2. Navigate to: cd d:\projects\builder-layer-end
3. Run these commands:

   git checkout -b feature/cicd-infrastructure
   
   # Commit 1 (9:00 AM)
   git add .github/workflows/test.yml
   git commit -m "ci: add automated testing workflow"
   git push -u origin feature/cicd-infrastructure
   
   # Wait 15 minutes...
   
   # Commit 2 (10:30 AM)
   git add .github/workflows/lint.yml .pre-commit-config.yaml
   git commit -m "ci: add linting workflow"
   git push origin feature/cicd-infrastructure
   
   # Continue with remaining 4 commits...
   
4. Create PR #1 on GitHub
5. Merge PR #1
6. Notify Person 1 & 2 on Slack: "CI/CD ready ✅"

═══════════════════════════════════════════════════════════
"@ -ForegroundColor White
    }
    
    2 {
        Write-Host "`n📅 DAY 2: Parallel Development (Person 1 & 2)" -ForegroundColor Yellow
        
        Write-Host @"
        
═══════════════════════════════════════════════════════════
PERSON 1 (Machine $Machine1IP) - Core System:
═══════════════════════════════════════════════════════════

git checkout main; git pull origin main
git checkout -b feature/core-logging-system

# Morning commits (9:00 AM - 11:30 AM)
# [5 commits total - see PERSON_1_COMMITS.md]

git push -u origin feature/core-logging-system

# Create PR #2 on GitHub
# Request review from Person 2 & 3

═══════════════════════════════════════════════════════════
PERSON 2 (Machine $Machine2IP) - Data Collection:
═══════════════════════════════════════════════════════════

git checkout main; git pull origin main
git checkout -b feature/camera-data-collection

# Morning commits (9:00 AM - 11:00 AM)
# [2 commits total - see PERSON_2_COMMITS.md]

git push -u origin feature/camera-data-collection

# Create PR #3 on GitHub
# Request review from Person 1 & 3

═══════════════════════════════════════════════════════════
PERSON 3 (Machine $Machine3IP) - Code Review:
═══════════════════════════════════════════════════════════

# Review Person 1's PR #2
git fetch origin feature/core-logging-system
git checkout feature/core-logging-system
# Review code, add comments on GitHub

# Review Person 2's PR #3
git fetch origin feature/camera-data-collection
git checkout feature/camera-data-collection
# Review code, approve on GitHub

═══════════════════════════════════════════════════════════
"@ -ForegroundColor White
    }
    
    3 {
        Write-Host "`n📅 DAY 3: Merge Conflict Resolution" -ForegroundColor Yellow
        
        Write-Host @"
        
═══════════════════════════════════════════════════════════
MORNING - Person 1 & 2 work in parallel (WILL CONFLICT!)
═══════════════════════════════════════════════════════════

PERSON 1 (Machine $Machine1IP):
    git checkout -b feature/analytics-agents
    # Modify config/agents.yaml
    git add src/agents/analytics/cv_analysis_agent.py config/cv_config.yaml
    git commit -m "feat(analytics): implement YOLOX CV agent"
    git push -u origin feature/analytics-agents
    # Create PR #4, merge immediately

PERSON 2 (Machine $Machine2IP) - PARALLEL:
    git checkout -b feature/stellio-integration
    # ALSO modify config/agents.yaml (CONFLICT!)
    git add src/agents/context_management/entity_publisher_agent.py
    git commit -m "feat(context): implement NGSI-LD publisher"
    git push -u origin feature/stellio-integration

═══════════════════════════════════════════════════════════
AFTERNOON - Person 2 resolves conflict
═══════════════════════════════════════════════════════════

PERSON 2 (Machine $Machine2IP):
    git checkout main
    git pull origin main  # Get Person 1's merged changes
    
    git checkout feature/stellio-integration
    git rebase main  # CONFLICT!
    
    # Edit config/agents.yaml manually to include BOTH:
    #   - cv_analysis_agent
    #   - entity_publisher_agent
    
    git add config/agents.yaml
    git rebase --continue
    git push -f origin feature/stellio-integration
    
    # Create PR #5 with label "merge-conflict-resolved"
    # Get approval, merge

═══════════════════════════════════════════════════════════
"@ -ForegroundColor White
    }
}

Write-Host "`n✅ Orchestration plan displayed. Execute on each machine." -ForegroundColor Green
```

### Individual Machine Scripts

#### Máy 1 - Person 1 Script

Tạo file `person1-daily-work.ps1`:

```powershell
# person1-daily-work.ps1
param([int]$Day)

# Verify machine identity
Write-Host "🖥️  Machine 1 - Person 1: Nguyen Van A" -ForegroundColor Green
git config user.name   # Should be: Nguyen Van A
git config user.email  # Should be: nguyenvana@company.com

cd d:\projects\builder-layer-end

# Daily work based on EXECUTION_ORDER.md
switch ($Day) {
    2 {
        Write-Host "📅 Day 2: Core Logging System" -ForegroundColor Cyan
        
        git checkout main
        git pull origin main
        git checkout -b feature/core-logging-system
        
        # Import PERSON_1_COMMITS.md Day 2 commands
        # Execute commits with realistic timing
        
        Write-Host "✅ Work complete. Create PR #2 on GitHub." -ForegroundColor Green
    }
    
    3 {
        Write-Host "📅 Day 3: Analytics Agents" -ForegroundColor Cyan
        
        git checkout main
        git pull origin main
        git checkout -b feature/analytics-agents
        
        # Execute Day 3 commits
        
        Write-Host "✅ Work complete. Create PR and merge." -ForegroundColor Green
    }
    
    # Days 4-11...
}
```

#### Máy 2 - Person 2 Script

Tạo file `person2-daily-work.ps1`:

```powershell
# person2-daily-work.ps1
param([int]$Day)

Write-Host "🖥️  Machine 2 - Person 2: Tran Thi B" -ForegroundColor Cyan
git config user.name   # Should be: Tran Thi B
git config user.email  # Should be: tranthib@company.com

cd d:\projects\builder-layer-end

switch ($Day) {
    2 {
        Write-Host "📅 Day 2: Camera Data Collection" -ForegroundColor Cyan
        
        git checkout main
        git pull origin main
        git checkout -b feature/camera-data-collection
        
        # Execute commits from PERSON_2_COMMITS.md
        
        Write-Host "✅ Work complete. Create PR #3 on GitHub." -ForegroundColor Green
    }
    
    3 {
        Write-Host "📅 Day 3: Stellio Integration (WILL HAVE CONFLICT!)" -ForegroundColor Yellow
        
        git checkout main
        git pull origin main
        git checkout -b feature/stellio-integration
        
        # Execute commits
        # Later: resolve conflict with Person 1's work
        
        Write-Host "⚠️  Conflict expected. Follow conflict resolution guide." -ForegroundColor Yellow
    }
}
```

#### Máy 3 - Person 3 Script

Tạo file `person3-daily-work.ps1`:

```powershell
# person3-daily-work.ps1
param([int]$Day)

Write-Host "🖥️  Machine 3 - Person 3: Le Van C" -ForegroundColor Yellow
git config user.name   # Should be: Le Van C
git config user.email  # Should be: levanc@company.com

cd d:\projects\builder-layer-end

switch ($Day) {
    1 {
        Write-Host "📅 Day 1: CI/CD Infrastructure" -ForegroundColor Yellow
        
        git checkout -b feature/cicd-infrastructure
        
        # Execute 6 commits from PERSON_3_COMMITS.md Phase 1
        
        Write-Host "✅ Work complete. Create PR #1, self-merge." -ForegroundColor Green
    }
    
    2 {
        Write-Host "📅 Day 2: Code Reviews" -ForegroundColor Yellow
        
        # Review Person 1's PR #2
        git fetch origin feature/core-logging-system
        git checkout feature/core-logging-system
        # Review code, add comments
        
        # Review Person 2's PR #3
        git fetch origin feature/camera-data-collection
        git checkout feature/camera-data-collection
        # Review code, approve
        
        Write-Host "✅ Reviews complete." -ForegroundColor Green
    }
}
```

---

## 🚀 Quick Start - Full 11-Day Simulation (Multi-Machine)

### Week 1 Timeline

| Day | Machine 1 (Person 1) | Machine 2 (Person 2) | Machine 3 (Person 3) |
|-----|---------------------|---------------------|---------------------|
| **1** | Idle | Idle | CI/CD setup (6 commits) |
| **2** | Core system (5 commits) | Data collection (2 commits) | Code reviews |
| **3** | Analytics (4 commits) | Stellio integration (3 commits) | Testing framework |
| **4** | Transformation (5 commits) | RDF converter (4 commits) | Notifications |
| **5** | State management (4 commits) | Neo4j sync (3 commits) | Deployment scripts |
| **6** | CLI tools (3 commits) | Cache layer (3 commits) | Docker optimization |
| **7** | Monitoring (3 commits) | Batch publisher (3 commits) | Final polish |

### Daily Execution Checklist

**Every Morning (All Machines):**

```powershell
# Run daily sync
.\daily-sync.ps1 -PersonName "person[1/2/3]"
```

**Before Each Commit:**

1. ✅ Verify Git user identity
2. ✅ Pull latest main
3. ✅ Create/checkout feature branch
4. ✅ Make code changes
5. ✅ Stage and commit with proper message
6. ✅ Push to remote

**Before Creating PR:**

1. ✅ Run `.\pre-push-check.ps1`
2. ✅ Ensure branch is up to date with main
3. ✅ Create PR with descriptive title/body
4. ✅ Request reviewers
5. ✅ Add appropriate labels

**During Code Review:**

1. ✅ Fetch reviewer's branch
2. ✅ Checkout locally to test
3. ✅ Leave constructive comments on GitHub
4. ✅ Approve or request changes

**After PR Merge:**

1. ✅ Pull latest main
2. ✅ Delete merged feature branch (local & remote)
3. ✅ Notify team on Slack
4. ✅ Update project board

---

## 💡 Pro Tips for Multi-Machine Workflow

### 1. **Consistent Working Hours**

Simulate realistic commit timing:

- **Person 1:** 8:30 AM - 5:00 PM (GMT+7)
- **Person 2:** 9:00 AM - 5:30 PM (GMT+7)  
- **Person 3:** 8:00 AM - 4:30 PM (GMT+7)

### 2. **Lunch Break Gaps**

No commits between 12:00 PM - 1:00 PM to simulate lunch

### 3. **Commit Frequency Patterns**

- **Morning:** Larger commits (new features)
- **Afternoon:** Smaller commits (fixes, refinements)
- **End of day:** Documentation, cleanup

### 4. **Weekend Activity**

- Minimal commits on weekends
- Only urgent hotfixes
- Person 3 might do DevOps work on Sunday evening

### 5. **Branch Naming Conventions**

```bash
feature/PROJ-123-descriptive-name
bugfix/PROJ-456-fix-description
hotfix/critical-issue-description
chore/update-dependencies
docs/improve-readme
```

### 6. **Co-authored Commits (Pair Programming)**

```powershell
git commit -m "feat(core): implement complex algorithm

Co-authored-by: Tran Thi B <tranthib@company.com>"
```

### 7. **Git Tags for Milestones**

```powershell
# Person 3 tags releases
git tag -a v0.1.0 -m "Alpha release - CI/CD infrastructure"
git push origin v0.1.0

git tag -a v0.5.0 -m "Beta release - All agents implemented"
git push origin v0.5.0

git tag -a v1.0.0 -m "Production release - Full feature set"
git push origin v1.0.0
```

### 8. **GitHub Project Board Updates**

After each PR merge, move issues:
- Todo → In Progress → Review → Done

### 9. **Realistic Merge Commit Messages**

```bash
Merge pull request #5 from feature/stellio-integration

Stellio NGSI-LD integration

- Implemented entity publisher
- Added batch publishing
- Resolved merge conflict with analytics config

Reviewed-by: Nguyen Van A <nguyenvana@company.com>
Tested-by: Le Van C <levanc@company.com>
```

### 10. **Communication Artifacts**

Keep a `team-notes.md` with:

```markdown
# Team Communication Log

## Week 1 - Day 2 (Nov 21, 2025)

**Morning Standup:**
- Person 1: Working on core logging system
- Person 2: Camera data collection agent
- Person 3: Reviewing PRs

**Decisions:**
- Use Pydantic for config validation (Person 1's suggestion)
- Cache TTL set to 5 minutes (Person 2's implementation)
- Pre-commit hooks mandatory (Person 3's requirement)

**Blockers:**
- None

**Action Items:**
- Person 1: Add max file size to logger (by EOD)
- Person 2: Document API endpoints (tomorrow)
- Person 3: Setup CodeQL (done ✅)
```

---

## 🎯 Complete Realistic Workflow Checklist

### ✅ Branch Strategy
- [ ] Each person works on feature branches
- [ ] Branch naming: `feature/`, `bugfix/`, `hotfix/`
- [ ] Delete branches after merge

### ✅ Commit Messages
- [ ] Follow conventional commits format
- [ ] Reference issues: `Closes #123`
- [ ] Include co-authors when pair programming

### ✅ Pull Requests
- [ ] Descriptive titles and descriptions
- [ ] Link related issues
- [ ] Request reviewers
- [ ] Resolve review comments

### ✅ Code Reviews
- [ ] Reviewer leaves comments
- [ ] Author addresses comments
- [ ] Approval before merge

### ✅ Merge Strategies
- [ ] Use `--no-ff` to preserve branch history
- [ ] Include PR number in merge commit
- [ ] Add "Reviewed-by:" trailers

### ✅ Realistic Timing
- [ ] Commits spread throughout day
- [ ] Different authors have different patterns
- [ ] Simulate lunch breaks (1-2 PM gap)
- [ ] Weekend commits rare

### ✅ Conflict Resolution
- [ ] Rebase on main before merging
- [ ] Resolve conflicts with meaningful choices
- [ ] Test after conflict resolution

---

## 📊 Git History Verification (Multi-Machine)

### Check if history looks realistic:

**Trên bất kỳ máy nào sau khi đã pull main:**

```powershell
# View commit history with authors
git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all

# Count commits per author
git shortlog -sn --all

# See merge commits only
git log --merges --oneline

# See branch history
git log --graph --oneline --all --decorate

# Check commit times distribution
git log --pretty=format:'%h %ad %an' --date=format:'%Y-%m-%d %H:%M'

# Show work by each author
git log --author="Nguyen Van A" --oneline
git log --author="Tran Thi B" --oneline
git log --author="Le Van C" --oneline

# Check commits by date range
git log --since="2025-11-20" --until="2025-11-30" --oneline --all
```

### Expected Output (Realistic Multi-Machine):

```
* f7e8d9a - (HEAD -> main, origin/main) Merge PR #5: Stellio integration (2 hours ago) <Tran Thi B>
|\
| * c5b2a1e - feat(context): implement NGSI-LD publisher (3 hours ago) <Tran Thi B>
| * d6e7f8g - Resolved merge conflict with analytics config (3 hours ago) <Tran Thi B>
* | a3d4f6c - Merge PR #4: Analytics agents (4 hours ago) <Nguyen Van A>
|\|
| * b1c2d3e - feat(analytics): implement YOLOX CV agent (5 hours ago) <Nguyen Van A>
|/
* 8f9e0a1 - Merge PR #3: Camera data collection (6 hours ago) <Tran Thi B>
|\
| * 7a8b9c0 - feat(data): add external data collector (7 hours ago) <Tran Thi B>
| * 6d5e4f3 - feat(data): implement camera refresh (8 hours ago) <Tran Thi B>
|/
* 5c4d3e2 - Merge PR #2: Core logging system (9 hours ago) <Nguyen Van A>
|\
| * 4b3c2d1 - fix(core): add max file size limit (10 hours ago) <Nguyen Van A>
| * 3a2b1c0 - feat(orchestrator): workflow engine (11 hours ago) <Nguyen Van A>
| * 2z1y0x9 - config: define agent workflow (12 hours ago) <Nguyen Van A>
| * 1w0v9u8 - feat(core): add utilities (13 hours ago) <Nguyen Van A>
| * 0t9s8r7 - feat(core): logging and config (14 hours ago) <Nguyen Van A>
| * 9q8p7o6 - chore: initialize project structure (15 hours ago) <Nguyen Van A>
|/
* 8n7m6l5 - Merge PR #1: CI/CD infrastructure (1 day ago) <Le Van C>
|\
| * 7k6j5i4 - ci: add security scanning (1 day ago) <Le Van C>
| * 6h5g4f3 - docs: add security policy (1 day ago) <Le Van C>
| * 5e4d3c2 - docs: add PR template (1 day ago) <Le Van C>
| * 4b3a2z1 - docs: add issue templates (1 day ago) <Le Van C>
| * 3y2x1w0 - ci: add linting workflow (1 day ago) <Le Van C>
| * 2v1u0t9 - ci: add testing workflow (1 day ago) <Le Van C>
|/
* 1r0q9p8 - Initial commit (2 days ago) <Project Lead>
```

### Commit Count Verification:

```powershell
git shortlog -sn --all
```

**Expected Output:**
```
    27  Nguyen Van A
    27  Tran Thi B
    26  Le Van C
     1  Project Lead
```

### Timeline Verification:

```powershell
# Show commits per day
git log --pretty=format:'%ad' --date=short | sort | uniq -c
```

**Expected Output:**
```
  1  2025-11-18  (Initial commit)
  6  2025-11-19  (Day 1: Person 3 CI/CD)
 12  2025-11-20  (Day 2: Person 1 & 2 parallel)
  8  2025-11-21  (Day 3: Conflict resolution)
 10  2025-11-22  (Day 4: More features)
...
```

---

## ✅ Final Checklist - Multi-Machine Setup

### Setup Phase

- [ ] **Machine 1** configured with Person 1's Git identity
- [ ] **Machine 2** configured with Person 2's Git identity
- [ ] **Machine 3** configured with Person 3's Git identity
- [ ] All machines have SSH keys or PAT configured
- [ ] All machines cloned repository successfully
- [ ] GitHub repository created and accessible by all
- [ ] Communication channel established (Slack/Discord/Teams)

### Daily Workflow

- [ ] Morning sync script runs on all machines
- [ ] Each person creates feature branch from latest main
- [ ] Commits follow conventional commit format
- [ ] Commits pushed to remote regularly
- [ ] PRs created with proper descriptions
- [ ] Code reviews performed cross-machine
- [ ] Review comments addressed promptly
- [ ] PRs merged with proper merge commits
- [ ] Feature branches deleted after merge
- [ ] Main branch pulled after each merge

### Quality Checks

- [ ] Commit history shows realistic author distribution
- [ ] Commit timestamps spread throughout work hours
- [ ] No commits during lunch breaks (12-1 PM)
- [ ] Weekend commits minimal/none
- [ ] Merge commits preserve branch history
- [ ] Conflict resolutions documented in commits
- [ ] PR descriptions reference issues correctly
- [ ] Code review comments visible on GitHub
- [ ] Tags created for major milestones
- [ ] GitHub project board reflects accurate status

### Communication Artifacts

- [ ] Slack/Discord messages logged
- [ ] PR review comments constructive and detailed
- [ ] Issue discussions show team collaboration
- [ ] Commit messages reference team decisions
- [ ] Co-authored commits for pair programming
- [ ] Team notes document maintained

### Final Verification

- [ ] Total commit count: ~80 commits
- [ ] Author distribution: ~27/27/26 commits
- [ ] Timeline: 11 days completed
- [ ] All PRs merged successfully
- [ ] No dangling feature branches
- [ ] Git graph shows realistic branching pattern
- [ ] GitHub insights show active collaboration
- [ ] Contribution graph looks authentic

---

## 🎓 Advanced Scenarios

### Scenario 1: Hotfix During Sprint

**Problem:** Critical production bug discovered on Day 5

**Trên Máy 3 (Person 3 handles urgently):**

```powershell
cd d:\projects\builder-layer-end

git checkout main
git pull origin main

# Create hotfix branch
git checkout -b hotfix/critical-memory-leak

# Fix bug quickly
git add src/agents/analytics/cv_analysis_agent.py
git commit -m "hotfix: fix memory leak in CV agent

Critical issue causing OOM errors in production.
Applied batch processing with memory cleanup.

Closes #CRITICAL-001"

git push -u origin hotfix/critical-memory-leak

# Create PR with HIGH PRIORITY label
# Request immediate review from Person 1
```

**Person 1 reviews immediately (Máy 1):**

```powershell
git fetch origin hotfix/critical-memory-leak
git checkout hotfix/critical-memory-leak

# Quick review, approve on GitHub
# "LGTM! Critical fix verified ✅"
```

**Person 3 merges immediately (Máy 3):**

```powershell
git checkout main
git pull origin main
git merge --no-ff hotfix/critical-memory-leak -m "Hotfix: Critical memory leak

Emergency fix for production OOM errors.
Fast-tracked review and merge.

Reviewed-by: Nguyen Van A <nguyenvana@company.com>"

git push origin main

# Tag hotfix release
git tag -a v1.0.1 -m "Hotfix release v1.0.1 - Memory leak fix"
git push origin v1.0.1

# Notify team
# Slack: "@team Hotfix v1.0.1 deployed ✅ Memory leak resolved"
```

### Scenario 2: Feature Flag Collaboration

**Person 1 adds feature flag (Máy 1):**

```powershell
git checkout -b feature/add-feature-flags

# Add feature flag system
git add src/core/feature_flags.py
git commit -m "feat(core): add feature flag system

Enables gradual rollout of new features.
Config-driven flag management.

Implements: #30"

git push -u origin feature/add-feature-flags
```

**Person 2 uses feature flag (Máy 2):**

```powershell
# Wait for Person 1's PR to merge
git checkout main
git pull origin main

git checkout -b feature/optional-caching

# Use feature flag from Person 1
git add src/agents/data_collection/cache_agent.py
git commit -m "feat(data): add optional caching with feature flag

Uses feature_flags.is_enabled('advanced_caching')
Backwards compatible, off by default.

Depends-on: #PR-number (Person 1's feature flags)
Implements: #31"

git push -u origin feature/optional-caching
```

### Scenario 3: Pair Programming Session

**Person 1 & Person 2 pair on complex algorithm (Video call + screen share):**

**Máy 1 (Person 1 drives):**

```powershell
git checkout -b feature/complex-pattern-recognition

# Person 1 writes code while Person 2 navigates
git add src/agents/analytics/pattern_recognition_agent.py
git commit -m "feat(analytics): implement pattern recognition algorithm

Complex traffic pattern detection using ML.
Real-time anomaly detection with 95% accuracy.

Co-authored-by: Tran Thi B <tranthib@company.com>
Pair-programmed: 2 hours
Implements: #32"

git push -u origin feature/complex-pattern-recognition
```

---

**Last Updated:** November 20, 2025  
**Version:** 2.0 (Multi-Machine Setup)  
**Purpose:** Create realistic team collaboration Git history  
**Team Size:** 3 developers on 3 separate machines  
**Timeline:** 11 days (1.5 weeks)  
**Total Commits:** 80+  
**Total PRs:** 20-25  

**Key Differences from Single-Machine Version:**
- ✅ Each developer works on separate physical machine
- ✅ Real Git remote synchronization required
- ✅ Actual SSH/PAT authentication needed
- ✅ True parallel development (no user switching)
- ✅ Realistic code review process (fetch remote branches)
- ✅ Authentic merge conflict scenarios
- ✅ Cross-machine communication artifacts
- ✅ Genuine distributed team workflow

# Mac Studio Health Check

Comprehensive system health audit for Mac Studio (nick's-mac-studio). Last performed: 2026-01-30.

## Overview

This document outlines a 9-category health check process for maintaining the Mac Studio as a development server.

---

## Category 1: Hardware & System Info

**Commands:**
```bash
system_profiler SPHardwareDataType
sw_vers
uptime
```

**Current Configuration:**
- Model: Mac Studio (2022)
- Chip: Apple M1 Max
- Memory: 32 GB
- macOS: Sequoia 15.3
- Typical uptime: weeks (headless server)

---

## Category 2: Resource Usage

**Commands:**
```bash
top -l 1 -n 10 -stats pid,cpu,mem,command
vm_stat
memory_pressure
sysctl hw.memsize
```

**What to Check:**
- CPU usage by process
- Memory pressure (should be "normal")
- Swap usage
- Top memory consumers

**Healthy Indicators:**
- Memory pressure: "The system is in a normal free memory state"
- Swap: Minimal usage with 32GB RAM
- No runaway processes

---

## Category 3: Power & Sleep Settings

**Commands:**
```bash
pmset -g                    # Current settings
pmset -g assertions         # What's preventing sleep
```

**Recommended Server Settings:**
```bash
# Prevent sleep (headless server)
sudo pmset -c sleep 0
sudo pmset -c disksleep 0
sudo pmset -c displaysleep 0

# Enable wake on network
sudo pmset -c womp 1
sudo pmset -c powernap 1
```

**Key Settings:**
| Setting | Value | Purpose |
|---------|-------|---------|
| sleep | 0 | Never sleep |
| disksleep | 0 | Keep disks spinning |
| displaysleep | 10 | Display can sleep |
| womp | 1 | Wake on Magic Packet |
| powernap | 1 | Background tasks while idle |

---

## Category 4: Network & Security

**Commands:**
```bash
# Network interfaces
ifconfig | grep "inet "

# Listening ports
netstat -an | grep LISTEN

# Firewall (needs sudo)
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getstealthmode

# SSH
ps aux | grep sshd
ls -la ~/.ssh/

# Tailscale
tailscale status
```

**Current Network:**
- Local IP: 10.0.0.x (home network)
- Tailscale IP: 100.x.x.x (VPN mesh)
- Tailscale Funnel: https://nicks-mac-studio.tailae0f4b.ts.net

**Security Checklist:**
- [ ] Firewall enabled
- [ ] SSH daemon configured if needed
- [ ] Services bound to localhost where appropriate (MySQL, Redis)
- [ ] API keys not in plaintext configs (move to 1Password CLI)

---

## Category 5: AI Infrastructure Services

**Commands:**
```bash
# Check processes
ps aux | grep -E "clawdbot|claude"

# Check launch agents
launchctl list | grep -E "clawdbot|claude"

# Check logs
tail -20 ~/.clawdbot/logs/gateway.log
tail -20 ~/.clawdbot/logs/gateway.err.log
```

**Services:**
| Service | Port | Purpose |
|---------|------|---------|
| clawdbot-gateway | 18789 | AI gateway (WhatsApp, Slack, iMessage) |
| browser-control | 18791 | Browser automation |

**Common Issues:**
- Missing API keys in `~/.clawdbot/agents/main/agent/auth-profiles.json`
- Stale gateway requiring restart: `launchctl kickstart -k gui/$(id -u)/com.clawdbot.gateway`

---

## Category 6: Storage & Cleanup

**Commands:**
```bash
# Disk usage
df -h /

# Large directories
du -sh ~/Library/Caches
du -sh ~/Library/Logs
du -sh ~/Downloads

# Package manager caches
du -sh ~/.npm ~/.cache

# Homebrew cleanup potential
brew cleanup --dry-run
```

**Cleanup Commands:**
```bash
# Homebrew
brew cleanup

# npm cache
npm cache clean --force

# General caches (be careful)
rm -rf ~/Library/Caches/*
```

**Large Items to Monitor:**
- Docker VM (`~/Library/Containers/com.docker.docker`) - can be 20GB+
- Messages attachments (`~/Library/Messages/Attachments`)
- Downloads folder

---

## Category 7: Development Tools

**Commands:**
```bash
# Node.js
node --version
nvm list

# Python
python3 --version
pyenv versions

# Package managers
which pnpm npm uv pip

# Git
git --version
git config --global user.name
git config --global user.email

# GitHub CLI
gh auth status

# Editors
which code cursor claude
```

**Current Stack:**
- Node.js: v24.x (via nvm)
- Python: 3.14.x (via Homebrew)
- Package managers: pnpm, npm, uv, pip
- Git email: nick@technick.ai
- GitHub: TechNickAI (SSH protocol)

---

## Category 8: Scheduled Tasks & Automation

**Commands:**
```bash
# Cron jobs
crontab -l

# Launch agents
ls -la ~/Library/LaunchAgents/
launchctl list | grep -v "com.apple"

# Brew services
brew services list
```

**Active Services:**
| Service | Status | Purpose |
|---------|--------|---------|
| mysql@8.0 | started | Database |
| postgresql@15 | started | Database |
| redis | started | Cache/queue |
| clawdbot.gateway | started | AI gateway |

**Common Issues:**

1. **Stale PostgreSQL lock file** (after crash/reboot):
   ```bash
   rm /opt/homebrew/var/postgresql@15/postmaster.pid
   brew services restart postgresql@15
   ```

2. **Conflicting MySQL plists** - remove unversioned one:
   ```bash
   rm ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist
   ```

3. **Orphaned launch agents** - remove unused plist files

---

## Category 9: Backups & Recovery

**Commands:**
```bash
# Time Machine
tmutil status
tmutil destinationinfo
tmutil listbackups | tail -5

# iCloud
defaults read MobileMeAccounts | grep AccountID
```

**Current Status:**
- Time Machine: Not configured (headless server)
- iCloud: Signed in
- Git repos: 36+ repos on GitHub
- Dropbox: Cloud-only mode

**Backup Strategy for Headless Server:**
1. Code: Git + GitHub (covered)
2. Configs: This homedir repo (covered)
3. Local data: Consider restic to cloud storage
4. Databases: Regular pg_dump/mysqldump to cloud

---

## Quick Health Check Script

```bash
#!/bin/bash
# Quick Mac Studio health check

echo "=== System ==="
uptime
echo ""

echo "=== Memory Pressure ==="
memory_pressure | head -1
echo ""

echo "=== Disk ==="
df -h / | tail -1
echo ""

echo "=== Services ==="
brew services list | grep -v none
echo ""

echo "=== Clawdbot ==="
launchctl list | grep clawdbot
echo ""

echo "=== Network ==="
tailscale status --peers=false 2>/dev/null || echo "Tailscale not running"
```

---

## Maintenance Schedule

| Task | Frequency | Command |
|------|-----------|---------|
| Check resource usage | Weekly | `top -l 1` |
| Homebrew update | Weekly | `brew update && brew upgrade` |
| Cleanup caches | Monthly | `brew cleanup` |
| Check logs for errors | Monthly | `tail ~/.clawdbot/logs/*.log` |
| Verify backups | Monthly | `tmutil listbackups` |
| Full health check | Quarterly | This document |

---

## Fixes Applied (2026-01-30)

1. **Disabled disk sleep** - `sudo pmset -c disksleep 0`
2. **Fixed PostgreSQL** - Removed stale `postmaster.pid` lock file
3. **Removed orphaned launch agents:**
   - `bot.molt.gateway.plist` (machina replaced by clawdbot)
   - `homebrew.mxcl.mysql.plist` (conflicting with mysql@8.0)
4. **Updated git email** - Changed to nick@technick.ai

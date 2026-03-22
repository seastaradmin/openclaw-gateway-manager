# OpenClaw Gateway Manager

🦞 Manage OpenClaw gateway instances with ease!

## ✨ Features

- 🔍 **Smart Status Query** - Identify main ports, auxiliary ports, running status, and channels
- ✏️ **Modify Ports** - Automatically update config files + LaunchAgent plist
- 🔄 **Restart Gateways** - Safely restart specific or all gateways
- ✅ **Verify Configuration** - Check config consistency and port listening status
- ➕ **Create Instances** - One-click creation with automatic LaunchAgent setup
- 🗑️ **Safe Deletion** - Triple confirmation + automatic backup to prevent accidents
- 📡 **Port Scanning** - Intelligently identify all OpenClaw instances

## 🚀 Quick Start

### Installation

```bash
git clone https://github.com/seastaradmin/openclaw-gateway-manager.git ~/.jvs/.openclaw/skills/gateway-manager
```

### Usage

```bash
# Check all gateway status
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-status.sh

# Scan ports
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-scan-ports.sh

# Modify port
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-set-port.sh local-shrimp 18888

# Restart gateway
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-restart.sh all

# Verify config
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-verify.sh local-shrimp

# Create new instance
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-create.sh test-bot 18899 openim

# Delete instance (triple confirmation)
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-delete.sh test-bot
```

## 📖 Documentation

See [SKILL.md](SKILL.md) for detailed usage.

## 🛡️ Safety Features

- **Triple confirmation for deletion** - Prevents accidental deletion
- **Automatic backup** - Backs up to `~/.openclaw-deleted-backups/` before deletion
- **Port availability check** - Verifies port is free before modification
- **Configuration validation** - Auto-verifies after changes

## 📦 Scripts

| Script | Function | Risk Level |
|--------|----------|------------|
| `gateway-status.sh` | Query status | 🟢 Safe |
| `gateway-scan-ports.sh` | Port scanning | 🟢 Safe |
| `gateway-set-port.sh` | Modify ports | 🟡 Medium |
| `gateway-restart.sh` | Restart gateway | 🟢 Safe |
| `gateway-verify.sh` | Verify config | 🟢 Safe |
| `gateway-create.sh` | Create instance | 🟡 Medium |
| `gateway-delete.sh` | Delete instance | 🔴 Dangerous |

## 🎯 Instance Aliases

- `local-shrimp` / `本地虾` / `18789` → `~/.jvs/.openclaw/`
- `feishu` / `飞书` / `18790` → `~/.openclaw/`

## 📝 Example Output

```
=== OpenClaw Gateway Instances ===

🔹 Local Shrimp (本地虾)
   Main Port: 18789
   Aux Ports: 18791(Browser) 18792(Canvas)
   Config: ~/.jvs/.openclaw
   Status: ✅ Running (PID: 6512)
   Channel: openim
   Dashboard: http://127.0.0.1:18789/

🔹 Feishu Bot (飞书机器人)
   Main Port: 18790
   Aux Ports: 18792(Browser) 18793(Canvas)
   Config: ~/.openclaw
   Status: ✅ Running (PID: 76822)
   Channel: feishu
   Dashboard: http://127.0.0.1:18790/
```

## 🌍 Languages

- 🇨🇳 [中文文档](SKILL.md)
- 🇺🇸 [English Documentation](README.en.md)

## 📄 License

MIT

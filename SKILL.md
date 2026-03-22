# OpenClaw Gateway Manager

🦞 管理 OpenClaw 网关实例 / Manage OpenClaw gateway instances

---

## 🌍 语言 Languages

- 🇨🇳 [中文文档](#中文文档)
- 🇺🇸 [English Documentation](#english-documentation)

---

# 中文文档

## ✨ 功能

- 🔍 **智能查询** - 识别主端口、辅助端口、运行状态、频道信息
- ✏️ **修改端口** - 自动修改配置文件 + LaunchAgent plist
- 🔄 **重启网关** - 安全重启指定网关或所有网关
- ✅ **验证配置** - 检查配置一致性、端口监听状态
- ➕ **创建新实例** - 一键创建新网关实例（自动配置 LaunchAgent）
- 🗑️ **安全删除** - 三重确认 + 自动备份，防止误删
- 📡 **端口扫描** - 智能识别所有 OpenClaw 实例

## 🚀 快速开始

### 安装

```bash
git clone https://github.com/seastaradmin/openclaw-gateway-manager.git ~/.jvs/.openclaw/skills/gateway-manager
```

### 使用

```bash
# 查看所有网关状态
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-status.sh

# 扫描端口
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-scan-ports.sh

# 修改端口
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-set-port.sh 本地虾 18888

# 重启网关
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-restart.sh all

# 验证配置
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-verify.sh 本地虾

# 创建新实例
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-create.sh test-bot 18899 openim

# 删除实例（三重确认）
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-delete.sh test-bot
```

## 🛡️ 安全特性

- **删除操作三重确认** - 防止误删
- **自动备份** - 删除前备份到 `~/.openclaw-deleted-backups/`
- **端口检查** - 修改前检查端口是否被占用
- **配置验证** - 修改后自动验证

## 📦 脚本列表

| 脚本 | 功能 | 危险等级 |
|------|------|---------|
| `gateway-status.sh` | 查询状态 | 🟢 安全 |
| `gateway-scan-ports.sh` | 端口扫描 | 🟢 安全 |
| `gateway-set-port.sh` | 修改端口 | 🟡 中等 |
| `gateway-restart.sh` | 重启网关 | 🟢 安全 |
| `gateway-verify.sh` | 验证配置 | 🟢 安全 |
| `gateway-create.sh` | 创建实例 | 🟡 中等 |
| `gateway-delete.sh` | 删除实例 | 🔴 危险 |

## 🎯 实例名别名

| 别名 | 配置目录 | 默认端口 |
|------|---------|---------|
| `本地虾` / `local-shrimp` / `18789` | `~/.jvs/.openclaw/` | 18789 |
| `飞书` / `feishu` / `18790` | `~/.openclaw/` | 18790 |

## 📝 示例输出

```
=== OpenClaw Gateway 实例 ===

🔹 本地虾
   主端口：18789
   辅助端口：18791(浏览器) 18792(Canvas)
   配置：~/.jvs/.openclaw
   状态：✅ 运行中 (PID: 6512)
   频道：openim
   Dashboard: http://127.0.0.1:18789/

🔹 飞书机器人
   主端口：18790
   辅助端口：18792(浏览器) 18793(Canvas)
   配置：~/.openclaw
   状态：✅ 运行中 (PID: 76822)
   频道：feishu
   Dashboard: http://127.0.0.1:18790/
```

## ⚠️ 注意事项

1. **删除操作会永久删除数据** - 虽然有备份，但请谨慎
2. **修改端口后必须重启** - 否则不会生效
3. **配置文件和 plist 都要改** - 否则重启后恢复旧端口
4. **删除前检查依赖** - 确保没有其他服务依赖此网关

---

# English Documentation

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

| Alias | Config Directory | Default Port |
|-------|-----------------|--------------|
| `local-shrimp` / `本地虾` / `18789` | `~/.jvs/.openclaw/` | 18789 |
| `feishu` / `飞书` / `18790` | `~/.openclaw/` | 18790 |

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

## ⚠️ Notes

1. **Deletion is permanent** - Although backups are created, use with caution
2. **Restart required after port changes** - Changes won't take effect otherwise
3. **Both config and plist must be updated** - Otherwise old port restores on reboot
4. **Check dependencies before deletion** - Ensure no other services depend on this gateway

---

## 📄 License 许可证

MIT License

## 🔗 Links 链接

- GitHub: https://github.com/seastaradmin/openclaw-gateway-manager
- Author: @seastaradmin
- Version: 1.0.0

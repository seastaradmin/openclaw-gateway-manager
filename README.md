# OpenClaw Gateway Manager

🦞 管理 OpenClaw 网关实例的超级工具！

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
# 克隆到 OpenClaw skills 目录
git clone https://github.com/YOUR_USERNAME/openclaw-gateway-manager.git ~/.jvs/.openclaw/skills/gateway-manager
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

## 📖 文档

详见 [SKILL.md](SKILL.md)

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

- `本地虾` / `local-shrimp` / `18789` → `~/.jvs/.openclaw/`
- `飞书` / `feishu` / `18790` → `~/.openclaw/`

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

## 📄 License

MIT

# gateway-manager

管理 OpenClaw 网关实例（查询、修改端口、重启、验证、删除）。

## 功能

- 🔍 **智能查询** - 识别主端口、辅助端口、运行状态
- ✏️ **修改端口** - 自动修改配置文件 + LaunchAgent plist
- 🔄 **重启网关** - 安全重启指定网关或所有网关
- ✅ **验证配置** - 检查配置一致性、端口监听状态
- ➕ **创建新实例** - 一键创建新网关实例
- 🗑️ **删除实例** - 三重确认的安全删除（带备份）
- 📡 **端口扫描** - 智能识别所有 OpenClaw 实例

## 触发词

- "网关端口" / "修改端口" / "查看网关"
- "重启网关" / "网关配置" / "端口冲突"
- "删除实例" / "创建实例" / "扫描端口"
- "openclaw gateway" / "LaunchAgent"
- 端口号（如 "18789"、"18790"）

## 脚本列表

| 脚本 | 功能 | 危险等级 |
|------|------|---------|
| `gateway-status.sh` | 查询所有实例状态 | 🟢 安全 |
| `gateway-scan-ports.sh` | 智能扫描端口 | 🟢 安全 |
| `gateway-set-port.sh` | 修改端口 | 🟡 中等 |
| `gateway-restart.sh` | 重启网关 | 🟢 安全 |
| `gateway-verify.sh` | 验证配置 | 🟢 安全 |
| `gateway-create.sh` | 创建新实例 | 🟡 中等 |
| `gateway-delete.sh` | 删除实例 | 🔴 危险（三重确认） |

## 使用示例

### 1. 查询状态（智能识别）

```bash
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-status.sh
```

输出：
```
🔹 本地虾
   主端口：18789
   辅助端口：18791(浏览器) 18792(Canvas)
   配置：~/.jvs/.openclaw
   状态：✅ 运行中 (PID: 6512)
   频道：openim
   Dashboard: http://127.0.0.1:18789/
```

### 2. 扫描所有端口

```bash
~/.jvs/.openclaw/skills/gateway-manager/scripts/gateway-scan-ports.sh
```

### 3. 修改端口

```bash
# 修改本地虾端口
gateway-set-port.sh 本地虾 18888

# 修改飞书网关端口
gateway-set-port.sh 飞书 18889
```

### 4. 删除实例（三重确认）

```bash
gateway-delete.sh test-bot
```

**确认流程：**
1. 输入 `YES` 确认理解风险
2. 输入实例名确认（如 `test-bot`）
3. 输入 `delete` 执行删除

**自动备份：** 删除前会备份到 `~/.openclaw-deleted-backups/`

### 5. 创建新实例

```bash
gateway-create.sh my-bot 18899 openim
```

## 实例名别名

| 别名 | 配置目录 | 默认端口 |
|------|---------|---------|
| `本地虾` / `local-shrimp` / `18789` | `~/.jvs/.openclaw/` | 18789 |
| `飞书` / `feishu` / `18790` | `~/.openclaw/` | 18790 |
| 其他 | `~/.openclaw-<实例名>/` | 自定义 |

## 安全机制

### 删除操作（三重确认）

1. ✅ 输入 `YES` 确认理解风险
2. ✅ 输入实例名匹配
3. ✅ 输入 `delete` 最终确认
4. ✅ 自动备份到 `~/.openclaw-deleted-backups/`
5. ✅ 提供恢复指令

### 修改端口

1. ✅ 检查端口是否被占用
2. ✅ 备份原配置
3. ✅ 同步配置文件和 plist
4. ✅ 自动重启验证

## 配置文件位置

| 实例 | 配置目录 | Plist 文件 |
|------|---------|-----------|
| 本地虾 | `~/.jvs/.openclaw/` | `~/Library/LaunchAgents/ai.openclaw.gateway.plist` |
| 飞书机器人 | `~/.openclaw/` | `~/Library/LaunchAgents/ai.openclaw.gateway-feishu.plist` |
| 自定义 | `~/.openclaw-<name>/` | `~/Library/LaunchAgents/ai.openclaw.gateway-<name>.plist` |

## 端口规则

OpenClaw 网关监听多个端口：

| 端口 | 用途 |
|------|------|
| `N` | 主端口（WebSocket API） |
| `N+2` | 浏览器控制 |
| `N+3` | Canvas 渲染 |

例如：主端口 18789 → 浏览器 18791, Canvas 18792

## 注意事项

1. **删除操作会永久删除数据** - 虽然有备份，但请谨慎
2. **修改端口后必须重启** - 否则不会生效
3. **配置文件和 plist 都要改** - 否则重启后恢复旧端口
4. **删除前检查依赖** - 确保没有其他服务依赖此网关

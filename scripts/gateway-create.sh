#!/bin/bash
# gateway-create.sh - 创建新的 OpenClaw 网关实例

INSTANCE_NAME="$1"
PORT="$2"
CHANNEL="$3"

if [ -z "$INSTANCE_NAME" ] || [ -z "$PORT" ]; then
    echo "用法：gateway-create.sh <实例名> <端口> [频道]"
    echo ""
    echo "示例:"
    echo "  gateway-create.sh test-instance 18888 openim"
    echo "  gateway-create.sh wechat-bot 18889 wechat"
    exit 1
fi

CONFIG_DIR="$HOME/.openclaw-$INSTANCE_NAME"
PLIST_FILE="$HOME/Library/LaunchAgents/ai.openclaw.gateway-$INSTANCE_NAME.plist"

echo "🔧 创建新实例：$INSTANCE_NAME"
echo "   配置目录：$CONFIG_DIR"
echo "   端口：$PORT"
echo "   频道：${CHANNEL:-openim}"
echo ""

# 1. 检查端口是否被占用
if lsof -i :$PORT > /dev/null 2>&1; then
    echo "❌ 端口 $PORT 已被占用"
    exit 1
fi
echo "✅ 端口 $PORT 可用"

# 2. 创建配置目录
mkdir -p "$CONFIG_DIR"
echo "✅ 配置目录已创建：$CONFIG_DIR"

# 3. 复制基础配置（从现有实例）
if [ -f "$HOME/.jvs/.openclaw/openclaw.json" ]; then
    cp "$HOME/.jvs/.openclaw/openclaw.json" "$CONFIG_DIR/openclaw.json"
    echo "✅ 配置文件已复制"
else
    echo "⚠️  未找到基础配置，需要手动配置"
fi

# 4. 修改端口
cat "$CONFIG_DIR/openclaw.json" | jq ".gateway.port = $PORT" > "$CONFIG_DIR/openclaw.json.tmp" && mv "$CONFIG_DIR/openclaw.json.tmp" "$CONFIG_DIR/openclaw.json"
echo "✅ 端口已设置为：$PORT"

# 5. 创建 LaunchAgent plist
cat > "$PLIST_FILE" << PLISTEOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>ai.openclaw.gateway-$INSTANCE_NAME</string>
    <key>Comment</key>
    <string>OpenClaw Gateway - $INSTANCE_NAME (port $PORT)</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>ThrottleInterval</key>
    <integer>1</integer>
    <key>Umask</key>
    <integer>63</integer>
    <key>ProgramArguments</key>
    <array>
        <string>/opt/homebrew/opt/node/bin/node</string>
        <string>/opt/homebrew/lib/node_modules/openclaw/dist/entry.js</string>
        <string>gateway</string>
        <string>--port</string>
        <string>$PORT</string>
    </array>
    <key>StandardOutPath</key>
    <string>$CONFIG_DIR/logs/gateway.log</string>
    <key>StandardErrorPath</key>
    <string>$CONFIG_DIR/logs/gateway.err.log</string>
    <key>EnvironmentVariables</key>
    <dict>
        <key>HOME</key>
        <string>/Users/ping</string>
        <key>TMPDIR</key>
        <string>/var/folders/ym/jzs75j355zx54vh1jtcsg7wr0000gn/T/</string>
        <key>NODE_EXTRA_CA_CERTS</key>
        <string>/etc/ssl/cert.pem</string>
        <key>NODE_USE_SYSTEM_CA</key>
        <string>1</string>
        <key>PATH</key>
        <string>/Users/ping/.local/bin:/Users/ping/.npm-global/bin:/Users/ping/bin:/Users/ping/.volta/bin:/Users/ping/.asdf/shims:/Users/ping/.bun/bin:/Users/ping/Library/Application Support/fnm/aliases/default/bin:/Users/ping/.fnm/aliases/default/bin:/Users/ping/Library/pnpm:/Users/ping/.local/share/pnpm:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin</string>
        <key>OPENCLAW_HOME</key>
        <string>$CONFIG_DIR</string>
        <key>OPENCLAW_GATEWAY_PORT</key>
        <string>$PORT</string>
    </dict>
</dict>
</plist>
PLISTEOF
echo "✅ LaunchAgent 已创建：$PLIST_FILE"

# 6. 加载并启动
launchctl load "$PLIST_FILE"
sleep 3
echo "✅ 网关已启动"

# 7. 验证
echo ""
echo "=== 验证 ==="
if lsof -i :$PORT | grep LISTEN > /dev/null 2>&1; then
    echo "✅ 网关运行在端口 $PORT"
    echo "📊 Dashboard: http://127.0.0.1:$PORT/"
else
    echo "⚠️  网关未启动，请检查日志：$CONFIG_DIR/logs/"
fi

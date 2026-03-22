#!/bin/bash
# gateway-status.sh - 统一管理多云 OpenClaw 网关实例

echo "=== OpenClaw Gateway 实例 ==="
echo "💡 统一管理平台 - 支持多平台/多云部署"
echo ""

# 通过配置文件查找实例
check_instance() {
    local config_dir="$1"
    local name="$2"
    local config_file="$config_dir/openclaw.json"
    
    if [ -f "$config_file" ]; then
        local port=$(cat "$config_file" | jq -r '.gateway.port' 2>/dev/null)
        if [ -n "$port" ] && [ "$port" != "null" ]; then
            # 检查进程是否运行
            local pid=$(lsof -i :$port 2>/dev/null | grep LISTEN | grep -E "node|QClaw|Claw" | awk '{print $2}' | head -1)
            local status="❌ 已停止"
            if [ -n "$pid" ]; then
                status="✅ 运行中 (PID: $pid)"
                # 查找辅助端口 (+2, +3)
                local browser_port=$((port + 2))
                local canvas_port=$((port + 3))
                local aux_ports=""
                if lsof -i :$browser_port 2>/dev/null | grep LISTEN > /dev/null; then
                    aux_ports="$aux_ports $browser_port(浏览器)"
                fi
                if lsof -i :$canvas_port 2>/dev/null | grep LISTEN > /dev/null; then
                    aux_ports="$aux_ports $canvas_port(Canvas)"
                fi
                echo "🔹 $name"
                echo "   主端口：$port"
                echo "   辅助端口：$aux_ports"
                echo "   配置：$config_dir"
                echo "   状态：$status"
                
                # 尝试获取频道信息
                local channel=$(cat "$config_file" | jq -r '.channels | keys[0]' 2>/dev/null)
                if [ -n "$channel" ] && [ "$channel" != "null" ]; then
                    echo "   频道：$channel"
                fi
                
                echo "   Dashboard: http://127.0.0.1:$port/"
                echo ""
            else
                echo "🔹 $name"
                echo "   主端口：$port"
                echo "   配置：$config_dir"
                echo "   状态：$status"
                echo "   ⚠️  进程未运行，需要重启"
                echo ""
            fi
        fi
    fi
}

# 检查所有可能的配置路径（多云/多平台）
echo "🔍 扫描所有 OpenClaw 配置路径..."
echo ""

# 官方发行版
check_instance "$HOME/.openclaw" "OpenClaw (原始版)"

# 厂商发行版
check_instance "$HOME/.jvs/.openclaw" "JVS Claw (阿里云)"
check_instance "$HOME/.qclaw" "QClaw (腾讯)"

# 云端部署
check_instance "$HOME/.claw-cloud" "Cloud Claw (云端)"
check_instance "$HOME/.openclaw-cloud" "OpenClaw Cloud"

# 自定义实例
for dir in $HOME/.openclaw-*; do
    if [ -d "$dir" ] && [ -f "$dir/openclaw.json" ]; then
        # 排除已检查的目录
        case "$dir" in
            *cloud*) continue ;;
        esac
        instance_name=$(basename "$dir" | sed 's/\.openclaw-//')
        check_instance "$dir" "自定义实例：$instance_name"
    fi
done

# 其他可能的配置路径
for dir in $HOME/.claw-* $HOME/Claw* $HOME/claw*; do
    if [ -d "$dir" ] && [ -f "$dir/openclaw.json" ]; then
        instance_name=$(basename "$dir")
        check_instance "$dir" "实例：$instance_name"
    fi
done

echo "=== LaunchAgent 状态 ==="
launchctl list 2>/dev/null | grep -i "claw\|gateway" | while read line; do
    status=$(echo "$line" | awk '{print $2}')
    label=$(echo "$line" | awk '{print $3}')
    if [ "$status" = "0" ] || [ "$status" = "1" ]; then
        echo "   ✅ $label (状态：$status)"
    else
        echo "   ❌ $label (状态：$status - 已停止)"
    fi
done

echo ""
echo "=== 所有 Claw 相关端口 ==="
lsof -i -n -P 2>/dev/null | grep LISTEN | grep -E "node|Claw|QClaw" | grep -E "18[0-9]{3}|1900[0-9]|28789|29000" | awk '{print $1, $9}' | sort -u | while read line; do
    echo "   $line"
done

echo ""
echo "📊 统计信息："
total=$(lsof -i -n -P 2>/dev/null | grep LISTEN | grep -E "node|Claw|QClaw" | grep -E "18[0-9]{3}|1900[0-9]|28789|29000" | wc -l | tr -d ' ')
echo "   检测到的端口数：$total"
echo ""
echo "💡 提示：使用 gateway-scan-ports.sh 查看更详细的端口信息"

#!/bin/bash
set -e
cd /app

# 安装音频系统依赖
apt-get update -qq && apt-get install -y -qq \
    libportaudio2 libasound2-dev libopus0 libmpg123-0 ffmpeg \
    > /dev/null 2>&1 || true

# 修复app.py绑定地址（允许外部访问）
if ! grep -q 'host="0.0.0.0"' app.py; then
    sed -i 's/app\.run(/app.run(host="0.0.0.0", /g' app.py
fi

# 启动
python3 app.py

#!/bin/bash
set -e
cd /app

# 安装音频依赖
apk add --quiet --no-cache portaudio alsa-lib libopus ffmpeg mpg123 sox curl jq 2>/dev/null || true
apt-get install -y -qq portaudio libasound2 ffmpeg 2>/dev/null || true

# pip安装TTS
pip install --quiet TTS pyaudio 2>/dev/null || true

# 修复app.py绑定
if ! grep -q 'host="0.0.0.0"' app.py; then
    sed -i 's/app\.run(/app.run(host="0.0.0.0", /g' app.py
fi

python3 app.py

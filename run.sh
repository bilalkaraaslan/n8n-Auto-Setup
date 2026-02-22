#!/bin/bash

sudo apt-get update -y
sudo apt-get install -y nodejs npm curl

sudo npm i -g npm@latest
sudo npm i -g n
sudo n 24

export PATH="/usr/local/bin:$PATH"
hash -r

sudo npm i -g n8n

curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb

sudo npx n8n &
N8N_PID=$!

echo "Waiting for n8n to start..."
sleep 20

LOG_FILE=$(mktemp)
cloudflared tunnel --url http://localhost:5678 > "$LOG_FILE" 2>&1 &
CLOUDFLARED_PID=$!

echo "Waiting for tunnel to establish..."
sleep 15

URL=""
for i in $(seq 1 30); do
    URL=$(grep -o 'https://[^[:space:]]*\.trycloudflare\.com' "$LOG_FILE" 2>/dev/null | head -1)
    if [ -n "$URL" ]; then
        break
    fi
    sleep 2
done

echo ""
echo "=========================================="
echo "n8n is running!"
echo "Your public URL: $URL"
echo "=========================================="

wait $N8N_PID

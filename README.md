# n8n Auto Setup Script

A shell script that automatically installs and runs [n8n](https://n8n.io/) with a public URL via Cloudflare Tunnel.

---

## What It Does

1. Updates the system and installs Node.js and npm
2. Upgrades npm to the latest version
3. Installs the `n` Node version manager globally
4. Installs and switches to **Node.js v24**
5. Installs **n8n** globally
6. Downloads and installs **cloudflared**
7. Starts n8n in the background
8. Opens a Cloudflare quick tunnel on port `5678`
9. Prints the public URL to the terminal

---

## Requirements

- Ubuntu / Debian-based Linux
- `sudo` privileges
- Internet access

---

## Usage

### 1. Download the script

```bash
curl -O https://your-host/setup.sh
```

Or create it manually and paste the script contents.

### 2. Make it executable

```bash
chmod +x setup.sh
```

### 3. Run it

```bash
./setup.sh
```

Once complete, the terminal will display something like:

```
==========================================
n8n is running!
Your public URL: https://xxxx-xxxx.trycloudflare.com
==========================================
```

Open that URL in your browser to access your n8n instance.

---

## Ports

| Service    | Port  |
|------------|-------|
| n8n UI     | 5678  |
| Cloudflare | Auto  |

---

## Notes

- The Cloudflare tunnel URL is **temporary** and changes every time you restart the script. For a permanent URL, set up a named Cloudflare tunnel with a custom domain.
- n8n runs in the background. To stop it, find its process ID with `ps aux | grep n8n` and kill it.
- Node.js v24 is installed system-wide via the `n` version manager.

---

## Stopping the Services

```bash
# Stop n8n
pkill -f n8n

# Stop cloudflared
pkill cloudflared
```

---

## Troubleshooting

**No URL printed after startup?**
- Wait a few extra seconds — tunnel establishment can take up to 30 seconds.
- Check the log file created by the script (a temp file in `/tmp/`).

**n8n not responding at the URL?**
- Make sure n8n had enough time to start (the script waits 20 seconds by default).
- Try visiting `http://localhost:5678` directly if you are on the same machine.

**Permission errors?**
- Ensure you have `sudo` access and re-run the script.

---

## License

MIT — free to use and modify.

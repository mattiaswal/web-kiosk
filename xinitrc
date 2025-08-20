#!/bin/bash
export DISPLAY=:0
xset s off
xset -dpms
xset s noblank
export XDG_CONFIG_HOME=/tmp
export XDG_DATA_HOME=/tmp
url=${KIOSK_URL:-https://xkcd.com/303/}

protocol="${url%%://*}"
remainder="${url#*://}"

# Extract hostname (everything before first slash or colon)
hostname="${remainder%%/*}"  # Remove path first
hostname="${hostname%:*}"          # Then remove port if present

# Extract port from the host part (before any path)
host_part="${remainder%%/*}"
port="${host_part##*:}"

# Set default port if not specified
if [ "$hostname" = "$port" ]; then
        case "$protocol" in
		"http")  port=80 ;;
		"https") port=443 ;;
		*)       port="" ;;
        esac
fi

echo "$hostname"
echo "$port"

while ! nc -z $hostname $port; do
	echo "Port $port is not open. Retrying in 5 seconds..."
	sleep 5
done

# Magic 10 second sleep
sleep 10

exec chromium-browser --window-position=0,0 --kiosk --no-sandbox --full-screen --incognito --noerrdialogs --disable-translate --no-first-run --fast --fast-start --ignore-gpu-blacklist --disable-quic --enable-fast-unload --enable-tcp-fast-open --enable-native-gpu-memory-buffers --enable-gpu-rasterization --enable-zero-copy --disable-infobars --disable-features=TranslateUI --disk-cache-dir=/tmp ${url}

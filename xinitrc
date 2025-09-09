#!/bin/bash
export DISPLAY=:0
xset s off
xset -dpms
xset s noblank
xset -nocursor
xrandr --output DSI-1 --rotate inverted

unclutter-xfixes -idle 0.01 -root &

export XDG_CONFIG_HOME=/tmp
export XDG_DATA_HOME=/tmp
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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

exec chromium-browser ${url} \
  --no-sandbox \
  --kiosk \
  --noerrdialogs \
  --disable-infobars \
  --no-first-run \
  --start-maximized \
  --incognito \
  --disable-background-timer-throttling \
  --disable-renderer-backgrounding \
  --disable-backgrounding-occluded-windows \
  --disable-session-crashed-bubble \
  --disable-crash-reporter \
  --temp-profile \
  --disable-web-security \
  --aggressive-cache-discard \
  --disable-http-cache \
  --disable-application-cache \
  --disable-offline-load-stale-cache \
  --disable-back-forward-cache \
  --use-gl=egl \
  --enable-zero-copy \
  --disable-font-subpixel-positioning \
  --disable-lcd-text
#  --disable-gpu 
#  --disable-software-rasterize

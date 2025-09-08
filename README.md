# Kiosk Container

A lightweight Alpine Linux container that runs Chromium in full-screen kiosk mode with X11 graphics support.

## Features

- Minimal Alpine Linux base with X11 server
- Chromium browser in kiosk mode
- Hardware acceleration support (Mesa DRI/EGL)
- Automatic cursor hiding
- Display rotation support (inverted by default)
- Configurable target URL via environment variable

## Usage

```bash
docker run -e KIOSK_URL=https://example.com your-image-name
```

Default URL: https://xkcd.com/303/

The container waits for the target host to be reachable before launching the browser.

## Requirements

- Raspberry Pi 4 with original RPi display (currently only supported platform)
- Graphics drivers (X11 not required on host)
- Network access to target URL
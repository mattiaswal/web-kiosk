FROM alpine:latest

RUN apk add libdrm-dev xorg-server bash libdrm xf86-input-libinput mesa-dri-gallium mesa-egl xf86-video-modesetting mesa-utils mesa-gles
RUN apk add xinit xset xrandr xeyes chromium
RUN apk add avahi avahi-tools avahi-compat-libdns_sd
COPY xinitrc /root/.xinitrc
COPY start.sh /
COPY xorg.conf /etc/X11/xorg.conf
ENTRYPOINT ["/start.sh"]


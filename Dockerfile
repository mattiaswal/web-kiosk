FROM alpine:latest

RUN apk add xorg-server bash libdrm xf86-input-libinput mesa-dri-gallium mesa-egl xf86-video-modesetting mesa-utils mesa-gles
RUN apk add xinit xset xrandr chromium
RUN apk add unclutter-xfixes
RUN apk add onboard
RUN apk add musl-locales font-noto-emoji font-noto-cjk
COPY xinitrc /root/.xinitrc
COPY start.sh /
ENTRYPOINT ["/start.sh"]


FROM dockage/alpine-openrc:3.6

MAINTAINER Amrit Twanabasu <amrit.cas@gmail.com>

LABEL org.label-schema.name="tor-privoxy" \
org.label-schema.vendor="amrittb" \
org.label-schema.description="Docker Tor proxy (http and shell) built on Alpine Linux with control authentication" \
org.label-schema.vcs-url="https://github.com/amrittb/tor-privoxy" \
org.label-schema.license="MIT"

RUN apk update \
    && apk add tor privoxy \
    && mv /etc/tor/torrc.sample /etc/tor/torrc \
    && sed -i "s/#ControlPort 9051/ControlPort 9051/g" /etc/tor/torrc \
    && sed -i "s/#HashedControlPassword 16:[A-Z0-9]*/HashedControlPassword $(tor --hash-password password | grep 16:[A-Z0-9])/g" /etc/tor/torrc \
    && sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc \
    && echo "forward-socks5 / 0.0.0.0:9050 ." >> /etc/privoxy/config \
    && sed -i 's/listen-address\s*127.0.0.1:8118/listen-address 0.0.0.0:8118/g' /etc/privoxy/config \
    && rc-update add tor \
    && rc-update add privoxy

EXPOSE 9050/tcp 9051/tcp 8118/tcp
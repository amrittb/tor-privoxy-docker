FROM dockage/tor-privoxy:latest

MAINTAINER Amrit Twanabasu <amrit.cas@gmail.com>

LABEL org.label-schema.name="tor-privoxy" \
org.label-schema.vendor="amrittb" \
org.label-schema.description="Docker Tor proxy (http and shell) built on Alpine Linux with control authentication" \
org.label-schema.vcs-url="https://github.com/amrittb/tor-privoxy" \
org.label-schema.license="MIT"

RUN sed -i "s/#HashedControlPassword 16:[A-Z0-9]*/HashedControlPassword $(tor --hash-password password | grep 16:[A-Z0-9])/g" /etc/tor/torrc \
&& sed -i 's/#CookieAuthentication 1/CookieAuthentication 1/g' /etc/tor/torrc \
&& rc-update add tor
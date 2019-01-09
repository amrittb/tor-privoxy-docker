FROM ubuntu:xenial

LABEL maintainer="Amrit Twanabasu <amrit.cas@gmail.com>" \
org.label-schema.name="tor-privoxy" \
org.label-schema.vendor="amriterry" \
org.label-schema.description="Docker Tor proxy (http and shell) built on Ubuntu Linux with control authentication" \
org.label-schema.vcs-url="https://github.com/amrittb/tor-privoxy" \
org.label-schema.license="MIT"

RUN apt update \
    && apt install -y tor privoxy netcat curl

RUN echo "ControlPort 9051" >> /etc/tor/torrc \
    && echo HashedControlPassword $(tor --hash-password "password" | tail -n 1) >> /etc/tor/torrc \
    && echo "CookieAuthentication 1" >> /etc/tor/torrc \
    # Following 2 lines are dangerous Tor Config
    # Use a relay instead.
    && echo "ControlListenAddress 0.0.0.0" >> /etc/tor/torrc \
    && echo "SOCKSPort 0.0.0.0:9050" >> /etc/tor/torrc \
    && echo "forward-socks5 / 0.0.0.0:9050 ." >> /etc/privoxy/config \
    && echo "listen-address 0.0.0.0:8118" >> /etc/privoxy/config \
    && sed -i 's/listen-address\s*localhost:8118/#listen-address localhost/g' /etc/privoxy/config \
    && echo "debug 512" >> /etc/privoxy/config

COPY docker-entrypoint.sh /home/docker-entrypoint.sh
WORKDIR /home/
RUN chmod +x docker-entrypoint.sh
ENTRYPOINT [ "/home/docker-entrypoint.sh" ]

EXPOSE 9050/tcp 9051/tcp 8118/tcp
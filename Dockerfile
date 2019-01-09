FROM ubuntu:16.04
RUN apt update \
    && apt install -y tor privoxy netcat curl \
    && echo "ControlPort 9051" >> /etc/tor/torrc \
    && echo HashedControlPassword $(tor --hash-password "password" | tail -n 1) >> /etc/tor/torrc \
    && echo "CookieAuthentication 1" >> /etc/tor/torrc \
    && echo "forward-socks5 / 0.0.0.0:9050 ." >> /etc/privoxy/config \
    && echo "listen-address 0.0.0.0:8118" >> /etc/privoxy/config \
    && sed -i 's/listen-address\s*(localhost|127\.0\.0\.1):8118/#listen-address localhost/g' /etc/privoxy/config
    # && sed -i 's/listen-address\s*\[::1\]:8118/listen-address 0.0.0.0:8118/g' /etc/privoxy/config

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

# ENTRYPOINT [ "/docker-entrypoint.sh" ]

EXPOSE 9050/tcp 9051/tcp 8118/tcp
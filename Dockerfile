FROM debian:stretch
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        tor \
        privoxy \
        nano \
        python3 \
        python3-pip

WORKDIR /app/tor-privoxy
COPY ./setup-tor.sh /app/tor-privoxy/setup-tor.sh
ENTRYPOINT [ "tor" ]
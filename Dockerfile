FROM debian:stretch
RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
        tor \
        privoxy \
        nano \
        python3 \
        python3-pip

WORKDIR /home/tor-privoxy
COPY ./setup-tor.sh /home/tor-privoxy/setup-tor.sh
# RUN ["chmod" "+x", "setup-tor.sh","&&","bash", "./setup-tor.sh"]
ENTRYPOINT [ "bash" ]
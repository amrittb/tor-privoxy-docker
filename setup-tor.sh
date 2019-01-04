#!/bin/bash

# Configuring Tor
sed -i "s/#ControlPort 9051/ControlPort 9051/g" /etc/tor/torrc
sed -i "s/#HashedControlPassword 16:[A-Z0-9]/HashedControlPassword $(tor --hash-password password | grep 16:[A-Z0-9])/g" /etc/tor/torrc
sed -i "s/#CookieAuthentication 1/CookieAuthentication 1/g" /etc/tor/torrc

/etc/init.d/tor restart

# Configuring Privoxy
sed -i 's/#*[ ]*forward-socks5t[ ]*\/[ ]*127\.0\.0\.1:9050[ ]*\./forward-socks5t \/ 0\.0\.0\.0:9050 \./g' /etc/privoxy/config
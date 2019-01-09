#!/bin/bash

set -e
echo "Starting Tor..."
service tor start
echo "Starting Privoxy..."
privoxy --no-daemon /etc/privoxy/config

exec "$@";
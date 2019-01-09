#!/bin/bash

set -e
echo "Starting Tor..."
service tor start
echo "Starting Privoxy..."
service privoxy start

exec "$@";
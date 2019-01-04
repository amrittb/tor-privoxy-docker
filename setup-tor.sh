#!/bin/sh
HASHED_PASSWORD=$(tor --hash-password password | grep "16:[A-Z0-9]+")
exit 0
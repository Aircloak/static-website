#!/usr/bin/env bash

set -e

function log {
  echo "[aircloak] $1"
}

log "Touch all files to get around permission issues... Ouch..."
# Doing this in the dockerfile once and for all unfortunately does not work
# so instead we have to do it every time we start the container. This is
# very unfortunately, and very stupid. If we find a workaround, we certainly
# should use it.
for file in $(find ./ -type f); do
  sudo -u www-data touch $file;
done

log "Starting nginx"
nginx

#!/bin/sh

set -e

echo "[aircloak] Booting latest static website. Website available on http://localhost:9000/"
docker run --rm -it -p 9000:9000 aircloak/static_website:latest

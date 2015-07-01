#!/bin/sh

set -e

echo "[aircloak] Building static website container"
docker build -t aircloak/static_website:latest .

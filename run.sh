#!/usr/bin/env bash

set -eo pipefail

echo "You can view the site on http://localhost:8000"

ruby -run -ehttpd site -p8000

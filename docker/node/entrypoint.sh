#!/bin/sh

set -eu

if [ "$(id -u)" = "0" ]; then
    mkdir -p /app/node_modules /app/.nuxt /app/.yarn/cache
    chown -R node:node /app/node_modules /app/.nuxt /app/.yarn

    exec gosu node "$0" "$@"
fi

wait_seconds="${SOURCE_WAIT_SECONDS:-3}"

while [ ! -f package.json ]; do
    echo "Nuxt source not found at /app/package.json; waiting ${wait_seconds}s..."
    sleep "$wait_seconds"
done

if [ -f yarn.lock ]; then
    yarn install --immutable
else
    yarn install
fi

exec "$@"

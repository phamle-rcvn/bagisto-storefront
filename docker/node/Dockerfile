FROM node:24.14.0-bookworm-slim

ENV COREPACK_HOME=/opt/corepack
ENV NODE_ENV=development

RUN mkdir -p "$COREPACK_HOME" \
    && apt-get update \
    && apt-get install --no-install-recommends --yes gosu \
    && rm -rf /var/lib/apt/lists/* \
    && corepack enable \
    && corepack install --global yarn@4.13.0 \
    && chmod -R a+rX "$COREPACK_HOME"

WORKDIR /app

COPY --chmod=0755 docker/node/entrypoint.sh /usr/local/bin/storefront-entrypoint

EXPOSE 3000

ENTRYPOINT ["storefront-entrypoint"]

CMD ["yarn", "dev", "--host", "0.0.0.0", "--port", "3000"]

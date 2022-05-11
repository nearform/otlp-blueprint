FROM node:14-alpine as base

RUN apk update && apk upgrade && apk add -q vim && apk add bash

WORKDIR /app/

COPY package.json ./

COPY pkg-svcs/backend/package.json  ./pkg-svcs/backend/
RUN cd /app/pkg-svcs/backend && npm install

RUN npm install

FROM base as source

COPY pkg-svcs/backend ./pkg-svcs/backend

FROM source as build_layer

FROM node:14-alpine as production
WORKDIR /app/
COPY --from=build_layer /app/ ./
ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

RUN chown -R 1000:1000 /app/

USER node

CMD ["node", "/app/pkg-svcs/backend/server.mjs"]

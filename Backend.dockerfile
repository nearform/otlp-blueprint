FROM node:14-alpine as base

RUN apk update && apk upgrade && apk add -q vim && apk add bash

FROM base as source

RUN mkdir -p /app/frontend
WORKDIR /app/
COPY package.json ./
RUN npm install
RUN ls -lrt /app/

COPY pkg-svcs/backend/ ./backend
RUN cat /app/backend/package.json
WORKDIR /app/backend

FROM source as builder

RUN cd /app/backend && npm install

FROM node:14-alpine as production
WORKDIR /app/backend
COPY --from=builder /app/ ./
ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

RUN chown -R 1000:1000 /app/

USER node

CMD ["node", "/app/backend/server.mjs"]

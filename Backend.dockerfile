FROM node:lts-alpine as base

RUN apk update && apk upgrade && apk add -q vim && apk add bash

FROM base as source

RUN mkdir -p /app/backend
WORKDIR /app/
COPY package.json ./
COPY pkg-svcs/backend /app/backend
RUN npm install
COPY pkg-svcs/backend/package.json /app/backend/
RUN cat /app/backend/package.json
WORKDIR /app/backend
RUN npm install
EXPOSE 3000

COPY pkg-svcs/backend/ /app/backend/

FROM source as builder
WORKDIR /app/backend
RUN mv .env.registry .env

FROM node:lts-alpine as production

COPY --from=builder /app/ /app/
ARG APP_VERSION
ENV APP_VERSION=$APP_VERSION

RUN chown -R 1000:1000 /app/
WORKDIR /app/backend
USER node
EXPOSE 3000

CMD ["npm", "run","start"]

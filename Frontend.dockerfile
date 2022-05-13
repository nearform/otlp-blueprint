FROM node:lts-alpine as base

RUN apk update && apk upgrade && apk add -q vim git

FROM base as source
RUN mkdir -p /app/frontend
WORKDIR /app

COPY ./package.json .
RUN npm install

COPY pkg-svcs/frontend/package.json /app/frontend/
WORKDIR /app/frontend
RUN npm install
COPY ./pkg-svcs/frontend/ /app/frontend/

FROM source as builder
WORKDIR /app/frontend 

RUN npm run build

FROM nginx:stable-alpine as production

WORKDIR /app/frontend
COPY --from=builder /app/frontend/dist/ /var/www/
COPY --from=builder /app/frontend/docker/nginx.conf /etc/nginx/conf.d/default.conf

# run NGINX as an unprivileged user
RUN sed -i -e '/user/!b' -e '/nginx/!b' -e '/nginx/d' /etc/nginx/nginx.conf \
   && sed -i 's!/var/run/nginx.pid!/tmp/nginx.pid!g' /etc/nginx/nginx.conf \
   && sed -i "/^http {/a \    proxy_temp_path /tmp/proxy_temp;\n    client_body_temp_path /tmp/client_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;\n" /etc/nginx/nginx.conf \
   # nginx user must own the cache directory to write cache
   && chown -R 101:0 /var/cache/nginx \
   && chmod -R g+w /var/cache/nginx

EXPOSE 8080

USER 101
CMD ["nginx", "-g", "daemon off;"]
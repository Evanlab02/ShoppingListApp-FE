FROM node:18-alpine AS build

WORKDIR /app
COPY src /app/src
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
COPY tsconfig.json /app/tsconfig.json
COPY tsconfig.node.json /app/tsconfig.node.json
COPY vite.config.ts /app/vite.config.ts
COPY .eslintrc.cjs /app/.eslintrc.cjs
COPY index.html /app/index.html

RUN npm ci
RUN npm run build

FROM caddy:2.7.5-alpine

COPY --from=build /app/dist /var/www/html/site/
COPY Caddyfile /etc/caddy/Caddyfile

EXPOSE 80

FROM node:22-bookworm AS build

COPY package.json package-lock.json /app/

WORKDIR /app

RUN npm ci

FROM gcr.io/distroless/nodejs22-debian12 AS production

COPY --from=build /app/node_modules /app/node_modules

COPY package.json package-lock.json /app/

WORKDIR /app

CMD ["index.js"]

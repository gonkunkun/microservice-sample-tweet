FROM node:12.14.0-alpine

ENV NODE_ENV=production

WORKDIR /app
RUN apk add --no-cache curl && \
    curl -sfL https://install.goreleaser.com/github.com/tj/node-prune.sh | sh
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.0/wait /wait
RUN chmod +x /wait

COPY package.json .
RUN yarn install && ./bin/node-prune
COPY . .
EXPOSE 3000
CMD /wait && yarn start
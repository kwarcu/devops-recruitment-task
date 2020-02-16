ARG NODE_VERSION="lts-alpine"

###
FROM node:${NODE_VERSION} as server_base

COPY . /server
WORKDIR /server

RUN npm install

EXPOSE 8080

ENTRYPOINT ["npm", "start"]

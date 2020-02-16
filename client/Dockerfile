ARG NODE_VERSION="lts-alpine"

###
FROM node:${NODE_VERSION} as client_base

COPY . /client
WORKDIR /client

RUN npm install

EXPOSE 3000

ENTRYPOINT ["npm", "start"]

###
FROM client_base as client_build

RUN npm run build

###
FROM nginx:1.17.8-alpine as client_prod

COPY --from=client_build /client/build /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]

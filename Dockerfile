FROM node:alpine

WORKDIR /home/node/app
RUN chown node /home/node/app

USER node

COPY --chown=node:node package.json .
RUN npm install

COPY --chown=node:node . .

RUN npm run build

# NGINX
FROM nginx

COPY --from=0 /home/node/app/build /usr/share/nginx/html
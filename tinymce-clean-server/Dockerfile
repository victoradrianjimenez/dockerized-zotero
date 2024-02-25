FROM node:7-alpine

# install packages
RUN apk update && apk upgrade --no-cache && apk add  git

WORKDIR /usr/src/app
RUN git clone "https://github.com/zotero/tinymce-clean-server.git" .
RUN npm install --quiet

EXPOSE 16342

CMD [ "npm", "start" ]

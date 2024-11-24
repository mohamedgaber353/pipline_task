FROM node:18-alpine
RUN apk add --no-cache yarn
WORKDIR /app
COPY . .
RUN yarn install --production && yarn cache clean
ENTRYPOINT ["node"]
CMD ["src/index.js"]

EXPOSE 3000
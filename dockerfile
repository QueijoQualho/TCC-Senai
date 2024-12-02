FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:18-alpine

RUN apk update && \
    apk add --no-cache python3 py3-pip && \
    python3 -m venv /usr/src/app/python/venv

WORKDIR /app

COPY package*.json ./
RUN npm install --only=production

COPY --from=build /app/dist ./dist
COPY docs ./docs
COPY python ./python

RUN /usr/src/app/python/venv/bin/pip install --upgrade pip && \
    /usr/src/app/python/venv/bin/pip install -r python/requirements.txt && \
    rm -rf /root/.cache

EXPOSE 3000

CMD ["node", "dist/index.js"]
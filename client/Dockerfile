FROM node:13.12.0-alpine

# set working directory
WORKDIR /app
COPY . /client

ENV PATH /client/node_modules/.bin:$PATH

ARG REACT_APP_HOST_IP_ADDRESS

COPY package.json ./client
COPY package-lock.json ./client

RUN npm install --silent

EXPOSE 3001
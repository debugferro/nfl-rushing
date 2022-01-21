FROM node:13.12.0-alpine

# set working directory
WORKDIR /app
COPY . /client

# add `/app/node_modules/.bin` to $PATH
ENV PATH /client/node_modules/.bin:$PATH

ARG REACT_APP_HOST_IP_ADDRESS

# install app dependencies
COPY package.json ./client
COPY package-lock.json ./client
RUN npm install --silent
# RUN npm install react-scripts@3.4.1 -g --silent

# add app

# start app
EXPOSE 3001
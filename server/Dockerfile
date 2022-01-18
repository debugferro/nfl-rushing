FROM elixir:1.12-alpine

RUN apk add --no-cache inotify-tools build-base git nodejs npm
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install hex phx_new --force

RUN mkdir -p /server
COPY . /server


RUN cd /server && \
    mix do deps.get, compile


WORKDIR /server
EXPOSE 4000
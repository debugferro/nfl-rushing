FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app
COPY . /server

# RUN apk add --no-cache inotify-tools build-base
# RUN mix local.hex --force && \
#     mix local.rebar --force && \
#     mix archive.install hex phx_new --force

RUN cd /server && \
    mix do deps.get, compile


EXPOSE 4000
# CMD cd /server && mix deps.get && mix.ecto.setup && mix phx.server

# FROM elixir:1.12-alpine

# WORKDIR /app
# RUN mkdir -p /server
# COPY . /server

# # RUN apk add --no-cache inotify-tools build-base git nodejs npm
# # RUN mix local.hex --force && \
# #     mix local.rebar --force && \
# #     mix archive.install hex phx_new --force

# COPY mix.exs .
# COPY mix.lock .

# EXPOSE 4000

# CMD mix deps.get && mix.ecto.setup && mix phx.server
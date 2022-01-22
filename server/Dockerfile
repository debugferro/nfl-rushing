FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /app
COPY . /server

RUN cd /server && \
    mix do deps.get, compile

EXPOSE 4000
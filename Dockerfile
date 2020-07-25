# Elixir + Phoenix

FROM elixir:1.10.4-slim

# Install debian packages
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client curl

# Install Phoenix packages
RUN mix local.hex --force && mix local.rebar --force
RUN mix archive.install --force hex phx_new 1.5.4

# Install node
RUN curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get --yes install nodejs

COPY config/* config/
COPY mix.exs mix.lock ./
RUN mix do deps.get, deps.compile

COPY assets/package* assets/
WORKDIR assets
RUN npm ci

WORKDIR /app
EXPOSE 4000

CMD ["sleep", "infinity"]

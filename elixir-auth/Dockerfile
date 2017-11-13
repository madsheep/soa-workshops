FROM elixir:1.4.5-slim

RUN apt-get update && apt-get install --yes \
  git-core build-essential

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

RUN adduser --disabled-password --system --uid 1000 deploy

COPY . /home/deploy/app

RUN chown deploy: -R ~deploy

USER deploy
WORKDIR /home/deploy/app

ENV MIX_ENV=prod

RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
RUN mix compile

CMD ["mix", "serve"]
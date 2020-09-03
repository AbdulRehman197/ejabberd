FROM elixir
COPY ./ ./ejabberd
WORKDIR  /ejabberd
RUN (cd config; wget https://gist.githubusercontent.com/mremond/e3a05f7a18f87c4c5145547a3fd3e9e1/raw/a412004b37c7fa7f1d1f7179b4cc73045b9b8da9/ejabberd.yml)
RUN mix archive.install github hexpm/hex branch latest
RUN mix local.hex --force
RUN mix local.rebar --force
RUN HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get
RUN mix compile
EXPOSE 1883 4369-4399 5222 5269 5280 5443
ENTRYPOINT ["iex", "-S", "mix"]

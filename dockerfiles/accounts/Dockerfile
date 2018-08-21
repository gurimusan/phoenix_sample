from elixir:1.7-alpine

ENV LANG ja_JP.UTF-8
ENV TIMEZONE Asia/Tokyo

# Install phonix
RUN yes | mix local.hex
RUN yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN yes | mix local.rebar
RUN apk add --no-cache inotify-tools nodejs nodejs-npm

CMD ["/bin/sh"]

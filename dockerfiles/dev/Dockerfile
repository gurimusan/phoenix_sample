FROM alpine:3.8

ENV LANG ja_JP.UTF-8
ENV TIMEZONE Asia/Tokyo
ENV OTP_VERSION="21.0.5"
ENV ELIXIR_VERSION="v1.7.2"

RUN set -xe \
	&& OTP_DOWNLOAD_URL="https://github.com/erlang/otp/archive/OTP-${OTP_VERSION}.tar.gz" \
	&& OTP_DOWNLOAD_SHA256="70124f91693364f7fd2ec65baa45c434f069a14f5aa2c18377e1c3f320f47ac5" \
	&& apk add --no-cache --virtual .fetch-deps \
		curl \
		ca-certificates \
	&& curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" \
	&& echo "$OTP_DOWNLOAD_SHA256  otp-src.tar.gz" | sha256sum -c - \
	&& apk add --no-cache --virtual .build-deps \
		dpkg-dev dpkg \
		gcc \
		g++ \
		libc-dev \
		linux-headers \
		make \
		autoconf \
		ncurses-dev \
		openssl-dev \
		unixodbc-dev \
		lksctp-tools-dev \
		tar \
	&& export ERL_TOP="/usr/src/otp_src_${OTP_VERSION%%@*}" \
	&& mkdir -vp $ERL_TOP \
	&& tar -xzf otp-src.tar.gz -C $ERL_TOP --strip-components=1 \
	&& rm otp-src.tar.gz \
	&& ( cd $ERL_TOP \
	  && ./otp_build autoconf \
	  && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
	  && ./configure --build="$gnuArch" \
	  && make -j$(getconf _NPROCESSORS_ONLN) \
	  && make install ) \
	&& rm -rf $ERL_TOP \
	&& runDeps="$( \
		scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
			| tr ',' '\n' \
			| sort -u \
			| awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
	)" \
	&& apk add --virtual .erlang-rundeps $runDeps lksctp-tools \
	&& apk del .fetch-deps .build-deps

RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/releases/download/${ELIXIR_VERSION}/Precompiled.zip" \
	&& ELIXIR_DOWNLOAD_SHA256="d39c0fcdd2053f0ae2a9b1394ee582ac3398d9538881024f2252688ad92aad86" \
	&& buildDeps=' \
		ca-certificates \
		curl \
		unzip \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -fSL -o elixir-precompiled.zip $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-precompiled.zip" | sha256sum -c - \
	&& unzip -d /usr/local elixir-precompiled.zip \
	&& rm elixir-precompiled.zip \
	&& apk del .build-deps

# Install phonix
RUN yes | mix local.hex
RUN yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez
RUN yes | mix local.rebar
RUN apk add --no-cache inotify-tools nodejs nodejs-npm

RUN set -xe \
  && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
  && apk add --no-cache --update \
      make \
      cmake \
      gcc \
      g++ \
      file \
      git \
      git-subtree \
      zsh \
      openssh \
      tmux \
      xclip \
      sudo \
      less \
      curl \
      python \
      python-dev \
      python3 \
      python3-dev \
      py-pip \
      py-setuptools \
      ctags \
      neovim \
      postgresql-client

# Install dein.vim
RUN apk add --no-cache --update --virtual build-deps \
    gcc \
    g++ \
    make \
    cmake \
    && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
    && chmod +x ./installer.sh \
    && sh ./installer.sh /root/.config/deinrepo \
    && rm -f installer.sh \
    && apk del build-deps

COPY .zshrc         /root/.zshrc
COPY .gitconfig     /root/.gitconfig
COPY init.vim       /root/.config/nvim/init.vim
COPY dein.toml      /root/.config/dein/dein.toml
COPY dein_lazy.toml /root/.config/dein/dein_lazy.toml

RUN nvim +":silent! call dein#install()" +qall
RUN nvim +"UpdateRemotePlugins" +qall

RUN echo 'alias vim="nvim"' >> /root/.zshrc

CMD ["/bin/zsh"]

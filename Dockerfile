FROM ubuntu:20.04

LABEL maintainer="github.com/saeedrm6"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y gnupg tzdata \
    && echo "Asia/Tehran" > /etc/timezone \
    && dpkg-reconfigure -f noninteractive tzdata


RUN apt-get install -y curl supervisor build-essential

RUN apt-get install -y checkinstall zlib1g-dev

RUN apt-get install -y linux-headers-5.8.0-38-generic

RUN apt-get install -y libpcre3-dev

RUN apt-get install -y ffmpeg

ARG NGINX_VERSION=1.16.1

ARG VOD_MODULE_VERSION=399e1a0ecb5b0007df3a627fa8b03628fc922d5e

RUN mkdir /nginx

RUN mkdir /nginx-vod-module

WORKDIR /home

RUN curl -sL https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar -C /nginx --strip 1 -xz

RUN curl -sL https://github.com/kaltura/nginx-vod-module/archive/${VOD_MODULE_VERSION}.tar.gz | tar -C /nginx-vod-module --strip 1 -xz

RUN apt-get install -y libssl-dev

WORKDIR /nginx

RUN ./configure --prefix=/usr/local/nginx \
	--add-module=../nginx-vod-module \
	--with-http_ssl_module \
	--with-file-aio \
	--with-threads \
	--with-cc-opt="-O3"

RUN make
RUN make install

RUN apt-get update

WORKDIR /nginx

RUN mkdir /usr/local/nginx/conf.d

RUN mkdir /usr/local/nginx/snippets

RUN mkdir -p /var/www/html

RUN mkdir -p /var/log/nginx

ADD nginx/nginx.conf /usr/local/nginx/conf/nginx.conf

ADD nginx/default.conf /usr/local/nginx/conf.d/default.conf

ADD nginx/client-cache.conf /usr/local/nginx/snippets/client-cache.conf

ADD nginx/html /var/www/html
ADD nginx/mime.types /usr/local/nginx/conf/mime.types

ADD supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD [ "supervisord" ]
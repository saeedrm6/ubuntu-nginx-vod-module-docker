ubuntu-nginx-vod-module-docker
=======================
Docker image for nginx with Kaltura's VoD module based on Ubuntu used by github.com/saeedrm6 for HLS streaming

This repository contains a Dockerfile for building nginx with [Kaltura's
vod-module](https://github.com/kaltura/nginx-vod-module).

Building locally
----------------

This repository uses Docker's multi-stage builds, therefore building this image
requires Docker 17.05 or higher. Given that you have all the required
dependencies, building the image is as simple as running a ``docker build``:

```
docker build -t saeedrm6/ubuntu-nginx-vod-module .
```

# HLS example

## Running this example locally

You can run this example locally with Docker

```
% docker run --name ubuntu_nginx_kaltura -v $PWD/nginx/videos:/var/www/html/public/videos -d -p 3030:80 saeedrm6/ubuntu-nginx-vod-module
```

Or you can run it with docker-compose
```
% docker-compose -f docker-compose.yml up -d --remove-orphan --force-recreate
```

After running this command, you should be able to play the following URLs:

- HLS - SINGLE VIDEO FILE: http://localhost:3030/hls/video_360p.mp4/master.m3u8
- HLS - Multi Source file : http://localhost:3030/hls/video,_360p.mp4,_240p.mp4,.urlset/master.m3u8
- HLS - Multi Source file & Subtitle : http://localhost:3030/hls/video,_360p.mp4,_240p.mp4,_subtitle.vtt,.urlset/master.m3u8

Docker Hub
----------

The image is available on Docker Hub: SOON

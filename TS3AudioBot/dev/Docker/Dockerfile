FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

LABEL maintainer='Bl4ckBirb <https://github.com/Bl4ckBirb>'

## Install required dependencies
RUN apk add \
    python3 \
    opus-dev \
    ffmpeg

## link python command to use python3 (required by youtube-dl)
RUN ln -sf python3 /usr/bin/python

## Create pterodactyl container user
RUN adduser --disabled-password --home /home/container container

## Set necessary settings for pterodactyl containers
USER container
ENV  USER=container HOME=/home/container
WORKDIR /home/container

## Needed so that the running dotnet app can react to ^C (aka SIGINT)
STOPSIGNAL SIGINT

## Setup startup script
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/sh", "/entrypoint.sh"]
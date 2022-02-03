FROM debian:buster-slim

LABEL maintainer='Bl4ckBirb <https://github.com/Bl4ckBirb>'

## Install required dependencies
RUN apt update && apt install -y iproute2 python3 ca-certificates ffmpeg libopus-dev

## link python command to use python3 (required by youtube-dl)
RUN ln -sf python3 /usr/bin/python

## Create pterodactyl container user
RUN useradd -m -d /home/container -s /bin/bash container

## Set necessary settings for pterodactyl containers
USER container
ENV USER=container HOME=/home/container
WORKDIR /home/container

## Important env variable for dotnet app extraction
ENV DOTNET_BUNDLE_EXTRACT_BASE_DIR=/tmp

## Needed so that the running dotnet app can react to ^C (aka SIGINT)
STOPSIGNAL SIGINT

## Setup startup script
COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
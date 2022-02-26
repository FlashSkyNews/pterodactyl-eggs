#!/bin/ash

## install required packages 
apk update
apk add --no-cache build-base git 

## download files
echo -e "running: git clone https://github.com/skeeto/endlessh.git"
git clone https://github.com/skeeto/endlessh.git

## build programm
cd endlessh
echo -e "running: make"
make

## create server directory if it does not exist
[ ! -d "/mnt/server" ] && mkdir /mnt/server

## move programm to server home
mv endlessh /mnt/server/

echo -e ""
echo -e " Install complete."
echo -e ""
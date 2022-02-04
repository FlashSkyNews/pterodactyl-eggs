#!/bin/bash

## install required packages 
apt update
apt install curl tar -y

## create and change to directory
mkdir /mnt/server
cd /mnt/server/

## install youtube-dl
curl -L https://yt-dl.org/downloads/latest/youtube-dl -o youtube-dl
chmod a+rx youtube-dl

## get download link
if [ "${VERSION}" == "" ] || [ "${VERSION}" == "latest" ]; then
    DOWNLOAD_URL=$(echo "https://github.com/Splamy/TS3AudioBot/releases/latest/download/${DOWNLOAD_FILE}")
else
    DOWNLOAD_URL=$(echo "https://github.com/Splamy/TS3AudioBot/releases/download/${VERSION}/${DOWNLOAD_FILE}")
fi

## verify download link is valid
if [ ! -z "${DOWNLOAD_URL}" ]; then
    if curl --output /dev/null --silent --head --fail ${DOWNLOAD_URL}; then
        echo -e "link is valid. setting download link to ${DOWNLOAD_URL}"
        DOWNLOAD_LINK=${DOWNLOAD_URL}
    else       
        echo -e "link is invalid closing out"
        exit 2
    fi
fi

## download files
echo -e "running: curl -sSL -o ${DOWNLOAD_FILE} ${DOWNLOAD_LINK}"
curl -sSL -o ${DOWNLOAD_FILE} ${DOWNLOAD_LINK}

## unpack files
echo -e "unpacking files"
tar xzvf ${DOWNLOAD_FILE}
rm ${DOWNLOAD_FILE}

echo -e "Installation complete."
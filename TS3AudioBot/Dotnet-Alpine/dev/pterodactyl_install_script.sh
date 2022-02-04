#!/bin/bash

## install required packages 
apk update
apk add curl tar unzip

## create and change to directory
mkdir /mnt/server
cd /mnt/server/

## install youtube-dl
curl -sSL https://yt-dl.org/downloads/latest/youtube-dl -o youtube-dl
chmod a+rx youtube-dl

## get download link
if [ "${VERSION}" == "" ] || [ "${VERSION}" == "latest" ]; then
    DOWNLOAD_URL=$(echo "https://github.com/Splamy/TS3AudioBot/releases/latest/download/${DOWNLOAD_FILE}")
else
    DOWNLOAD_URL=$(echo "https://github.com/Splamy/TS3AudioBot/releases/download/${VERSION}/${DOWNLOAD_FILE}")
fi

## Check if download link is valid
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
echo -e "running: curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_FILE}"
curl -sSL ${DOWNLOAD_LINK} -o ${DOWNLOAD_FILE}

## unpack files
echo -e "unpacking files"
unzip -o ${DOWNLOAD_FILE}
rm ${DOWNLOAD_FILE}

echo -e "Install complete."
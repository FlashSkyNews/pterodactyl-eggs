#!/bin/bash

## install required packages 
apk update
apk add curl tar unzip opus-dev ffmpeg

## make and change to directory
mkdir /mnt/server/run
cd /mnt/server/run

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

## create default bot folder as well as config file and fill it with values from panel variables
mkdir -p bots/default
echo -e "run = true \n[connect] \naddress = \"${SERVER_ADDRESS}\" \nserver_password = { pw = \"${SERVER_PASSWORD}\" } \nchannel = \"${CHANNEL}\" \nchannel_password = { pw = \"${CHANNEL_PASSWORD}\" } \nname = \"${BOT_NAME}\"" > bots/default/bot.toml

## perform a short startup so that all config files get created
timeout -s SIGINT 3s dotnet TS3AudioBot.dll --non-interactive

## move important files up one folder for easier access
mv rights.toml ../
mv ts3audiobot.toml ../
mv bots ../
mv logs ../

cd ../

## update file locations in the main config file
sed -i 's+ts3audiobot.db+run/ts3audiobot.db+g' ts3audiobot.toml
sed -i 's+youtube-dl = { path = "" }+youtube-dl = { path = "run/youtube-dl" }+g' ts3audiobot.toml

## add useful bot commands
sed -i '/^\[bot.commands.alias\]/a yt = "!search from youtube (!param 0)" \nytp = "!xecute (!search from youtube (!param 0)) (!search play 0)" \nyta = "!xecute (!search from youtube (!param 0)) (!search add 0)" \nlofi = "!play https://www.youtube.com/watch?v=5qap5aO4i9A"' ts3audiobot.toml

echo -e ""
echo -e "==================="
echo -e " Install complete. "
echo -e "==================="
echo -e ""
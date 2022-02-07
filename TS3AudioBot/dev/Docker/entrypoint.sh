#!/bin/sh
cd /home/container

# Make internal Docker IP address available to processes.
export INTERNAL_IP=`ip route get 1 | awk '{print $NF;exit}'`

# Replace Startup Variables
PARSED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g' | eval echo "$(cat -)")

# Print startup command in beautified style
printf "\033[1m\033[33mcontainer@pterodactyl~ \033[0m%s\n" "${PARSED_STARTUP}"

exec env ${PARSED_STARTUP}
# TS3AudioBot

### From their [GitHub](https://github.com/Splamy/TS3AudioBot)
This is a open-source TeamSpeak3 bot, playing music and much more.

## Why are there 2 versions?
### Debian version
Uses a Debian docker container and the corresponding Linux version of the TS3AudioBot.
- less files in directory, therefore a lot easier to find the right config files
- Container needs more resources, especially more ram (~150mb instead of ~80mb) 

### Dotnet-Alpine version
Uses a Dotnet container with alpine Linux and the corresponding Dotnet version of the TS3AudioBot.
- The opposite of the above mentioned points

## Additional Egg information
By default the bot is using port 58913 for its optional webserver.
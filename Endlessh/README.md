# Endlessh

### From their [GitHub](https://github.com/skeeto/endlessh)
Endlessh is an SSH tarpit that *very* slowly sends an endless, random
SSH banner. It keeps SSH clients locked up for hours or even days
at a time. The purpose is to put your real SSH server on another port
and then let the script kiddies get stuck in this tarpit instead of
bothering a real server.

## Additional information
Pterodactyl panel sadly does not let you use any ports lower than 1024 for your servers. As a workaround just set your server port to a random port (e.g. 2222) and forward port 22 on your host OS to this port.
This can be done with iptables using the following command:

    iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 22 -j REDIRECT --to-port 2222

Don't forget to make the rule persistent, otherwise it will be lost after a reboot. This can be done using the iptables-persistent package for example.
# Endlessh

### From their [GitHub](https://github.com/skeeto/endlessh)
Endlessh is an SSH tarpit that *very* slowly sends an endless, random
SSH banner. It keeps SSH clients locked up for hours or even days
at a time. The purpose is to put your real SSH server on another port
and then let the script kiddies get stuck in this tarpit instead of
bothering a real server.

## Additional information
Pterodactyl panel does not let you allocate any ports lower than or equal to 1024 for your servers and as the standard SSH port is 22 it is therefore not possible to assign this port to an Endlessh server by default.  
To change this you have to do the following (partly described [here](https://github.com/pterodactyl/panel/issues/3749#issuecomment-1036498742)):
  
Open this file in the editor of your choice:

    /var/www/pterodactyl/app/Models/Allocation.php
find this line (or similar): 
    
    'port' => 'required|numeric|between:1024,65535'  
and change the 1024 to 21 or lower.

Afterwards you also have to change the same number in another file:

    /var/www/pterodactyl/app/Services/Allocations/AssignmentService.php
search for this line (or similar): 
    
    public const PORT_FLOOR = 1024;
and also change the 1024 to 21 or lower.

Now you can allocate the port 22 in pterodactyl panel for your Endlessh server, so that it looks like a real SSH server from the outside.
# Windward Server in Docker optimized for Unraid
This Docker will download and install Windwardand run it.

**CONSOLE:** To connect to the console open up the terminal on the host machine and type in: 'docker exec -u windward -ti NAMEOFYOURCONTAINER screen -xS Windward' (without quotes) to exit the screen session press CTRL+A and then CTRL+D or simply close the terminal window in the first place.

## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for gamefile | /vintagestory |
| GAME_PARAMS | Enter your start up commands for the server. | -name "Docker Windward" -world "World" -tcp 5127 -public |
| ADMIN | Admin SteamID (leave empty if you don't know your SteamID yet, connect to the server once and the ID will show up in the log enter it here and restart the container) | YOURSTEAMID |
| FORCE_UPDATE | Set to 'true' (without quotes) to force a update of WWServer.exe otherwise leave empty. | empty |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| UMASK | User file permission mask for newly created files | 000 |
| DATA_PERM | Data permissions for main storage folder | 770 |

## Run example
```
docker run --name Windward -d \
	-p 5127:5127 \
	--env 'GAME_PARAMS=-name "Docker Windward" -world "World" -tcp 5127 -public' \
	--env 'ADMIN=YOURSTEAMID' \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=000' \
	--env 'DATA_PERM=770' \
	--volume /path/to/windward:/windward \
	ich777/windward
```

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/79530-support-ich777-gameserver-dockers/
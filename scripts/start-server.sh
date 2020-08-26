#!/bin/bash
if [ ! -f ${DATA_DIR}/WWServer.exe ]; then
    echo "---'Windward.exe' not found, downloading!---"
    if wget -q -nc --user-agent="Mozilla" --show-progress --progress=bar:force:noscroll -O ${DATA_DIR}/WWServer.zip http://www.tasharen.com/windward/WWServer.zip ; then
        echo "---Sucessfully downloaded Windward---"
    else
        echo "---Something went wrong, can't download Windward, putting container in sleep mode---"
        sleep infinity
    fi
    unzip ${DATA_DIR}/WWServer.zip
    rm ${DATA_DIR}/WWServer.zip
else
    echo "---'Windward.exe' found, continuing!---"
fi

echo "---Preparing Server---"
if [ ! -d ${DATA_DIR}/Windward/ServerConfig ]; then
    mkdir -p ${DATA_DIR}/Windward/ServerConfig
fi
if [ ! -f ${DATA_DIR}/Windward/ServerConfig/admin.txt ]; then
    touch ${DATA_DIR}/Windward/ServerConfig/admin.txt
fi

CUR_ADMINS="$(cat ${DATA_DIR}/Windward/ServerConfig/admin.txt)"

if grep -q "$ADMIN" <<< "$CUR_ADMINS"; then
	echo "---Admin with SteamID: $ADMIN found! Nothing to do, continuing!---"
else
	echo "---Adding SteamID: $ADMIN to 'admin.txt'---"
	echo "$ADMIN" >> ${DATA_DIR}/Windward/ServerConfig/admin.txt
	sleep 4
fi

echo "---Checking for old logs---"
find ${DATA_DIR} -name "masterLog.*" -exec rm -f {} \;
screen -wipe 2&>/dev/null
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${DATA_DIR}
screen -S Windward -L -Logfile ${DATA_DIR}/masterLog.0 -d -m mono ${DATA_DIR}/WWServer.exe ${GAME_PARAMS}
sleep 2
screen -S watchdog -d -m /opt/scripts/start-watchdog.sh
tail -f ${DATA_DIR}/masterLog.0
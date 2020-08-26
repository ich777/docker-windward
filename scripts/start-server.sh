#!/bin/bash
sleep infinity


echo "---Preparing Server---"
find ${DATA_DIR} -name ".*" -exec rm -R -f {} \;
rm -R ${DATA_DIR}/dohinstalled-* ${DATA_DIR}/gopath 2&>/dev/null
chmod -R ${DATA_PERM} ${DATA_DIR}

echo "---Starting Server---"
cd ${DATA_DIR}
mono ${DATA_DIR}/WWServer.exe ${GAME_PARAMS}
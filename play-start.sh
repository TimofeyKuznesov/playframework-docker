#!/bin/bash

PLAY_OPT="-Dpidfile.path=/var/run/${APP_EXEC}.pid"
while IFS='=' read -r name value ; do
  if [[ $name == 'PLAY_'* ]]; then
    key=${name##"PLAY_"}
    PLAY_OPT="${PLAY_OPT} -D${key//_/.}=${value}"
    echo "$name" ${!name}     
  fi
done < <(env)
if [ ! -d "/app/bin" ]; then
  mkdir -p /app
  if [ ! -z $APP_URL ];then
    echo "download app from ${APP_URL}"
    curl $APP_URL | tar xz -C /app
  fi
fi
echo $PLAY_OPT
rm -f /var/run/$APP_EXEC.pid && ./bin/$APP_EXEC  $PLAY_OPT  -J-XX:+UnlockExperimentalVMOptions -J-XX:+UseCGroupMemoryLimitForHeap
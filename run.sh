#!/bin/bash

# Audio needs ID's. No idea why
USER_UID=$(id -u)
USER_GID=$(id -g)
XSOCK=/tmp/.X11-unix

# enumerate video devices for webcam support
VIDEO_DEVICES=
for device in /dev/video*
do
  if [[ -c $device ]]; then
    VIDEO_DEVICES="${VIDEO_DEVICES} --device $device:$device"
  fi
done

xhost +
sudo docker run -it --rm \
    --name firefox-bare \
    --env=USER_UID=${USER_UID} \
    --env=USER_GID=${USER_GID} \
    --env TZ=CST6CDT \
    --volume=${XSOCK}:${XSOCK} \
    --env DISPLAY=unix$DISPLAY \
    $VIDEO_DEVICES \
    --volume=/run/user/${USER_UID}/pulse:/run/pulse \
    --env PULSE_SERVER=/run/pulse/native \
    --volume /home/$USER/.minecraft:/root/.minecraft \
    -v /dev/shm:/dev/shm \
    minecraft-java-client $@
xhost -

# note all of shm must be mounted
    #--shm-size 2g \

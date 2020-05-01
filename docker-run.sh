#!/bin/bash
sudo docker run -it --net=host \
  --privileged \
  -e PROJECT_ID="api-tokens-272720" \
  -e MODEL_ID="api-tokens-272720-raspberrypi-cxf7w2" \
  -v "$(pwd)"/gassist-cred.json:/home/root/gassist-cred.json \
  -v "$(pwd)"/src:/home/root/GassistPi/src \
  -v /var/run/dbus:/var/run/dbus \
  -v /run/user/${UID}/pulse:/run/user/1000/pulse \
  -v /dev/mem:/dev/mem \
  -v /home/osmc/.config:/home/pi/.config \
  --device /dev/mem:/dev/mem \
  --name gassistpi \
  gassistpi:latest /bin/bash

# --restart always

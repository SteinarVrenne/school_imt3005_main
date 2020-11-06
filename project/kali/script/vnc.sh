#!/bin/bash

mkdir -p /root/.vnc

chmod +x vncpasswd.sh
./vncpasswd.sh

export USER=root

# Runs vns client
tightvncserver :0 -geometry 1900x940 -depth 16 -pixelformat rgb565


# Runs vnc server
/usr/share/novnc/utils/launch.sh --listen 5901 --vnc localhost:5900


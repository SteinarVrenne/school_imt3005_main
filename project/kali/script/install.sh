#!/bin/bash

# cp keyboard /etc/default/

apt-get update -y
echo -e 'yes\n' | apt install base-passwd -y
apt upgrade -y
apt-get install -y curl nano vim sudo apt-transport-https gnupg

DEBIAN_FRONTEND=noninteractive apt-get install -y kali-desktop-xfce
apt-get install -y kali-defaults tightvncserver
apt-get clean

rm -rf /var/lib/apt/lists/*

useradd kalikid
mkhomedir_helper kalikid

# VNC password. Needs to be not hard coded in the future
mkdir -p /home/kalikid/.vnc"
chmod go-rwx /home/kalikid/.vnc"

echo -e 'password\npassword\nn' | vncpasswd -f

export USER=root

apt update -y

apt-get install -y net-tools novnc


# Runs vns client
tightvncserver :0 -geometry 1900x940 -depth 16 -pixelformat rgb565


#TODO: Make VNC client and server as a service


# Runs vnc server
/usr/share/novnc/utils/launch.sh --listen 5901 --vnc localhost:5900



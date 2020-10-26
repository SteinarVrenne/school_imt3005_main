#!/bin/bash

apt-get update -y
echo -e 'yes\n' | apt install base-passwd -y
apt upgrade -y
apt-get install -y curl nano vim sudo apt-transport-https gnupg

DEBIAN_FRONTEND=noninteractive apt-get install -y kali-desktop-xfce
apt-get install -y kali-defaults tightvncserver
apt-get clean

rm -rf /var/lib/apt/lists/*

# Make a new user, and create a user home folder
useradd kalikid
mkhomedir_helper kalikid

#Makes a folder for the vnc password file to be added into later
mkdir -p /home/kalikid/.vnc"
chmod go-rwx /home/kalikid/.vnc"


apt update -y

apt-get install -y net-tools novnc


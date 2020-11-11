#!/usr/bin/env python3

import subprocess

# Get srv1 IP
server1ip = subprocess.getoutput('openstack server list | grep srv1 | awk '{print $9}'')

# Get amount of containers in srv1
containers = subprocess.getoutput('ssh ubuntu@'print(server1ip)' -i gruppe4.pem docker ps -a | wc -l')

# There should be 3 docker images with the corresponding variants named
variant = pentest#, forensics eller stego

# Number of the first ports used to run a docker container.
port1 = 25901
port2 = 25911
# In order to run a container. It has to increment the port value by 1, and take in the kali variant parameter
runcontainer = subprocess.run('docker run -t -d --name kali4 -p' print(port1++)':5900 -p' print(port2++)':5901' print(variant))

# Start a new machine
newmachine = subprocess.run('blablabla start srv3...')


# If the docker images is not present on the server, then build them
#if docker images | grep pentest && forensics && stego !
#   ssh ubuntu@server docker build -t $variant .
#else


# If srv1 has more or less than 10 containers
if containers < 10:
    # If number is less than 10, then run a new container from the variable runcontainer.
    exec runcontainer

else:
    # Else chech how many containers there are no server 2. If server 2 is not present, create it
    exec






# How one can increment ports in bash
# note that this only takes one port
#
#for x in $(seq 0 4); do
#  # increment the port number
#  port=$((9220 + $x))
#  sudo docker run -it -d  \
#  -p=0.0.0.0:$port:9222 \
#  --name kali-$x \
#  kali
#done

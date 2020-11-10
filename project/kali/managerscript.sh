#!/bin/bash

server1ip=$(10.212.138.28)

#containers=$(ssh ubuntu@10.212.136.184 -i gruppe4.pem | docker ps  -a | wc -l)

containers=$(ssh ubuntu@10.212.136.184 -i gruppe4.pem | ls -a)

echo $containers
#if [ $containers -gt 10 ]
#then
    # ssh ubuntu$server2 | $containers
    # if $containers fra server 2 > 10
    # ssh ubuntu$server2 | ./runContainer.sh


    # If server 2/x ikke finnes
    # lag ny server
    # wait noen sekunder
    # ssh ubuntu@NewMachine | ./runContainer.sh
#else
#    ssh ubuntu@server1 | ./runContainer.sh
#fi

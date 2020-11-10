#!/bin/bash
docker run -t -d --name kali2 -p 25906:5900 -p 25907:5901 kali
                                   x             x
#                        Endre port hvor det er en x
# For å koble på denne så skriv 127.0.0.1:25907


# VIKTIG!
# kj�r buildcontainer.sh hvis ikke imaget 'kali' eksisterer

# Pseudokode for neste update

# docker run -t -d --name kali1 -p 25904:5900++ -p 25905:5901++ kali

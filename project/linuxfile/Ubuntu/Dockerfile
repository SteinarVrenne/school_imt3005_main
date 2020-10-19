FROM ubuntu:20.04

# ENV

# Installerer XFCE Desktop + noen vanlige pakker
RUN apt-get update && apt-get install -y \
xfce4 xfce4-goodies -y \
    wget \
    nano \
    vim  \
    git \
    curl \
    net-tools \
    build-essential \
	openssh-server && \
    rm -rfv /var/lib/apt/lists/*

# Open VNC port
EXPOSE 5901



# XFCE Language settings. Fix:Sett til norsk
#FROM ubuntu as xfce

#ENV \
#    DEBIAN_FRONTEND=noninteractive \
#    LANG='en_US.UTF-8' \
#    LANGUAGE='en_US:en' \
#    LC_ALL='en_US.UTF-8'

# Spesifiserer VNC port for display
ENV DISPLAY=:1 \
    VNC_PORT=5901


# Laste ned, og installere BurpSuite
RUN wget -O ./burp.jar 'https://portswigger.net/burp/releases/download' \
    && chmod +x ./burp.jar \
    && java -jar ./burp.jar

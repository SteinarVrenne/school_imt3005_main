FROM kalilinux/kali-rolling

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y \
        curl sudo apt-transport-https gnupg \
        x11vnc xvfb novnc dbus-x11 wget \
        kali-defaults kali-desktop-xfce && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*



ENV DISPLAY :1
ENV KALI_DESKTOP kali-desktop-xfce

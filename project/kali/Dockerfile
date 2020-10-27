FROM haraldaarz/kali_xfce_barebone


#TODO: VNC password

#TODO: VNC Systemd


#TODO: Installere spesifiserte programmer fra parameter
# Eksempel
## ADD ./script/tools/forensics.sh
## RUN ./script/tools/forensics.sh

#TODO: Start VNC


# Start VNC client
tightvncserver :0 -geometry 1900x940 -depth 16 -pixelformat rgb565




# Start VNC server
/usr/share/novnc/utils/launch.sh --listen 5901 --vnc localhost:5900

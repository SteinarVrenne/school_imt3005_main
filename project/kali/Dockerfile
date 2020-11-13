FROM haraldaarz/kali_xfce_top10


#TODO: Installere spesifiserte programmer fra parameter
# Eksempel

RUN apt install -y expect

#ADD pentest.sh /
#RUN chmod +x /pentest.sh

#RUN /pentest.sh

#TODO: Start VNC

#Sets the vnc password
ADD /script/vncpasswd.sh /
RUN chmod +x /vncpasswd.sh
ENTRYPOINT /vncpasswd.sh


# Runs VNC server and client
ADD /script/vnc.sh /
RUN chmod +x /vnc.sh

ENTRYPOINT /vnc.sh



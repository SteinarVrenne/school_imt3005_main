#!/bin/sh

prog=/usr/bin/vncpasswd

/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$vnc_passwd\r"
expect "Verify:"
send "$vnc_passwd\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\n"
expect eof
exit
EOF

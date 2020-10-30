#!/bin/sh

prog=/usr/bin/vncpasswd
mypass="password"

/usr/bin/expect <<EOF
spawn "$prog"
expect "Password:"
send "$mypass\r"
expect "Verify:"
send "$mypass\r"
expect "Would you like to enter a view-only password (y/n)?"
send "n\n"
expect eof
exit
EOF

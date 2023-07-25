#!/bin/bash

sudo tee <<EOF >/dev/null /etc/3proxy/3proxy.cfg
nserver 8.8.8.8
nserver 8.8.4.4
nserver 1.1.1.1
nserver 1.0.0.1

nscache 65536
timeouts 1 5 30 60 180 1800 15 60

external `curl -s ifconfig.me`
internal `curl -s ifconfig.me`

daemon

log /var/log/3proxy/3proxy.log D
logformat "- +_L%t.%. %N.%p %E %U %C:%c %R:%r %O %I %h %T"
rotate 30

allow * * * 80-88,8080-8088 HTTP
allow * * * 443,8443 HTTPS

#proxy -p53129 -n -a
users user:CL:P@ssv0rd312

flush
auth iponly
allow * 135.181.206.113,135.181.202.25,47.253.53.46,47.253.81.245,65.108.239.251 * * * * *
proxy -p53129 -n -a

end
EOF


systemctl restart 3proxy

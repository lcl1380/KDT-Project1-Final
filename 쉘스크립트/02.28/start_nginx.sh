#!/usr/bin/expect -f

# Docker 컨테이너에 접속
spawn docker exec -it nginx-proxy bash

# 컨테이너 내에서 /etc/nginx으로 이동
send "cd /etc/nginx\r"

# Bash 쉘을 유지
interact

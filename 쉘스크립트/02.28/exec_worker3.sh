#!/usr/bin/expect

spawn docker exec -it worker3 bash

send "service ssh start\r"

send "su worker3"
send "cd ~\r"

send "echo 'worker3's IPAddress : ' && ifconfig | grep inet\r"

expect eof
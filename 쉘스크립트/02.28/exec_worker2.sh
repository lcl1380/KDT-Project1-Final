#!/usr/bin/expect

spawn docker exec -it worker2 bash

send "service ssh start\r"

send "su worker2"
send "cd ~\r"

send "echo 'worker2's IPAddress : ' && ifconfig | grep inet\r"

expect eof
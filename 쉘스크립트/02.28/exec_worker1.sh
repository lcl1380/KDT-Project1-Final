#!/usr/bin/expect

spawn docker exec -it worker1 bash

send "service ssh start\r"

send "su worker1"
send "cd ~\r"

send "echo 'worker1's IPAddress : ' && ifconfig | grep inet\r"

expect eof
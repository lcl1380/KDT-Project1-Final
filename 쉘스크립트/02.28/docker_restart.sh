#!/bin/bash

echo "모든 컨테이너들 stop : "
docker stop jenkins-host
docker stop nginx-proxy
docker stop log_collection
docker stop library_db

docker stop worker1
docker stop worker2
docker stop worker3

echo "" # 공백 삽입용

echo "모든 컨테이너들 restart :"
docker restart jenkins-host
docker restart nginx-proxy
docker restart log_collection
docker restart library_db

docker restart worker1
docker restart worker2
docker restart worker3

echo ""

echo "worker1 ssh 실행 및 IPAddress 확인 :"
docker exec -it worker1 service ssh start
docker exec -it worker1 bash -c "ifconfig | grep inet"

echo "worker2 ssh 실행 및 IPAddress 확인 :"
docker exec -it worker2 service ssh start
docker exec -it worker2 bash -c "ifconfig | grep inet"

echo "worker3 ssh 실행 및 IPAddress 확인 :"
docker exec -it worker3 service ssh start
docker exec -it worker3 bash -c "ifconfig | grep inet"
echo ""

echo "nginx 실행 : 이후의 nginx.conf 파일은 직접 수행해주세요"
echo "(그대로 입력) : worker들의 IP주소 확인 후,"
echo "               nano nginx.conf로 주소 변경해주기"
echo "               이후 service nginx start 입력"
./start_nginx.sh

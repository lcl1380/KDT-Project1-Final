#!/bin/bash

docker stop jenkins-host
docker stop nginx-proxy
docker stop log_collection
docker stop library_db

docker stop worker1
docker stop worker2
docker stop worker3

echo "모든 컨테이너들을 재시작합니다 :"
docker restart jenkins-host
docker restart nginx-proxy
docker restart log_collection
docker restart library_db

docker restart worker1
docker restart worker2
docker restart worker3
echo ""
# nginx-proxy 컨테이너에서 nginx 서비스 재시작
echo "nginx-proxy 컨테이너에서  nginx 서비스를 시작합니다 :"
docker exec -it nginx-proxy bash -c "service nginx start"
echo ""

echo "worker 컨테이너에서  ssh서비스를 재시작합니다 :"
docker exec -it worker1 bash -c "service ssh start"
echo "worker1 컨테이너 ssh 재시작 완료"
echo ""
docker exec -it worker2 bash -c "service ssh start"
echo "worker2 컨테이너 ssh 재시작 완료"
echo ""
docker exec -it worker3 bash -c "service ssh start"
echo "worker3 컨테이너 ssh 재시작 완료"

# jenkins-host를 root계정으로 실행
# docker exec -u 0 -it jenkins-host bash
echo ""
echo "모든 컨테이너에서 restart 완료, SSH 서비스가 재시작되었습니다."
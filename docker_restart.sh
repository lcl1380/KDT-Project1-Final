#!/bin/bash

docker restart jenkins-host
docker restart nginx-proxy
docker restart log_collection

docker restart worker1
docker restart worker2
docker restart worker3

# nginx-proxy 컨테이너에서 SSH 서비스 재시작
docker exec -it nginx-proxy bash -c "service ssh restart"'

echo "모든 컨테이너에서 restart 완료, SSH 서비스가 재시작되었습니다."
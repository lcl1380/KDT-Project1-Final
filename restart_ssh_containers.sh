#!/bin/bash

# Docker 컨테이너에서 SSH 서비스 재시작 스크립트

# jenkins-host 컨테이너에서 SSH 서비스 재시작
#docker exec -it jenkins-host bash -c "service ssh restart"

# worker1 컨테이너에서 SSH 서비스 재시작
#docker exec -it worker1 bash -c "service ssh restart"

# worker2 컨테이너에서 SSH 서비스 재시작
#docker exec -it worker2 bash -c "service ssh restart"

# worker3 컨테이너에서 SSH 서비스 재시작
#docker exec -it worker3 bash -c "service ssh restart"



# nginx-proxy 컨테이너에서 SSH 서비스 재시작
docker exec -it nginx-proxy bash -c "service ssh restart"'

echo "모든 컨테이너에서 SSH 서비스가 재시작되었습니다."

#!/bin/bash

docker restart jenkins-host
# docker restart reverse_proxy
docker restart log_collection

docker restart worker1
docker restart worker2
docker restart worker3

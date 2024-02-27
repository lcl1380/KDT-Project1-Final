[##_Image|kage@tSuwg/btsFinBDCMQ/h3fWMotdLNc1AkkICc2lJk/img.png|CDM|1.3|{"originWidth":2000,"originHeight":1258,"style":"alignCenter","caption":"생각해본 인프라 구조"}_##]

---

## **네트워크 설정**

[##_Image|kage@bDVDcs/btsFgSoOtAw/h4FCUqH2pBLKaStVaxog0k/img.png|CDM|1.3|{"originWidth":723,"originHeight":108,"style":"alignCenter"}_##]

```
# 프론트, 백 네트워크 설정
$ docker network create --driver=bridge back-network
$ docker network create front-network
```

---

[##_Image|kage@8UgrN/btsFmgIgRU1/cHY9Gl0NSFEtjduLZYCSYk/img.png|CDM|1.3|{"originWidth":706,"originHeight":118,"style":"alignCenter"}_##]

```
# Java 설치 & 버전 확인
$ sudo apt update
$ sudo apt install openjdk-17-jdk
$ java -version
```

---

## **Jenkins 환경설정**

```
# Jenkins 이미지 다운로드
# 8080은 이전에 썼던 springboot와 충돌날 경우가 있으므로 9090으로 진행, front-network에 연결
$ docker run -d -p 9090:8080 --net front-network --name jenkins-host jenkins/jenkins

# 이후 localhost:9090으로 접속 가능
# 가상머신 밖일 경우 192.168.56.202:9090

# Jenkins에 접속
$ docker exec -it jenkins-host bash

# cat을 이용하여 암호를 표시
$ cat /var/jenkins_home/secrets/initialAdminPassword
f28f20a9f920426c87d7af38cea1c626
```

[##_ImageGrid|kage@bpWzEq/btsFmeKuCNA/7KL02a4YI8vQOsDWm5Pyk1/img.png,kage@ef6KYE/btsFmliw0pC/AN5FVIq5kHiqMOK2JKstuk/img.png|data-origin-width="727" data-origin-height="609" data-is-animation="false" style="width: 29.9712%; margin-right: 10px;" data-widthpercent="30.32",data-origin-width="875" data-origin-height="319" data-is-animation="false" style="width: 68.866%;" data-widthpercent="69.68"|_##]

### **ssh 설정 및 배포 파이프라인 초기구축**

```
# 젠킨스쪽 터미널에서 ssh 키 발급
# 아무것도 입력하지 않은 상태로 Enter 키를 두 번 누른다
$ ssh-keygen -t rsa -f ~/.ssh/id_rsa

# 생성된 공개키 / 개인키의 주소 확인
cd .ssh
cat id_rsa.pub
cat id_rsa
```

vi에디터나 nano 편집기 등을 이용하여 id\_rsa.pub의 내용을 복사한다 (펼치기 확인)

더보기

```
# jenkins 컨테이너의 공개키
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGywaevvKs+4mOC+MgFLbFlFLb7i+U8Vw015StkX3vn4TO0jg3m1fuuYWW9+7Tkx9Sh99VvTHMv7N8zMuTCA0fEQqaps98u7L7ey2bdshO+AYl6WErbYm4iI8HZwD+v0IXBoL42TTfPePe1D8HPn79EgKTGZnAZe9CiMrlRRjx0jSIfHTsFTCbk2udIQx+QsJvd2GV3sFJZLkK2Wf1L7tmkPEi+RB0rVTJ1GwL89KpZ8n1XNTbZX/NcVLgfYKanGvmLZBaRbiP7d+jgEnyHA/9TBmS8FSICHdFUrEIXvmMIKyyxtySfi7npW9SjO5FoW/UcRN8+TXNJytHEMJMMUhrhrh+PPXjYfIMq+sSCuPcJQamoemyBD9IQ0vfCL0gUZyInL84EO651t/NyROYV/cSV4qL9wo8MW+0/PVos/kG8d6Twborficny3uDx69x0ljlxi1Oo8CnzS9ijMi6b4KLpOVx09MxmZeZZxe1WZTrmGpp/13sTECSe8RgsCh9sDM= jenkins@23aa4ac88d68

# jenkins 컨테이너의 개인키
-----BEGIN OPENSSH PRIVATE KEY-----

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

-----END OPENSSH PRIVATE KEY-----
```

이후는 [https://cherish-days02.tistory.com/500](https://cherish-days02.tistory.com/500) 참고

jenkins 안에 nginx 서버 만들기.

[https://cherish-days02.tistory.com/507](https://cherish-days02.tistory.com/507)

 [KDT 39일차 (reverse proxy)

cherish-days02.tistory.com](https://cherish-days02.tistory.com/507)
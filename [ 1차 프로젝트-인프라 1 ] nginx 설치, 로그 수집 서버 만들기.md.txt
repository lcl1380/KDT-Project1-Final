## **nginx 이미지 사용**

[##_Image|kage@91zNI/btsFmiM8HVK/P4vwXTh9HIPV1HLkWeARDK/img.png|CDM|1.3|{"originWidth":953,"originHeight":340,"style":"alignCenter"}_##]

```
$ docker run -it -d --name=reverse_proxy --net=front-network nginx:latest bash
$ docker exec -it reverse_proxy bash
```

완성되어있는 이미지 컨테이너로 띄워서 활용

[##_Image|kage@BQrhO/btsFkTUDmle/mFm1D0taVhJTxcBTa83Mgk/img.png|CDM|1.3|{"originWidth":711,"originHeight":289,"style":"alignCenter"}_##]

우선 nginx를 실행한 다음, 서버가 돌아가는 것을 확인한다.

```
apt update
apt install nano -y
nano /etc/nginx/nginx.conf
```

conf 파일을 reverse proxy 기능을 수행가능하도록 변경하기 위해 수정한다.

[##_File|kage@pJKQj/btsFiNACvM5/lU1fvQJvYDY5kRI3OKGHu0/tfile.conf|filename="nginx.conf" size="0.00MB" data-ke-align="alignCenter"|_##]

(파일) nginx.conf 원본 파일

[##_Image|kage@crOMdj/btsFiPLW8vT/KDMOoIoXQCAKjRvmNKRyi0/img.png|CDM|1.3|{"originWidth":1262,"originHeight":97,"style":"alignCenter","caption":"이런 식으로 구분하기 위함"}_##]

```
adduser reverse_proxy

nano /etc/sudoers
...

# User privilege specification

root    ALL=(ALL:ALL) ALL

worker1  ALL=(ALL:ALL) ALL

...
```

헷갈리므로 adduser를 이용해서 reverse\_proxy 유저를 만들어주었다

```
mkdir ~/.ssh
cd ~/.ssh

nano authorized_keys
# id_rsa.pub 내용 붙여넣기

sudo apt install openssh-server
nano -l /etc/ssh/sshd_config
# 14번, 38번, 57번 라인 주석 해제

service ssh restart
```

젠킨스에 의해 관리될 수 있도록 연결해주었다

---

## **로드밸런싱 위한 서버 3개 생성**

nginx 서버 설정하기 전에, back-network 단에 있는 서버 3개 만들어보자  
생성 과정 자체는 worker 1,2,3 만드는 과정 참고함!

```
# reverse_proxy 안에서 진행
apt-get update && apt-get install -y net-tools

# reverse_proxy에 back-network 물리기
docker network connect back-network reverse_proxy
```

우선은 nginx서버인 reverse\_proxy 컨테이너를 back-network에도 연결해주었다

[##_Image|kage@MFVVa/btsFmhgpN18/XH9CuOMoAuTjekmlFagjPk/img.png|CDM|1.3|{"originWidth":791,"originHeight":367,"style":"alignCenter"}_##]

네트워크 확인

```
docker run -d -it --net=back-network --name=worker1 ubuntu:22.04
docker run -d -it --net=back-network --name=worker2 ubuntu:22.04
docker run -d -it --net=back-network --name=worker3 ubuntu:22.04
```

reverse-proxy 컨테이너가 로드밸런싱 할 서버 3개를 만들어주었다

```
# worker1~3에 반복
docker exec -it worker1 bash
apt update
apt install sudo
apt install nano
adduser worker1

nano /etc/sudoers
...

# User privilege specification

root    ALL=(ALL:ALL) ALL

worker1  ALL=(ALL:ALL) ALL

...

sudo apt-get install net-tools


# 이건 젠킨스 연결 하려고 쓰는거긴 한데.. 일단 놔둬보자 ..
mkdir ~/.ssh/
cd ~/.ssh

nano authorized_keys
```

각 서버들의 설정을 완료해주자

[##_Image|kage@934Md/btsFlVrcnVI/KyaCtEebQmSQnXooGPfmK1/img.png|CDM|1.3|{"originWidth":680,"originHeight":518,"style":"alignCenter"}_##]

nginx가 돌아가는 reverse\_proxy 컨테이너에 접속해서 \`service nginx start\`로 서버를 실행하고,

\`curl localhost\`로 서버가 돌아가는 것을 확인하자

[##_Image|kage@vcsVq/btsFh6tGala/guuB21dg5ovZvCKQUz3Lk1/img.png|CDM|1.3|{"originWidth":503,"originHeight":78,"style":"alignCenter"}_##]

nginx.conf 파일을 리버스 프록시 수행 가능하도록 변경하기 위해 수정하자

[##_Image|kage@wDlpp/btsFmlwrkFL/JsYIBfN55bKCNbCZayUrS0/img.png|CDM|1.3|{"originWidth":727,"originHeight":625,"style":"alignCenter"}_##]

\`sudo nano /etc/nginx/nginx.conf\`로 설정 파일을 수정해주자.

```
include   /etc/nginx/conf.d/default.conf
```

해당 라인은 우선적으로 default.conf 파일에 기입된 설정을 따른다는 의미인데,  
우리는 nginx.conf의설정을 따라야 하기 때문에 해당 라인을 발견하면 지워주자

```
http{
	...다른구문들...
	
	upstream cpu-bound-app {
	  server {instance_1번의_ip}:8080 weight=100 max_fails=3 fail_timeout=3s;
	  server {instance_2번의_ip}:8080 weight=100 max_fails=3 fail_timeout=3s;
	  server {instance_3번의_ip}:8080 weight=100 max_fails=3 fail_timeout=3s;
	}
	server {
		location / {
		  proxy_pass http://cpu-bound-app;
		  proxy_http_version 1.1;
		  proxy_set_header Upgrade $http_upgrade;
		  proxy_set_header Connection 'upgrade';
		  proxy_set_header Host $host;
		  proxy_cache_bypass $http_upgrade;
		}
	}
}
```

\`http { }\`안에 위의 내용을 추가해주자

[##_Image|kage@xma7F/btsFmhng4ld/YfenwK7L7qKV5O2HYSXS2k/img.png|CDM|1.3|{"originWidth":1240,"originHeight":657,"style":"alignCenter"}_##]

설정이 완료되었으면 nginx 설정파일을 재입력해주자

```
sudo systemctl reload nginx
혹은
service nginx reload
```

제대로 처리되었다면 개별 배포서버의 주소를 알아야 하는게 아니라  
위와같이 로드밸런서의 주소만 알아도 개별 서비스에 접근할 수 있게 된다.

---

## **로그 수집 서버 생성**

```
# su log_collection
docker run --name=log_collection -itd --net=back-network ubuntu:22.04

apt update
apt install nano
apt install sudo
apt install net-tools
```

로그 수집 서버를 만들어주었다.

front-network에 있는 reverse\_proxy는 back-network랑도 연결되어 있으므로 로그 수집 서버로 데이터 전송도 가능할 것임
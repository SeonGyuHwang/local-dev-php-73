#info
기존꺼와 달리 nginx-proxy를 사용하여 vhost.conf가 필요없음  

~~~
OS: Ubuntu 
SERVER: Apache
LANG: PHP 7.3
DB: MySQL, Oci8-2.2
~~~

#셋팅
~~~
1) https://www.docker.com/ 에서 OS에 맞는 docker 를 다운받아 설치

2) Setting -> Resources -> Shared Drives -> workspace 폴더 있는 드라이브 접근 허용 체크

3) CMD창에 접속하여 docker -v 를 눌러서 버전이 뜨는지 확인되면 정상 설치 완료

4) 아래의 커맨드를 순서대로 수행 
~~~

#빌드 & 실행
~~~
기본 workspace폴더 경로는 /mnt/d/workspace 입니다
위 경로와 틀릴경우 docker-compose.yml 에서 volumes부분의 경로를 수정해주세요

docker-compose up -d

※ -d 는 백그라운드 돌리는 옵션
※ OS별 hosts 파일에 다음과 같이 추가해주세요 
127.0.0.1 my.project.co.kr
~~~

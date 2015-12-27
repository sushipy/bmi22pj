FROM ubuntu:14.04

MAINTAINER tera <tera1215@gmail.com>

# TZ set
RUN echo "Asia/Tokyo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

# common pkg install
RUN apt-get update && apt-get install -y\
 git-core\
 curl\
 unzip\
 build-essential\
 libcurl4-openssl-dev\
 software-properties-common\
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y\
 mysql-client\
 libmysqlclient-dev\
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y\
  python-dev\
  python-pip\
  && rm -rf /var/lib/apt/lists/*

EXPOSE 8001

ADD src /src
RUN chmod +x /src/entrypoint.sh

CMD ["/src/entrypoint.sh"]

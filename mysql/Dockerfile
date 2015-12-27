FROM ubuntu:14.04

MAINTAINER tera <tera1215@gmail.com>

# Disabled interactive mode
ENV DEBIAN_FRONTEND noninteractive

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
 mysql-server\
 && rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql
VOLUME /var/lib/mysql
RUN sed -i -e 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf\
 && sed -i -e "44i skip-character-set-client-handshake" /etc/mysql/my.cnf\
 && sed -i -e "44i character-set-server\t= utf8" /etc/mysql/my.cnf\
 && sed -i -e "s/^#general_log_file/general_log_file/" /etc/mysql/my.cnf\
 && sed -i -e "s/^#general_log/general_log/" /etc/mysql/my.cnf\
 && sed -i -e "s/^#log_slow_queries/log_slow_queries/" /etc/mysql/my.cnf\
 && sed -i -e "s/^#long_query_time.*/long_query_time = 1/" /etc/mysql/my.cnf

EXPOSE 3306

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

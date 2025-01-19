FROM debian:bullseye

ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

ADD sources.list /etc/apt/

RUN apt-get update && apt-get -y install cron 

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]


RUN (crontab -l ; echo '*/1 * * * * /sh/to-flume-secondrun.sh >> /logs/to-flume-cron.log 2>&1 &' ) | crontab -
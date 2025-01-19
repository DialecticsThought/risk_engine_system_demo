#!/bin/sh

## 清空数据

if [ -f "volumes/flume/flume-to-kafka.pid" ];then
    kill `cat volumes/flume/flume-to-kafka.pid`
fi

if [ -f "volumes/flume/flume-to-kafka-test.pid" ];then
    kill `cat volumes/flume/flume-to-kafka-test.pid`
fi

if [ "$(docker ps -a -q | wc -l)" != "0" ];then
    docker stop `docker ps -a -q`
    docker rm `docker ps -a -q`
fi

docker-compose down
rm -rf volumes
rm -rf config/nodejs/amis
rm -rf config/nodejs/node_modules
rm -rf jar

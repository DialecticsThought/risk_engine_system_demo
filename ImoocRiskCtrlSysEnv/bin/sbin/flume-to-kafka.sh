#!/bin/sh

str=$"\n"

docker-compose exec flume /opt/flume/bin/flume-ng agent -c /opt/flume/conf -f /imooc-flume-conf/kafka-sink.properties -n imooc-ng -Dflume.monitoring.type=http -Dflume.monitoring.port=36001 >/dev/null 2>&1 & echo $! > volumes/flume/flume-to-kafka.pid


echo -e "\e[32m ============ 监控目录数据 (后缀应该变为.delete) =============== \e[0m"
ls volumes/flume/dataset
echo -e "\n"
echo -e "\e[33m ## 日志是WARN级别,没有错误输出就是数据已经写入Kafka ## \e[0m"
echo -e "\e[33m ## 10秒后清屏 ## \e[0m"
timeout 10 tail -f volumes/flume/logs/flume.log
clear



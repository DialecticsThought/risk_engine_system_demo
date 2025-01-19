#!/bin/sh

echo -e "\n"
echo -e "\e[33m ## 解压 amis.tar.gz ## \e[0m"
tar xzf ../amis.tar.gz
echo -e "\e[33m ## 解压 nodejs.tar.gz ## \e[0m"
tar xzf ../nodejs.tar.gz
echo -e "\e[33m ## 解压 docker-compose.tar.gz ## \e[0m"
tar xzf ../docker-compose.tar.gz

mv docker-compose /usr/local/bin
ls /usr/local/bin/docker-compose
mv amis config/nodejs/
mv node_modules config/nodejs/
echo -e "\e[33m ## 移到 amis,node_modules 到 config/nodejs ## \e[0m"
ls config/nodejs/
cp ../flink-shaded-hadoop-2-uber-2.8.3-10.0.jar config/hadoop/
echo -e "\e[33m ## 移到 flink-shaded-hadoop-2-uber-2.8.3-10.0.jar 到 config/hadoop ## \e[0m"
ls config/hadoop/
cp -r ../jar ./

mkdir -p volumes/zookeeper/data
mkdir -p volumes/dfs/name
mkdir -p volumes/dfs/data
mkdir -p volumes/dfs/tmp
mkdir -p volumes/clickhouse
mkdir -p volumes/redis
mkdir -p volumes/flume/imooc-chn-chk
mkdir -p volumes/flume/imooc-chn-data
mkdir -p volumes/flume/imooc-position
mkdir -p volumes/flume/dataset
mkdir -p volumes/flume/logs
mkdir -p volumes/prometheus/grafana-data
mkdir -p volumes/mysql/data
mkdir -p volumes/crontab/logs

touch volumes/flume/imooc-position/taildir_position.json

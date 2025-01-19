#!/bin/bash


docker-compose down
source bin/sbin/crontab-reset.sh


source bin/tools/start-kafka.sh
source bin/tools/start-flume.sh
source bin/tools/start-clickhouse.sh


docker-compose up -d crontab

echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh crontab

echo -e "\e[33m ### 等待5秒,让组件完全启动 #### \e[0m"
echo -e "\e[33m ### 等待5秒,让组件完全启动 #### \e[0m"
sleep 5

source bin/sbin/flume-to-kafka.sh
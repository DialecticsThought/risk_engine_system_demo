#!/bin/bash

docker-compose up -d kafka1
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh zookeeper
source bin/tools/status.sh kafka1

echo -e "\e[33m ### 等待20秒,kafka创建Topic #### \e[0m"
echo -e "\e[33m ### 等待20秒,kafka创建Topic #### \e[0m"
sleep 20

echo -e "\n"
echo -e "\e[33m ############## 确保 kafka Leader和ISR 不要为None ############# \e[0m"
source bin/sbin/kafka-list-topic.sh

#!/bin/bash

docker-compose up -d prometheus
docker-compose up -d grafana
source bin/tools/start-flume.sh
echo -e "\n"
echo -e "\e[32m ============= 等待10秒 ============== \e[0m"
echo -e "\n"
sleep 10
docker-compose up -d flume_exporter
docker-compose up -d kafka_exporter
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh prometheus
source bin/tools/status.sh grafana
source bin/tools/status.sh flume_exporter
source bin/tools/status.sh kafka_exporter

echo -e "\n"
echo -e "\e[33m ############################ \e[0m"
echo "grafana(用户名: admin, 密码: 123456): http://grafana:3000/  "
echo ""
echo -e "\n"
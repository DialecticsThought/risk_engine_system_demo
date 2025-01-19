#!/bin/bash

docker-compose up -d hadoop
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh hadoop

echo -e "\n"
echo -e "\e[33m ########################### \e[0m"
echo "hdfs: http://hadoop:50070/"
echo "datanode: http://hadoop:50075/"
echo "resourcemanager: http://hadoop:8088/"
echo "nodemanager: http://hadoop:8042/"
echo -e "\n"
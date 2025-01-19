#!/bin/bash

docker-compose up -d hbase
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh hbase
source bin/tools/status.sh hadoop
source bin/tools/status.sh zookeeper
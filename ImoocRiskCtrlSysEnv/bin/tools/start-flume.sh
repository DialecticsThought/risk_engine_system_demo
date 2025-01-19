#!/bin/bash

docker-compose up -d flume
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh flume
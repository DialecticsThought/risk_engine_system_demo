#!/bin/bash

docker-compose up -d nodejs
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh nodejs

echo -e "\n"
echo -e "\e[33m ########################### \e[0m"
echo "风控引擎运营后台: http://nodejs:6080"
echo -e "\n"
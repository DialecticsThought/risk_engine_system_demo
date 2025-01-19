#!/bin/bash

docker-compose up -d redis
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh redis
#!/bin/sh


docker-compose exec jobmanager /bin/sh -c "/opt/flink/bin/flink run --class $1 /opt/flink/jar/$2.jar"


echo -e "\n"
echo -e "\e[33m ####### 结果打印需要通过日志查看 ########## \e[0m"
echo "sh bin/logs.sh taskmanager-1 或"
echo "sh bin/logs.sh taskmanager-2 或"
echo "sh bin/logs.sh taskmanager-3 "
echo -e "\n"
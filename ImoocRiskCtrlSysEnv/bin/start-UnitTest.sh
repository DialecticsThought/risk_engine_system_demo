#!/bin/sh

docker-compose down

sh bin/tools/start-redis.sh
sh bin/tools/start-hbase.sh
sh bin/tools/start-clickhouse.sh
sh bin/tools/start-mysql.sh
sh bin/tools/start-kafka.sh
sh bin/tools/start-flume.sh

echo -e "\e[33m ### 等待20秒,让组件完全启动 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 #### \e[0m"
sleep 20

echo -e "\n"
echo -e "\e[32m ========= flume 导入数据到 Kafka ============== \e[0m"
echo -e "\n"
source bin/test/flume-to-kafka-test.sh

echo -e "\n"
echo -e "\e[33m ========== 启动完成, 可以在idea进行单元测试 ======== \e[0m"
echo -e "\n"

echo -e "\e[33m ####### hbase webUI ########## \e[0m"
echo "master: http://hbase:60010/"
echo "regionserver: http://hbase:60030/"
echo -e "\n"

echo -e "\e[33m ####### hadoop webUI ########## \e[0m"
echo "hdfs: http://hadoop:50070/"
echo "datanode: http://hadoop:50075/"
echo "resourcemanager: http://hadoop:8088/"
echo "nodemanager: http://hadoop:8042/"
echo -e "\n"


echo -e "\e[33m ####### flink webUI ########## \e[0m"
echo "http://flink:8081/"
echo -e "\n"

echo -e "\e[33m ####### kafka comsumer ########## \e[0m"
echo "消费数据: sh bin/test/kafka-consumer-test.sh"
echo -e "\n"

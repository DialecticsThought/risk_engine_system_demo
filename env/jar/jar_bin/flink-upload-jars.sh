#!/bin/sh


chmod 777 -R jar/

sh bin/start-flink.sh

docker-compose exec jobmanager /bin/sh -c "mkdir -p /opt/flink/jar"
docker-compose cp jar/jar/. jobmanager:/opt/flink/jar
docker-compose exec jobmanager /bin/sh -c "ls -l /opt/flink/jar"


echo -e "\n"
echo -e "\e[33m ####### 提交到 Flink Standalone 集群运行 ########## \e[0m"
echo -e "\n"
echo "Flink批处理计算词频: "
echo "sh jar/jar_bin/flink-execute-jobs-standalone.sh BatchAndStream.WordCountByBatchWithDataStreamApi WordCountByBatch" 
echo -e "\n"
echo "Flink流计算方式计算词频: "
echo "sh jar/jar_bin/flink-execute-jobs-standalone.sh BatchAndStream.WordCountByStreamWithLambda WordCountByStream" 
echo -e "\n"


echo -e "\n"
echo -e "\e[33m ####### 提交到 Flink on Yarn 集群运行 ########## \e[0m"
echo -e "\n"
echo "Flink批处理计算词频: "
echo "sh jar/jar_bin/flink-execute-jobs-yarn.sh BatchAndStream.WordCountByBatchWithDataStreamApi WordCountByBatch" 
echo -e "\n"
echo "Flink流计算方式计算词频: "
echo "sh jar/jar_bin/flink-execute-jobs-yarn.sh BatchAndStream.WordCountByStreamWithLambda WordCountByStream" 
echo -e "\n"

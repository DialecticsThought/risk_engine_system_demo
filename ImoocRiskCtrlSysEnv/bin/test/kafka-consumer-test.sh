#!/bin/bash


# consume test-topic

docker-compose exec kafka1 /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic imooctest --group imooc-test --from-beginning

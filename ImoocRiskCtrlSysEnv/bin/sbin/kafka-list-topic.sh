#!/bin/bash


docker-compose exec kafka1 /opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181 --list


docker-compose exec kafka1 /opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181 --describe --topic imoocevent


docker-compose exec kafka1 /opt/kafka/bin/kafka-topics.sh --zookeeper zookeeper:2181 --describe --topic imooctest

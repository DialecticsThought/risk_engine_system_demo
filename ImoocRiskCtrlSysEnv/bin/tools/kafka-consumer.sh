#!/bin/bash


# consume event-topic

docker-compose exec kafka1 /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka1:9092 --topic imoocevent --group console-riskengine --from-beginning

#!/bin/bash

docker-compose up -d clickhouse
echo -e "\e[32m =========================== \e[0m"
source bin/tools/status.sh clickhouse

echo -e "\n"
echo -e "\e[33m ########################### \e[0m"
echo "Flume导数据到Kafka,ClickHouse自动拉取kafka行为数据,按行为时间升序排列: "
echo "目标表: rods.dwd_analytics_event_from_kafka_res"
echo -e "\n"
echo "按用户分组,将指定时间段的每个用户的所有行为事件放到数组里,且按行为时间升序排列: "
echo "目标表: rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script"
echo -e "\n"
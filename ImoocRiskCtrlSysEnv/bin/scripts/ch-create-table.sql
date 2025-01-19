SET allow_experimental_map_type=1;

CREATE DATABASE IF NOT EXISTS rods;
CREATE DATABASE IF NOT EXISTS rows;

DROP TABLE IF EXISTS default.ch_imooc_test;
DROP TABLE IF EXISTS rods.dwd_analytics_event_kafka_sync;
DROP TABLE IF EXISTS rods.dwd_analytics_event_from_kafka_res;
DROP VIEW IF EXISTS rods.dwd_analytics_event_kafka_mv;
DROP TABLE IF EXISTS rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script;

CREATE TABLE IF NOT EXISTS default.ch_imooc_test (`name` String) ENGINE = TinyLog;
insert into default.ch_imooc_test values('ch-imooc-test-1');
insert into default.ch_imooc_test values('ch-imooc-test-2');


CREATE TABLE IF NOT EXISTS rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script
(
    `user_id` UInt64,
    `event_sequence` Array(Tuple(UInt64,Tuple(String,DateTime,UInt32,String))),
    `window_time` DateTime
)
ENGINE = MergeTree()
ORDER BY user_id
SETTINGS index_granularity = 8192
;



CREATE TABLE IF NOT EXISTS rods.dwd_analytics_event_from_kafka_sync
(
    `user_id_int` UInt64,
    `event_name` String,
    `event_target_name` String,
    `event_time` DateTime
)
ENGINE = Kafka()
SETTINGS kafka_broker_list = 'kafka1:9092', 
         kafka_topic_list = 'imoocevent',
         kafka_group_name = 'clickhouse-riskengine', 
         kafka_format = 'JSONEachRow'
;

CREATE TABLE IF NOT EXISTS rods.dwd_analytics_event_from_kafka_res
(
    
    `user_id_int` UInt64,
    `event_name` String,
    `event_target_name` String,
    `event_time` DateTime
)
ENGINE = MergeTree()
order by event_time
;

CREATE MATERIALIZED VIEW IF NOT EXISTS rods.dwd_analytics_event_from_kafka_mv TO rods.dwd_analytics_event_from_kafka_res AS
SELECT 
    user_id_int,event_name,event_target_name,event_time
FROM rods.dwd_analytics_event_from_kafka_sync
;


-- 实现目标
-- 按用户分组, 把指定时间(每1小时)的用户所有行为事件放到数组里,按行为时间升序排列

-- WITH 关键字
-- 定义 sql 语块，这个语块可以被整个sql所使用

-- clickhouse 高阶函数
-- arrayCompact 数组相邻元素去重
-- arraySort 排序
-- groupArray 聚合
-- arraySort 数组元素排序
-- arrayFilter 数组元素过滤
-- toStartOfHour 按小时进行聚合


INSERT INTO 
    rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script(user_id,event_sequence,window_time)
SELECT
    *
FROM(
    WITH
        arraySort(
            -- x 指的是groupArray后的数组元素
            x->x.2.2,

            -- 使用 toStartOfHour 代替 arrayFilter, 把每1小时的用户所有行为事件放到数组里
            -- arrayFilter(
                -- x 指的是groupArray生成的数组元素
                -- x->x.2.2 >= '2023-01-01 00:00:00' AND x.2.2<= '2023-01-03 00:00:00',
                groupArray(
                -- groupArray生成的数组元素的数据类型：
                -- Tuple(UInt64,Tuple(String,DateTime,UInt32,String))
                                (
                                    user_id_int,
                                    (
                                        event_name,
                                        event_time,
                                        toInt32(event_time),
                                        event_target_name
                                    )
                                )
                            ) 
            -- )
        )As sorted_events
    SELECT
        user_id_int,
        sorted_events,
        toStartOfHour(event_time) as hours
    FROM rods.dwd_analytics_event_from_kafka_res 
    GROUP BY user_id_int,event_time
)
;

SELECT 
* 
FROM rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script
LIMIT 5
;


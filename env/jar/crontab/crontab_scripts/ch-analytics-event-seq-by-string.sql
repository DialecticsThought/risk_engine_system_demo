
-- 实现目标
-- 查询出领取优惠券到使用优惠券之间的一系列行为，条件
-- 1. 行为数量小于3,
-- 2. 或者行为间的时间差大于5分钟的行为数量小于3的用户


-- WITH
-- arrayEnumerate 获取数组下标
-- arrayFilter  数组筛选
-- arrayMap  数组遍历
-- arraySplit 数组向左拆分
-- arrayStringConcat 数组转字符串
-- arrayJoin 行转列
-- arrayDifference  数组相邻元素之间的差异
-- arrayReverseSplit 数组向右拆分


-- 实现步骤：
-- 1. 找出领取优惠券到使用优惠券之间的一系列行为
-- 2. 筛选出领取优惠券到使用优惠券之间的行为数量小于 3 的用户
-- 3. 筛选出领取优惠券到使用优惠券之间的行为之间，两两行为间的时间差大于5分钟的行为数量小于3 的用户


WITH 
    -- 获取领取优惠券之后的行为序列
    arrayMap(x -> if(x.2.1 == '领取优惠券', 1, 0), eventSequence) AS masks_start,
    arraySplit((x, y) -> y, eventSequence, masks_start) AS split_events_start_arr,
    split_events_start_arr[2] AS split_events_start,

    -- 获取领取优惠券之后,使用优惠券之前的行为序列
    arrayMap(x -> if(x.2.1 == '使用优惠券', 1, 0), split_events_start) AS masks_end,
    arrayReverseSplit((x, y) -> y, split_events_start, masks_end) AS split_events_end,
    split_events_end[1] AS split_events,

    -- 领取优惠券之后,使用优惠券之前的行为数量
    length(split_events) - 2 AS split_events_length,

    -- 筛选出领取优惠券到使用优惠券之间的行为之间，两两行为间的时间差大于5分钟的行为
    arrayFilter(
        x-> x > 300,
        arrayDifference(split_events.2.3)
    ) AS event_filter,

    -- 筛选出领取优惠券到使用优惠券之间的行为之间，两两行为间的时间差大于5分钟的行为数量
    length(event_filter) AS event_filter_length

SELECT
    userId
FROM
    rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script
WHERE
    split_events_length < 3 OR  event_filter_length < 3

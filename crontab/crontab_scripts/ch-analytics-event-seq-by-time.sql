
-- 实现目标
-- 查询出领取优惠券到使用优惠券的时间差小于10分钟的用户 (薅羊毛用户)

-- sequenceCount 序列查询
-- Array Join  行转列

SELECT

    user_id

FROM
(

    SELECT
        user_id,
        sequenceCount(
            '(?1)(?t<600)(?2)'
            )
            (
                path_time,
                path_name='领取优惠券',
                path_name='使用优惠券'
            ) AS seq

    FROM(

        SELECT
            events.1 as user_id,
            events.2.1 as path_name,
            events.2.2 as path_time
        FROM(

            SELECT
                events
            FROM
                rows.dwb_analytics_event_sequence_groupby_uid_eventTime_from_script
            Array Join eventSequence AS events

        )
    )
    group by user_id
)
WHERE seq >=1



#!/bin/bash


docker-compose cp jar/crontab/crontab_scripts/ch-analytics-event-sequence.sql clickhouse:/
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --multiquery < ch-analytics-event-sequence.sql"
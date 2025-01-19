#!/bin/bash


docker-compose cp bin/scripts/ch-analytics-event-seq-by-time.sql clickhouse:/
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --multiquery < ch-analytics-event-seq-by-time.sql"
#!/bin/bash


docker-compose cp bin/scripts/ch-create-table.sql clickhouse:/
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --multiquery < ch-create-table.sql"
echo -e "\e[32m ======== 打印输出clickhouse表 default库 ============== \e[0m"
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --query=\"select database,name from system.tables where database='default'\""
echo -e "\e[32m ======== 打印输出clickhouse表 rods库 ============== \e[0m"
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --query=\"select database,name from system.tables where database='rods'\""
echo -e "\e[32m ======== 打印输出clickhouse表 rows库 ============== \e[0m"
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --query=\"select database,name from system.tables where database='rows'\""
echo -e "\e[32m ======== 打印输出 default.ch_imooc_test ============== \e[0m"
docker-compose exec clickhouse /bin/bash -c "clickhouse-client --query=\"select * from default.ch_imooc_test limit 3\""
#!/bin/bash

docker-compose cp bin/scripts/hbase-create-table.txt hbase:/
docker-compose exec hbase /bin/bash -c "hbase shell /hbase-create-table.txt"
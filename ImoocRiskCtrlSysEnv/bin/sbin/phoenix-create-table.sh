#!/bin/bash

docker-compose cp bin/scripts/phoenix-create-table.sql hbase:/
docker-compose exec hbase /bin/bash -c "/opt/phoenix/bin/sqlline.py zookeeper /phoenixcreate-table.sql"
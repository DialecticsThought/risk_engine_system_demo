#!/bin/sh

docker-compose cp bin/scripts/imooc-RiskEngine-mysql.sql mysql:/
docker-compose cp bin/scripts/mysql-list-table.sql mysql:/
docker-compose exec -it mysql bash -c "mysql -uroot -p123456 < /imooc-RiskEngine-mysql.sql"
docker-compose exec -it mysql bash -c "mysql -uroot -p123456 < /mysql-list-table.sql"
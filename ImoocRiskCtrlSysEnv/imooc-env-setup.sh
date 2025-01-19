#!/bin/sh

echo -e "\n"
echo -e "\e[32m ========= 清空数据 ============== \e[0m"
echo -e "\n"
sh bin/sbin/clear-data.sh

# 临时关闭 swap
swapoff -a

echo -e "\n"
echo -e "\e[32m ========= 解压压缩包 ============== \e[0m"
echo -e "\n"
sh bin/sbin/make-data.sh


chmod 777 -R ./*

echo -e "\n"
echo -e "\e[32m ========= 构建镜像 ============== \e[0m"
echo -e "\n"
sh bin/sbin/images-build.sh

echo -e "\n"
echo -e "\e[32m ========= 初始化组件 ============== \e[0m"
echo -e "\n"
sh bin/tools/start-clickhouse.sh
sh bin/tools/start-hbase.sh
sh bin/tools/start-mysql.sh
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
echo -e "\e[33m ### 等待20秒,让组件完全启动 不要终止程序 安装还没完成 #### \e[0m"
sleep 20

echo -e "\n"
echo -e "\e[32m ========= 创建 clickhouse 表 ============== \e[0m"
echo -e "\n"
sh bin/sbin/clickhouse-create-table.sh


echo -e "\n"
echo -e "\e[32m ========= 创建 hbase 表 ============== \e[0m"
echo -e "\n"
sh bin/sbin/hbase-create-table.sh


echo -e "\n"
echo -e "\e[32m ========= 打印 phoenix 表 ============== \e[0m"
echo -e "\n"
sh bin/sbin/phoenix-create-table.sh


echo -e "\n"
echo -e "\e[32m ========= 创建 mysql 表 ============== \e[0m"
echo -e "\n"
sh bin/sbin/mysql-init.sh


echo -e "\n"
echo -e "\e[32m ========= 关闭所有容器 ============== \e[0m"
echo -e "\n"
docker-compose down


echo -e "\n"
echo -e "\e[32m =============== 安装结束 ============== \e[0m"
echo -e "\n"

echo -e "\e[33m ####### idea单元测试 启动脚本 ########## \e[0m"
echo "sh bin/start-UnitTest.sh"
echo -e "\n"

echo -e "\e[33m ####### 定时任务 启动脚本 ########## \e[0m"
echo "sh bin/tools/start-crontab.sh"
echo "定时任务1: 每2秒写入Flume,Flume导入Kafka, 模拟日志流"
echo "定时任务2: ClickHouse按用户分组,每3秒(模拟每小时)将每个用户过去1小时内的所有行为事件放入数组,且按行为时间升序排列"
echo -e "\n"


echo -e "\e[33m ####### 风控引擎运营后台 启动脚本 ########## \e[0m"
echo "sh bin/tools/start-nodejs.sh"
echo "http://nodejs:6080"
echo -e "\n"


echo -e "\e[33m ####### 普罗米修斯监控 启动脚本 && WebUI ########## \e[0m"
echo "sh bin/tools/start-prometheus.sh"
echo "grafana: http://grafana:3000/"
echo "用户名: admin, 密码: 123456"
echo -e "\n"
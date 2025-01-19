#!/bin/sh


echo -e "\e[32m ============ 重置日志数据 (监控目录应该为空) =============== \e[0m"

# 监控目录
flume_dir='volumes/flume/dataset'
# 日志目录
data_dir='jar/dataSet'

# 测试日志
test_log='*_test*'
if [ -f ${flume_dir}/${test_log} ];then
    rm -f ${flume_dir}/${test_log}
fi

delete_files=$(ls ${flume_dir}/*.log.delete 2> /dev/null | wc -l)

# 监控目录是否存在.log.delete
if [ "$delete_files" != "0" ];then
# 是
    for name in `ls ${flume_dir}/*.log.delete`;do mv $name ${name%.log.delete}.log;done

fi

log_files=$(ls ${flume_dir}/*.log 2> /dev/null | wc -l)
# 监控目录是否存在.log
if [ "$log_files" != "0" ];then
    ls ${flume_dir}/*.log | xargs -i echo mv {} {} | sed "s|${flume_dir}|${data_dir}|2g" | sh
fi

echo -e "\e[32m ============ 监控目录数据 =============== \e[0m"
ls ${flume_dir}
echo -e "\n"
echo -e "\e[32m ============ 日志目录数据 =============== \e[0m"
ls ${data_dir}
echo -e "\n"
echo -e "\e[32m ============ 10秒后清屏 =============== \e[0m"
sleep 10
clear
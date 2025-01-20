#!/bin/sh

# 监控目录
crontab_flume_dir='/flume'
# 日志目录
crontab_data_dir='/data'
# 定时日志
crontab_log_dir='/logs/to_flume'
# now
date=$(date '+%Y%m%d')

mkdir -p $crontab_log_dir

# 1~3随机数
i=$((RANDOM%3+1))


delete_files=$(ls ${crontab_flume_dir}/*.log.delete 2> /dev/null | wc -l)

if [ "`ls -A ${crontab_data_dir}`" != "" ];
# 若日志目录不为空
then
    # 移动前 i 个日志到监控目录
    ls ${crontab_data_dir} | head -n ${i} | xargs -i mv ${crontab_data_dir}/{} ${crontab_flume_dir}
    # 日志
    echo "移动 ${i} 个日志到 ${crontab_flume_dir} $(date '+%H:%M:%S')" >> ${crontab_log_dir}/${date}.log
# 若日志目录为空 且监控目录存在 .log.delete
elif [ "$delete_files" != "0" ];
then
    # 移动监控目录所有日志到日志目录,并改名
    ls ${crontab_flume_dir}/*.log.delete | xargs -i echo mv {} {} | sed "s|${crontab_flume_dir}|${crontab_data_dir}|2g" | sed "s|.log.delete|.log|2g" | sh &>> ${crontab_log_dir}/${date}.log
    # 日志
    echo "=== 清空 ${crontab_flume_dir} $(date '+%H:%M:%S')" >> ${crontab_log_dir}/${date}.log
else
    # 日志
    echo "[WARN] 监控目录不存在已被Flume处理的日志文件 ${crontab_flume_dir} $(date '+%H:%M:%S')" >> ${crontab_log_dir}/${date}.log
fi
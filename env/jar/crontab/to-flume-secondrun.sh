#!/bin/sh

# ##每2秒执行
step=2
  
for i in `seq 0 $step 60`
do  
    sh /sh/to-flume-crontab.sh    
    sleep $step 
done  
  
exit 0  
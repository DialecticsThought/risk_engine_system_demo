#!/bin/sh


docker-compose exec jobmanager /bin/sh -c "/opt/flink/bin/flink run -t yarn-per-job -Dyarn.application.name=imooc-$2 -yD yarn.containers.vcores=4 -Djobmanager.memory.process.size=3072mb -Dtaskmanager.memory.process.size=3072mb -Dtaskmanager.numberOfTaskSlots=4 -Denv.java.opts="-Dfile.encoding=UTF-8" -Drest.flamegraph.enabled=true --class $1 /opt/flink/jar/$2.jar"
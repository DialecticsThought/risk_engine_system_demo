#!/bin/sh

## hbase 镜像
docker rmi imoocriskctrlsysenv-hbase:latest
docker-compose build hbase

## crontab 镜像
docker rmi imoocriskctrlsysenv-crontab:latest
docker-compose build crontab
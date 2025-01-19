#!/bin/bash

docker-compose ps -a $1 --format json | awk -F, -v OFS='\t' '{print $6,$8}'
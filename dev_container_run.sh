#! /bin/bash

#location of pg db
export PG_DATABASE_LOCATION='/media/storespace/postgres/postgis-docker_db' 
export JUPYTER_WD=pwd 
docker compose -f /media/storespace/postgres/docker-compose.yml up \
| tee |grep -w "http://127[^\s]*" -o -m1 > ./link.txt
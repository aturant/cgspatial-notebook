#! /bin/bash

wget -O ./docker-compose.yml https://github.com/aturant/cgspatial-notebook/blob/master/docker-compose.yml
#location of pg db
export PG_DATABASE_LOCATION='/media/storespace/postgres/postgis-docker_db' 
export JUPYTER_WD=pwd 
docker compose -f ./docker-compose.yml up \
| tee |grep -w "http://127[^\s]*" -o -m1 > ./link2open.txt
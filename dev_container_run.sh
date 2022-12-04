#! /bin/bash

wget -O ./docker-compose.yml https://raw.githubusercontent.com/aturant/cgspatial-notebook/master/docker-compose.yml
#location of pg db
PG_DATABASE_LOCATION='/media/storespace/postgres/postgis-docker_db' \
	JUPYTER_WD=pwd \
	docker compose -f ./docker-compose.yml up \
		| { tee /dev/tty | grep -w "http://127[^\s]*" -o -m1 > ./link2open.txt;}
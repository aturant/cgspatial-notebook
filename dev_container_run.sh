#! /bin/bash
echo "Do you wish torun db?"
select yn in "Yes" "No" "Cancel"; do
    case $yn in
        Yes ) FILE = docker-compose.yml; break;;
        No ) FILE = docker-compose_nodb.yml; break;;
        Cancel ) exit;;
    esac
done



wget -O ./docker-compose.yml https://raw.githubusercontent.com/aturant/cgspatial-notebook/master/$FILE

#location of pg db
PG_DATABASE_LOCATION='/media/storespace/postgres/postgis-docker_db' \
	JUPYTER_WD=pwd \
	docker compose -f ./docker-compose.yml up \
		| { tee /dev/tty | grep -w "http://127[^\s]*" -o -m1 > ./link2open.txt;}
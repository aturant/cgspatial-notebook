#!/bin/bash


PS3="Select number, to say if start DB: "

select db in Yes No Quit
do
    case $db in
        "Yes")
           echo "$db - postgress would be started"
	   FILE='./docker-compose-db.yml'
	   break;;
        "No")
           echo "$db - No db would be started"
           FILE='./docker-compose-nodb.yml'
           break;;
        "Quit")
           echo "We're done, bye"
           break;;
        *)
           echo "Ooops";;
    esac
done

#wget -O ./docker-compose.yml https://raw.githubusercontent.com/aturant/cgspatial-notebook/master/$FILE

cp -il $FILE ./docker-compose.yml

#location of pg db
docker compose --file ./docker-compose.yml --env-file ./docker-compose-pathes.env up \
                | { tee /dev/tty | grep -w "http://127[^\s]*" -o -m1 > ./link2open.txt;}

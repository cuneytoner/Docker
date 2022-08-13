if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devmysql
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devmysql &> /dev/null; then
   echo "Docker is going to run" 
   docker run -itd --privileged --name devmysql  --env="MYSQL_ROOT_PASSWORD=Password1!"  --env="MYSQL_DATABASE=devdb" -p 3306:3306 -v /docker/mysql/conf.d:/etc/mysql/conf.d -v /docker/mysql/data:/var/lib/mysql mysql
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devmysql | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devmysql
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devmysql
fi

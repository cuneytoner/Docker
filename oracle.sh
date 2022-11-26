if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devoracle
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devoracle &> /dev/null; then
   echo "Docker is going to run" 
   docker run -d --name devoracle --env-file ./env/oracle.env -p 1521:1521 -p 5500:5500 -it --shm-size="8g" container-registry.oracle.com/database/standard
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devoracle | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devoracle
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devoracle
fi

if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devmongo
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devmongo &> /dev/null; then
   echo "Docker is going to run" 
   docker volume create    --name mongovolume --opt type=none --opt device=/docker/mongodb --opt o=bind
   docker run -itd --name devmongo -v mongovolume:/data/db -p 27018:27017 mongo:latest
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devmongo | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devmongo
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devmongo
fi

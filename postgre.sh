if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devpg
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devpg &> /dev/null; then
   echo "Docker is going to run" 
   docker run --privileged --name devpg -e POSTGRES_DB=devdb -e POSTGRES_PASSWORD=Password1! -d -p 5432:5432 -v /docker/postgresql/data:/var/lib/postgresql/data postgres
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devpg | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devpg
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devpg
fi

if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devdb2
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devdb2 &> /dev/null; then
   echo "Docker is going to run" 
   docker run -itd --name devdb2 --privileged=true -p 50000:50000 -e LICENSE=accept -e DB2INST1_PASSWORD=Password1! -e DBNAME=devdb -v /docker/db2/data:/database ibmcom/db2
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devdb2 | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devdb2
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devdb2
fi

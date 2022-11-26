if [ "$1" = "stop" ];  then
   echo "Docker running, is going to stop"
   docker container stop devmssql
   echo "Docker stopped"
   exit
fi

if ! docker ps -a --format '{{.Names}}' | grep -w devmssql &> /dev/null; then
   echo "Docker is going to run" 
   docker run -e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=Password1!' -p 1433:1433 -v /docker/mssql:/var/opt/mssql/data -v /docker/mssql/log:/var/opt/mssql/log -v /docker/mssql/secrets:/var/opt/mssql/secrets -d mcr.microsoft.com/mssql/server:2019-latest
else
   if docker ps -a --format '{{.Names}} {{.Status}}' | grep -w devmssql | grep -w Up &> /dev/null; then
      echo "Docker running, is going to stop"
      docker container stop devmssql
      echo "Docker stopped"
   fi
   echo "Docker is going to start"
   docker container start devmssql
fi

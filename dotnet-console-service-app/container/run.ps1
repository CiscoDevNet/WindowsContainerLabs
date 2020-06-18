docker build -t iogbole/ioservicechecker:latest . 
#docker run -d --env-file env.list.local iogbole/ioservicechecker:latest
docker ps 
#docker push iogbole/ioservicechecker:latest
docker push iogbole/ioservicechecker:latest

#docker cp ./start-agent-1.ps1 container_id:c:/appdynamics/start-agent-1.ps1
#docker exec -it container_id powershell 
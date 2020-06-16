docker build -t iogbole/machine-agent-windows-64bit:20.5.1 . 
docker run -d --env-file env.list.local iogbole/machine-agent-windows-64bit:20.5.1
docker ps 
#docker push iogbole/machine-agent-windows-64bit:20.5.1

#docker cp ./start-agent-1.ps1 container_id:c:/appdynamics/start-agent-1.ps1
#docker exec -it container_id powershell 
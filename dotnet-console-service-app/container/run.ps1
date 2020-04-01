docker build -t iogbole/ioservicechecker:latest . 
docker run -d --env-file env.list.local iogbole/ioservicechecker:latest
docker ps 
#docker push iogbole/ioservicechecker:latest
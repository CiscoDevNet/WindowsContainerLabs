
docker build --pull -t iogbole/wcf-console-service:latest -f Dockerfile.console .

docker stop myservice
docker rm myservice

docker run -d --env-file env.list.local  --rm --name myservice iogbole/wcf-console-service:latest

docker ps 

#ocker push  iogbole/wcf-console-service:latest


docker build --pull -t iogbole/wcf-console-client:latest -f Dockerfile.client .

docker stop myservice
docker rm myservice

docker run -it --env-file env.list.local  --rm --name myservice iogbole/wcf-console-client:latest:latest

docker ps 
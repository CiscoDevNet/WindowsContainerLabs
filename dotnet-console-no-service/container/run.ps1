docker build -t iogbole/console_resouce_checker:latest . 
docker run -d --env-file env.list.local iogbole/console_resouce_checker:latest
docker ps 
#docker push iogbole/console_resouce_checker:latest
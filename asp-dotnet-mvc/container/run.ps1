docker build -t iogbole/aspdotnet:latest . 
docker run -d --env-file env.list.local iogbole/aspdotnet:latest
#--user "NT AUTHORITY\SYSTEM"
docker ps 
#docker push iogbole/aspdotnet:latest
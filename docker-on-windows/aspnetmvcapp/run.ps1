docker build -t iogbole/aspdotnet:latest . 
docker run -d --env-file env.list iogbole/aspdotnet:latest
#--user "NT AUTHORITY\SYSTEM"
docker ps 
#docker push iogbole/aspdotnet:latest
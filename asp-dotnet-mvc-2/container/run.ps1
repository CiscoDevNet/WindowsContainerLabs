docker build -t anoopc/aspnetapp:latest . 
docker run -d --env-file env.list.local iogbole/aspnetapp:latest
#--user "NT AUTHORITY\SYSTEM"
docker ps 
#docker push iogbole/aspdotnet:latest
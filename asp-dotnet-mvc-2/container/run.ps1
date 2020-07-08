docker build -t anoopc/aspnet_app:latest . 
docker run --name aspnet_app -d -it -p 8000:80 --env-file env.list.local anoopc/aspnet_app:latest
#--user "NT AUTHORITY\SYSTEM"
docker ps 
#docker push iogbole/aspdotnet:latest
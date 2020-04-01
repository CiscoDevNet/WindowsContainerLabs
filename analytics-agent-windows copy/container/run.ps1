docker build -t iogbole/appd_windows_analytics_agent:latest . #--no-cache
docker images
docker stop appd_windows_analytics_agent
docker rm appd_windows_analytics_agent
docker run --env-file env.list.local --name appd_windows_analytics_agent -d iogbole/appd_windows_analytics_agent:latest
start-sleep -s 3
docker ps --filter "name=appd_windows_analytics_agent" 
#docker push  iogbole/appd_windows_analytics_agent:latest
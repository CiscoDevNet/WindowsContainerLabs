[cmdletbinding()]
Param (

    [Parameter(Mandatory = $false)]
    [string]$dockerHubHandle
)

if ($dockerHubHandle -eq "") {
    $dockerHubHandle = "iogbole"
 }

$IMAGE_NAME = "$dockerHubHandle/springboot-javademo-app"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "

docker build --no-cache  -t ${IMAGE_NAME}:win . 

#docker run -d iogbole/springboot-javademo-app 

#docker push iogbole/windows_analytics_agent:$agentVersion
#docker image inspect --format='' iogbole/windows_analytics_agent
#docker exec -it container_id powershell 
#./build.ps1 -agentVersion 20.6.0 -dockerHubHandle iogbole    
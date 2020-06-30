[cmdletbinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string]$agentVersion,

    [Parameter(Mandatory = $false)]
    [string]$dockerHubHandle
)

if ($dockerHubHandle -eq "") {
    $dockerHubHandle = "appdynamics"
 }
#$IMAGE_NAME = "iogbole/machine-agent-windows-64bit"
$IMAGE_NAME = "$dockerHubHandle/machine-agent-windows-64bit"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "

docker build --no-cache --build-arg APPD_AGENT_VERSION=$agentVersion -t ${IMAGE_NAME}:$agentVersion . 

#docker run -d --env-file env.list.local ${IMAGE_NAME}:$agentVersion
#docker push iogbole/machine-agent-windows-64bit:$agentVersion
#docker image inspect --format='' iogbole/machine-agent-windows-64bit:20.5.1
#docker exec -it container_id powershell 
#./build.ps1 -agentVersion 20.6.0 -dockerHubHandle iogbole    
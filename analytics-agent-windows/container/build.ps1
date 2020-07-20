[cmdletbinding()]
Param (
    [Parameter(Mandatory = $true)]
    [string]$agentVersion,

    [Parameter(Mandatory = $false)]
    [string]$dockerHubHandle,

    [Parameter(Mandatory = $false)]
    [string]$winTag
)

if ($dockerHubHandle -eq "") {
    $dockerHubHandle = "appdynamics"
 }

if ($winTag -eq "") {
    $winTag = "win-nano"
 }

$IMAGE_NAME = "$dockerHubHandle/analytics-agent"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "
Write-Host "winTag = $winTag "

docker build --no-cache --build-arg APPD_AGENT_VERSION=$agentVersion -t ${IMAGE_NAME}:$agentVersion-$winTag . 
 

#docker run -d --env-file env.list.local ${IMAGE_NAME}:$agentVersion
#docker push iogbole/windows_analytics_agent:$agentVersion
#docker image inspect --format='' iogbole/windows_analytics_agent
#docker exec -it container_id powershell 
#./build.ps1 -agentVersion 20.6.0 -dockerHubHandle iogbole    
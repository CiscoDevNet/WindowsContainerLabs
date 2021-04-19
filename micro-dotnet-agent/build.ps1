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
$IMAGE_NAME = "$dockerHubHandle/micro-dotnet-agent"

#Downloading the nuget package from public repo
wget https://www.nuget.org/api/v2/package/AppDynamics.Agent.Distrib.Micro.Windows/$agentVersion -outfile "appdynamics.agent.distrib.micro.windows.$agentVersion.nupkg"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "

docker build --no-cache --build-arg APPD_AGENT_VERSION=$agentVersion -t ${IMAGE_NAME}:$agentVersion . 

#Remove nuget package
Remove-Item -Path .\*.nupkg -Force

#docker run -d --env-file env.list.local ${IMAGE_NAME}:$agentVersion
#docker push iogbole/windows_analytics_agent:$agentVersion
#docker image inspect --format='' iogbole/windows_analytics_agent
#docker exec -it container_id powershell 
#./build.ps1 -agentVersion 20.6.0 -dockerHubHandle iogbole    

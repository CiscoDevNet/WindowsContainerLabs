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
    $winTag = "win-core"
 }

$imageName = "$dockerHubHandle/db-agent"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "
Write-Host "winTag = $winTag "

# Build
docker build --no-cache --build-arg APPDYNAMICS_AGENT_VERSION=$agentVersion -t ${imageName}:$agentVersion-$winTag . 

# Run (with env)
#docker run -d --env-file env.list.local ${imageName}:$agentVersion-$winTag
# Push
#docker push ${imageName}:$agentVersion-$winTag

# docker image inspect --format='' alexappd/db-agent:20.5.1-win-nano
# docker exec -it container_id powershell 
# ./build.ps1 -agentVersion "20.7.0.1892" -dockerHubHandle alexappd    
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

$imageName = "$dockerHubHandle/db-agent"

Write-Host "version = $agentVersion "
Write-Host "dockerHubHandle = $dockerHubHandle "

# Build
docker build --no-cache --build-arg APPDYNAMICS_AGENT_VERSION=$agentVersion -t ${imageName}:$agentVersion . 

# Run (with env)
docker run -d --env-file env.list.local ${imageName}:$agentVersion
# Push
docker push ${imageName}:$agentVersion

# docker image inspect --format='' alexappd/db-agent:20.5.1
# docker exec -it container_id powershell 
# ./build.ps1 -agentVersion "20.7.0.1892" -dockerHubHandle alexappd    
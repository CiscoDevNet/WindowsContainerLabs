[CmdletBinding()]
param(
    
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_AGENT_NAME,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_ACCESS_KEY,
 
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_PROTOCOL,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_CONTROLLER_HOST,
    
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_CONTROLLER_PORT,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_EVENTS_API_URL,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_ACCOUNT_NAME,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_GLOBAL_ACCOUNT_NAME,

    [Parameter(Mandatory=$false)]
    [string]$APPDYNAMICS_PROXY_HOST,

    [Parameter(Mandatory=$false)]
    [string]$APPDYNAMICS_PROXY_PORT
)

$AGENT_HOME = "c:\\appdynamics\\analytics-agent-bundle-64bit-windows"
$SOURCE_FILE="c:\appdynamics\analytics-agent-bundle-64bit-windows\conf\analytics-agent.properties"

$destinationFile=$SOURCE_FILE

Copy-Item $SOURCE_FILE $SOURCE_FILE'.backup'

#$controller_url=$APPDYNAMICS_PROTOCOL + "://" + $APPDYNAMICS_CONTROLLER_HOST + ":" + $APPDYNAMICS_CONTROLLER_PORT
$controller_url = -join($APPDYNAMICS_PROTOCOL, "://", $APPDYNAMICS_CONTROLLER_HOST, ":", $APPDYNAMICS_CONTROLLER_PORT).Replace(' ', '')
$agent_name_new = -join($APPDYNAMICS_AGENT_NAME, "|", $env:computername).Replace(' ', '')

(Get-Content $SOURCE_FILE) | ForEach-Object {
    $_ -replace "ad.agent.name=analytics-agent1", "ad.agent.name=$agent_name_new" `
    -replace "http.event.accessKey=your-account-access-key", "http.event.accessKey=$APPDYNAMICS_ACCESS_KEY" `
    -replace "ad.controller.url=http://localhost:8090", "ad.controller.url=$controller_url" `
    -replace "http.event.endpoint=http://localhost:9080", "http.event.endpoint=$APPDYNAMICS_EVENTS_API_URL" `
    -replace "http.event.name=customer1", "http.event.name=$APPDYNAMICS_ACCOUNT_NAME" `
    -replace "http.event.accountName=analytics-customer1", "http.event.accountName=$APPDYNAMICS_GLOBAL_ACCOUNT_NAME" `
    -replace 'ad.dw.log.path=\$\{APPLICATION_HOME}/logs', "ad.dw.log.path=$AGENT_HOME\\logs" `
    -replace 'conf.dir=\$\{APPLICATION_HOME}/conf', "conf.dir=$AGENT_HOME\\conf"
 } | Set-Content $destinationFile

if ($APPDYNAMICS_PROXY_HOST -ne "" -and  $APPDYNAMICS_PROXY_PORT -ne ""){
    (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "http.event.proxyHost=", "http.event.proxyHost=$APPDYNAMICS_PROXY_HOST"
          -replace "http.event.proxyPort=", "http.event.proxyPort=$APPDYNAMICS_PROXY_PORT"
    } | Set-Content $destinationFile    
} 


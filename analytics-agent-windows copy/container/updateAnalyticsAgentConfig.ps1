[CmdletBinding()]
param(
    
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$AGENT_NAME,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ACCESS_KEY,
 
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$PROTOCOL,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$CONTROLLER_HOST,
    
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$CONTROLLER_PORT,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$EVENT_ENDPOINT,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$ACCOUNT_NAME,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$GLOBAL_ACCOUNT_NAME,

    [Parameter(Mandatory=$false)]
    [string]$PROXY_HOST,

    [Parameter(Mandatory=$false)]
    [string]$PROXY_PORT
)

$AGENT_HOME = "c:\\appdynamics\\analytics-agent-bundle-64bit-windows"
$SOURCE_FILE="c:\appdynamics\analytics-agent-bundle-64bit-windows\conf\analytics-agent.properties"

$destinationFile=$SOURCE_FILE

Copy-Item $SOURCE_FILE $SOURCE_FILE'.backup'

#$controller_url=$PROTOCOL + "://" + $CONTROLLER_HOST + ":" + $CONTROLLER_PORT
$controller_url = -join($PROTOCOL, "://", $CONTROLLER_HOST, ":", $CONTROLLER_PORT).Replace(' ', '')
$agent_name_new = -join($AGENT_NAME, "|", $env:computername).Replace(' ', '')

(Get-Content $SOURCE_FILE) | ForEach-Object {
    $_ -replace "ad.agent.name=analytics-agent1", "ad.agent.name=$agent_name_new" `
    -replace "http.event.accessKey=your-account-access-key", "http.event.accessKey=$ACCESS_KEY" `
    -replace "ad.controller.url=http://localhost:8090", "ad.controller.url=$controller_url" `
    -replace "http.event.endpoint=http://localhost:9080", "http.event.endpoint=$EVENT_ENDPOINT" `
    -replace "http.event.name=customer1", "http.event.name=$ACCOUNT_NAME" `
    -replace "http.event.accountName=analytics-customer1", "http.event.accountName=$GLOBAL_ACCOUNT_NAME" `
    -replace 'ad.dw.log.path=\$\{APPLICATION_HOME}/logs', "ad.dw.log.path=$AGENT_HOME\\logs" `
    -replace 'conf.dir=\$\{APPLICATION_HOME}/conf', "conf.dir=$AGENT_HOME\\conf"
 } | Set-Content $destinationFile

if ($PROXY_HOST -ne "" -and  $PROXY_PORT -ne ""){
    (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "http.event.proxyHost=", "http.event.proxyHost=$PROXY_HOST"
          -replace "http.event.proxyPort=", "http.event.proxyPort=$PROXY_PORT"
    } | Set-Content $destinationFile    
} 


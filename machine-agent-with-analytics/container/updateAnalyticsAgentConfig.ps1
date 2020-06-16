[CmdletBinding()]
param(
    
    [Parameter(Mandatory=$false)]
    [string]$APPDYNAMICS_ANALYTICS_AGENT_NAME,

    [Parameter(Mandatory=$false)]
    [ValidateSet("true", "false")]
    [string]$APPDYNAMICS_ENABLE_ANALYTICS,

    [Parameter(Mandatory=$false)]
    [string]$APPDYNAMICS_ANALYTICS_PORT,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_ACCESS_KEY,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$MACHINE_AGENT_HOME,
 
    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_CONTROLLER_PROTOCOL,

    [Parameter(Mandatory)]
    [ValidateNotNullOrEmpty()]
    [string]$APPDYNAMICS_CONTROLLER_HOST_NAME,
    
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
    [string]$APPDYNAMICS_PROXY_PORT,

    [Parameter(Mandatory=$false)]
    [string]$APPDYNAMICS_PROXY_USER_NAME,

    [Parameter(Mandatory=$false)]
    [string]$APPDYANMICS_PROXY_PASSWORD
)


$enable_analytics = "<enabled>(?:tru|fals)e.*>$"
$enable_analytics_regex = "<enabled>$APPDYNAMICS_ENABLE_ANALYTICS</enabled>"
$monitorXML = "$MACHINE_AGENT_HOME\monitors\analytics-agent\monitor.xml"

(Get-Content $monitorXML) | ForEach-Object { $_ -replace "$enable_analytics" , "$enable_analytics_regex" } | Set-Content $monitorXML


$SOURCE_FILE="$MACHINE_AGENT_HOME\monitors\analytics-agent\conf\analytics-agent.properties"

$destinationFile=$SOURCE_FILE

Copy-Item $SOURCE_FILE $SOURCE_FILE'.backup'

$controller_url = -join($APPDYNAMICS_CONTROLLER_PROTOCOL, "://", $APPDYNAMICS_CONTROLLER_HOST_NAME, ":", $APPDYNAMICS_CONTROLLER_PORT).Replace(' ', '')

if ([string]::IsNullOrEmpty($APPDYNAMICS_ANALYTICS_AGENT_NAME)){
   $APPDYNAMICS_ANALYTICS_AGENT_NAME = "analytics-agent"
}
$agent_name_new = -join($APPDYNAMICS_ANALYTICS_AGENT_NAME, "|", $env:computername).Replace(' ', '')

(Get-Content $SOURCE_FILE) | ForEach-Object {
    $_ -replace "ad.agent.name=analytics-agent1", "ad.agent.name=$agent_name_new" `
    -replace "http.event.accessKey=your-account-access-key", "http.event.accessKey=$APPDYNAMICS_ACCESS_KEY" `
    -replace "ad.controller.url=http://localhost:8090", "ad.controller.url=$controller_url" `
    -replace "http.event.endpoint=http://localhost:9080", "http.event.endpoint=$APPDYNAMICS_EVENTS_API_URL" `
    -replace "http.event.name=customer1", "http.event.name=$APPDYNAMICS_ACCOUNT_NAME" `
    -replace "http.event.accountName=analytics-customer1", "http.event.accountName=$APPDYNAMICS_GLOBAL_ACCOUNT_NAME" 
 } | Set-Content $destinationFile

if ($APPDYNAMICS_PROXY_HOST -ne "" -and  $APPDYNAMICS_PROXY_PORT -ne ""){
    (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "http.event.proxyHost=", "http.event.proxyHost=$APPDYNAMICS_PROXY_HOST"
          -replace "http.event.proxyPort=", "http.event.proxyPort=$APPDYNAMICS_PROXY_PORT"
    } | Set-Content $destinationFile    
} 

if (![string]::IsNullOrEmpty($APPDYNAMICS_ANALYTICS_PORT)){
    (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "ad.dw.http.port=9090", "ad.dw.http.port=$APPDYNAMICS_ANALYTICS_PORT"
    } | Set-Content $destinationFile    
} 

if (![string]::IsNullOrEmpty($APPDYNAMICS_PROXY_USER_NAME)){
   (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "http.event.proxyUsername=", "http.event.proxyUsername==$APPDYNAMICS_PROXY_USER_NAME"
    } | Set-Content $destinationFile
} 

if  (![string]::IsNullOrEmpty($APPDYANMICS_PROXY_PASSWORD)){
    (Get-Content $SOURCE_FILE) | ForEach-Object {
       $_ -replace "http.event.proxyPassword=", "http.event.proxyPassword=$APPDYANMICS_PROXY_PASSWORD"
    } | Set-Content $destinationFile
} 
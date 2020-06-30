

$MA_HOME = "c:\appdynamics\machineagent"

$APPDYNAMICS_ENABLE_ANALYTICS = ${env:APPDYNAMICS_ENABLE_ANALYTICS}

#handle null for analytics settings 
if ([string]::IsNullOrEmpty($APPDYNAMICS_ENABLE_ANALYTICS)) {
   $APPDYNAMICS_ENABLE_ANALYTICS = "false"
}

#Splatt the env variables 
$analytics_command_args = @{
   APPDYNAMICS_ANALYTICS_AGENT_NAME = "$env:APPDYNAMICS_ANALYTICS_AGENT_NAME"
   APPDYNAMICS_CONTROLLER_PROTOCOL  = "$env:APPDYNAMICS_CONTROLLER_PROTOCOL"
   APPDYNAMICS_CONTROLLER_HOST_NAME = "$env:APPDYNAMICS_CONTROLLER_HOST_NAME"
   APPDYNAMICS_CONTROLLER_PORT      = "$env:APPDYNAMICS_CONTROLLER_PORT"
   APPDYNAMICS_EVENTS_API_URL       = "$env:APPDYNAMICS_EVENTS_API_URL"
   APPDYNAMICS_ACCOUNT_NAME         = "$env:APPDYNAMICS_ACCOUNT_NAME"
   APPDYNAMICS_GLOBAL_ACCOUNT_NAME  = "$env:APPDYNAMICS_GLOBAL_ACCOUNT_NAME" 
   APPDYNAMICS_ACCESS_KEY           = "$env:APPDYNAMICS_ACCESS_KEY"
   APPDYNAMICS_ENABLE_ANALYTICS     = "$APPDYNAMICS_ENABLE_ANALYTICS"
   APPDYNAMICS_ANALYTICS_PORT       = "$env:APPDYNAMICS_ANALYTICS_PORT"
   APPDYNAMICS_PROXY_USER_NAME      = "$env:APPDYNAMICS_PROXY_USER_NAME"
   APPDYANMICS_PROXY_PASSWORD       = "$env:APPDYANMICS_PROXY_PASSWORD"
   APPDYNAMICS_PROXY_HOST           = "$env:APPDYNAMICS_PROXY_HOST"
   MACHINE_AGENT_HOME               = "$MA_HOME"
}

if ($APPDYNAMICS_ENABLE_ANALYTICS -eq "true") {
   Write-Host "Analytics is desired to be enabled, but requires account name and api url to be set"
   if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_GLOBAL_ACCOUNT_NAME}) -or ![string]::IsNullOrEmpty(${env:APPDYNAMICS_EVENTS_API_URL})) {
      $command = "c:\appdynamics\updateAnalyticsAgentConfig.ps1" 
      & $command @analytics_command_args
   }else{
      Write-Host "APPDYNAMICS_GLOBAL_ACCOUNT_NAME or APPDYNAMICS_EVENTS_API_URL is not set"
   }
}

Start-Sleep -s 2 #coz the disk io sucks 

# MA JV section begins here 

$MA_PROPERTIES += " -Dappdynamics.controller.hostName=${env:APPDYNAMICS_CONTROLLER_HOST_NAME}"
$MA_PROPERTIES += " -Dappdynamics.controller.port=${env:APPDYNAMICS_CONTROLLER_PORT}"
$MA_PROPERTIES += " -Dappdynamics.agent.accountName=${env:APPDYNAMICS_ACCOUNT_NAME}"
$MA_PROPERTIES += " -Dappdynamics.agent.accountAccessKey=${env:APPDYNAMICS_ACCESS_KEY}"
$MA_PROPERTIES += " -Dappdynamics.controller.ssl.enabled=${env:APPDYNAMICS_CONTROLLER_SSL_ENABLED}"

# SIM enabled defaults to true 
if ([string]::IsNullOrEmpty(${env:APPDYNAMICS_SIM_ENABLED})) {
   $MA_PROPERTIES += " -Dappdynamics.sim.enabled=true" 
}
else {
   $MA_PROPERTIES += " -Dappdynamics.sim.enabled=${env:APPDYNAMICS_SIM_ENABLED}" 
}

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_AGENT_UNIQUE_HOST_ID})) {
   $MA_PROPERTIES += " -Dappdynamics.agent.uniqueHostId=${env:APPDYNAMICS_AGENT_UNIQUE_HOST_ID}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_MACHINE_HIERARCHY_PATH})) {
   $MA_PROPERTIES += " -Dappdynamics.machine.agent.hierarchyPath=${env:APPDYNAMICS_MACHINE_HIERARCHY_PATH}"
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_DOTNET_COMPATIBILITY_MODE})) {
   $MA_PROPERTIES += " -Dappdynamics.machine.agent.dotnetCompatibilityMode=${env:APPDYNAMICS_DOTNET_COMPATIBILITY_MODE}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_PROXY_HOST})) {
   $MA_PROPERTIES += " -Dappdynamics.http.proxyHost=${env:APPDYNAMICS_PROXY_HOST}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_PROXY_HTTPS_HOST})) {
   $MA_PROPERTIES += " -Dappdynamics.https.proxyHost=${env:APPDYNAMICS_PROXY_HTTPS_HOST}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_PROXY_PORT})) {
   $MA_PROPERTIES += " -Dappdynamics.http.proxyPort=${env:APPDYNAMICS_PROXY_PORT}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_HTTPS_PROXY_PORT})) {
   $MA_PROPERTIES += " -Dappdynamics.https.proxyPort=${env:APPDYNAMICS_HTTPS_PROXY_PORT}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYNAMICS_PROXY_USER_NAME})) {
   $MA_PROPERTIES += " -Dappdynamics.http.proxyUser=${env:APPDYNAMICS_PROXY_USER_NAME}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYANMICS_PROXY_PASSWORD_FILE})) {
   $MA_PROPERTIES += " -Dappdynamics.http.proxyPasswordFile=${env:APPDYANMICS_PROXY_PASSWORD_FILE}" 
} 

if (![string]::IsNullOrEmpty(${env:APPDYANMICS_METRICS_MAX_LIMIT})) {
   $MA_PROPERTIES += " -Dappdynamics.agent.maxMetrics=${env:APPDYANMICS_METRICS_MAX_LIMIT}" 
} 

Write-Host  $MA_PROPERTIES

# Start Machine Agent
Start-Process $MA_HOME/jre/bin/java -ArgumentList "$MA_PROPERTIES -jar $MA_HOME/machineagent.jar" 

Start-Sleep -s 20
Get-Content -Path "$MA_HOME/logs/machine-agent.log" -Tail  10 -Wait
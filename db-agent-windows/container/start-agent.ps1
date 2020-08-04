
if ([string]::IsNullOrEmpty(${env:APPDYNAMICS_DB_AGENT_HOME})) {
   $DB_HOME = "c:\\appdynamics\\dbagent"
}else{
   $DB_HOME = "${env:APPDYNAMICS_DB_AGENT_HOME}"
}

if ([string]::IsNullOrEmpty(${env:APPDYNAMICS_AGENT_VERSION})) {
   $Agent_Version_Error = [string]"Agent version not found. Function aborting..."
   Write-Error $Agent_Version_Error
   return
} else {
   $AGENT_VERSION = "${env:APPDYNAMICS_AGENT_VERSION}"
}

Write-Host "APPDYNAMICS_DBAGENT_HOME"
Write-Host ${env:APPDYNAMICS_DB_AGENT_HOME}

#$Url = "https://download.appdynamics.com/download/prox/download-file/db-agent-winx64/$AGENT_VERSION/db-agent-64bit-windows-$AGENT_VERSION.zip"
$OutputFile = "$DB_HOME\db-agent-64bit-windows-$AGENT_VERSION.zip"

Write-Host "OutputFile:"
Write-Host ${OutputFile}

#Invoke-RestMethod -Method 'Get' -Uri $Url -OutFile "$OutputFile"

Expand-Archive -Path $OutputFile -DestinationPath "$DB_HOME"

#Remove-Item -Path $OutputFile -Force

# Start DB Agent as Windows Service
cscript "$DB_HOME\InstallService.vbs" "-""Dappdynamics.controller.hostName""=${env:APPDYNAMICS_CONTROLLER_HOST_NAME} 
-""Dappdynamics.controller.port""=""${env:APPDYNAMICS_CONTROLLER_PORT}"" 
-""Dappdynamics.agent.accountName""=""${env:APPDYNAMICS_AGENT_ACCOUNT_NAME}""
-""Dappdynamics.agent.accountAccessKey""=${env:APPDYNAMICS_AGENT_ACCOUNT_ACCESS_KEY}
-""Dappdynamics.controller.ssl.enabled""=${env:APPDYNAMICS_CONTROLLER_SSL_ENABLED}"

# cscript "C:\appdynamics\dbagent\InstallService.vbs" '%$DB_PROPERTIES%'
# Get-Content -Path "C:\appdynamics\dbagent\logs\agent.log" -Tail 50 -Wait
# cscript "C:\appdynamics\dbagent\UninstallService.vbs"

# this let you do 'k logs'
Start-Sleep -s 20

Write-Host "Service:"
Get-Service "Appdynamics*"

Write-Host "Logs:"
Get-Content -Path "$DB_HOME\logs\agent.log" -Tail 10 -Wait


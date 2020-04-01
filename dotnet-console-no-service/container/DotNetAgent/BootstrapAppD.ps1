# AppD Bootstrapper peformances the following functions in sequence: 
# 1. Update the config.xml file with the controller's account name and access key using values from K8s secrets and/or envs
# 2. Copy APPDYNAMICS process-level environment variables to machine-level environments. The .Net agent can only read machine-level environment variables. 
# 3. Restart AppDynamics Cordinator Service 

######################################################
##         step 1. update config.xml file           ##
######################################################

$regex = "(.*account name=)(.*password=.*)\/>$"
$account = "      <account name=""${env:APPDYNAMICS.AGENT.ACCOUNTNAME}"" password=""${env:APPDYNAMICS.AGENT.ACCOUNTACCESSKEY}"" />"

$InstalledAgentConfig = "C:\ProgramData\AppDynamics\DotNetAgent\Config\config.xml"
$configFile = "C:\AppDynamics\DotNetAgent\config.xml"

if (Test-Path $InstalledAgentConfig) {
 # The Agent has been installed, so update the config file with K8s env variables. 
 # This is done AtStart up of the container
   $configFile = $InstalledAgentConfig
}

#take a backup 
Copy-Item $configFile $configFile-backup
#update the config.xml with new controller creds
(Get-Content $configFile) | ForEach-Object { $_ -replace "$regex" , "$account" } | Set-Content $configFile

########################################################
##   Step 2. Copy Process Envs to Machine Envs         ##
########################################################

# copy AppD process-level environment variables (from k8s env spec) to machine level. The DotNet Agent can only Machine level variables
foreach($key in [System.Environment]::GetEnvironmentVariables('Process').Keys | select-string -Pattern "APPDYNAMICS"  -CaseSensitive ) {
    # This is to prevent APPDYNAMICS.AGENT.ACCOUNTNAME and APPDYNAMICS.AGENT.ACCOUNTACCESSKEY from being visibile in the controller
    if (($key -notlike "APPDYNAMICS.AGENT.ACCOUNTACCESSKEY")) {
        $value = [System.Environment]::GetEnvironmentVariable($key, 'Process')
        [System.Environment]::SetEnvironmentVariable($key, $value, 'Machine')
        #$value >> debug.text

    }
}

########################################################
##       Step 3. Restart AppDynamics Agent            ##
########################################################

#Restart-Service -DisplayName "AppDynamics.Agent.Coordinator"

Restart-Service AppDynamics.Agent.Coordinator_service -Force 

sleep -s 5


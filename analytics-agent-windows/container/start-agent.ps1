#Splatt the env variables 
#ping localhost -t
$command_args = @{
    APPDYNAMICS_AGENT_NAME = "$env:APPDYNAMICS_AGENT_NAME"
    APPDYNAMICS_PROTOCOL = "$env:APPDYNAMICS_PROTOCOL"
    APPDYNAMICS_CONTROLLER_HOST = "$env:APPDYNAMICS_CONTROLLER_HOST"
    APPDYNAMICS_CONTROLLER_PORT = "$env:APPDYNAMICS_CONTROLLER_PORT"
    APPDYNAMICS_EVENTS_API_URL = "$env:APPDYNAMICS_EVENTS_API_URL"
    APPDYNAMICS_ACCOUNT_NAME = "$env:APPDYNAMICS_ACCOUNT_NAME"
    APPDYNAMICS_GLOBAL_ACCOUNT_NAME = "$env:APPDYNAMICS_GLOBAL_ACCOUNT_NAME" 
    APPDYNAMICS_ACCESS_KEY = "$env:APPDYNAMICS_ACCESS_KEY"
}
$command = "c:\appdynamics\updateAnalyticsAgentConfig.ps1" 
& $command @command_args
start-sleep -s 2 #coz the disk io sucks 
$analytics_path = "c:/appdynamics/analytics-agent-bundle-64bit-windows"
Start-Process $analytics_path/jre/bin/java -ArgumentList "-jar $analytics_path/bin/tool/tool-executor.jar start" 

# Make logs available in docker  logs when it's started up, takes about 10 -15 seconds
start-sleep -s 20 
Get-Content -path "$analytics_path/logs/analytics-agent.log" -Tail  10 -Wait

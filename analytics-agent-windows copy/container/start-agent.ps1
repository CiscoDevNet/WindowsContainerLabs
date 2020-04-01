#Splatt the env variables 
#ping localhost -t
$command_args = @{
    AGENT_NAME = "$env:AGENT_NAME"
    PROTOCOL = "$env:PROTOCOL"
    CONTROLLER_HOST = "$env:CONTROLLER_HOST"
    CONTROLLER_PORT = "$env:CONTROLLER_PORT"
    EVENT_ENDPOINT = "$env:EVENT_ENDPOINT"
    ACCOUNT_NAME = "$env:ACCOUNT_NAME"
    GLOBAL_ACCOUNT_NAME = "$env:GLOBAL_ACCOUNT_NAME" 
    ACCESS_KEY = "$env:ACCESS_KEY"
}
$command = "c:\appdynamics\updateAnalyticsAgentConfig.ps1" 
& $command @command_args
start-sleep -s 2 #coz the disk io sucks 
$analytics_path = "c:/appdynamics/analytics-agent-bundle-64bit-windows"
Start-Process $analytics_path/jre/bin/java -ArgumentList "-jar $analytics_path/bin/tool/tool-executor.jar start" 

# Make logs available in docker  logs when it's started up, takes about 10 -15 seconds
start-sleep -s 20 
Get-Content -path "$analytics_path/logs/analytics-agent.log" -Tail  10 -Wait

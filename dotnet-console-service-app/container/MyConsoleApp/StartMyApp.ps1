
# Call AppD Bootstrapper before your appplication starts up

& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

# This will typically be the customer's custom point command. Parse in $args if the service started with any args from k8s manifests

Restart-Service IOServiceCheckerApp

while (1) {
    Get-Content C:/MyConsoleApp/Logs/ServiceLog* -tail 10 
    Start-Sleep -Seconds 10
    Clear 
}
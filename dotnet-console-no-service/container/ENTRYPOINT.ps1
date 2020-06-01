
# Call AppD Bootstrapper before your appplication starts up
& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

# Any args from K8s deployment can be read using the format below

# This will typically be the customer's custom entry point command. with the Args from K8s deployment - if any 
# Start-Process C:\resource-check\DockerOnWindows.ResourceCheck.Console.exe -ArgumentList "$args"

#Because we've changed the entrypoint, kubectl logs command will no work as intended, fix it by tailing the logs 
#start-sleep -s 20
#Get-Content C:\resource-check\log.out -tail 10 

#### This section is specific to this demo app, do not use in a customer environment. 
while(1){
  $timenow = get-date -Format u
  $dcmd = C:\resource-check\DockerOnWindows.ResourceCheck.Console.exe
  "$timenow $dcmd"  >> c:\resource-check\log.out
  Get-Content C:\resource-check\log.out -tail 10 
  Start-Sleep -Seconds 15
    Clear 
 }
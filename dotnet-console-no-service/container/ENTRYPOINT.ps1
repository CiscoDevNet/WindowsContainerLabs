
# Call AppD Bootstrapper before your appplication starts up
& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

# This will typically be the customer's custom point command.

while(1){
  $timenow = get-date -Format u
  $dcmd = C:\resource-check\DockerOnWindows.ResourceCheck.Console.exe
  "$timenow $dcmd"  >> c:\resource-check\log.out
  Get-Content C:\resource-check\log.out -tail 10 
  Start-Sleep -Seconds 15
    Clear 
 }
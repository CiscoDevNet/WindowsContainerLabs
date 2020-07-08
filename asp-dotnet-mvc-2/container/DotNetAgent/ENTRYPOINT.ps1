

& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

## Reset IIS ##
iisreset

## Generate Load ##
& "C:\AppDynamics\DotNetAgent\GenerateLoad.ps1"

## Collect K8s args
${env:ENTRYPOINTARGS} > out.txt

& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

# Any args and env pass from docker env or from K8s spec can be read using the format below
#$ARG1 = ${env:ARGSNAME} 

# This was the original entry point command
# ENTRYPOINT WcfServiceConsoleApp.exe

& "c:\app\WcfClient.exe"
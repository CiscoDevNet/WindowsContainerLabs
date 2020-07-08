
[cmdletbinding()]
Param (
    [Parameter(Mandatory = $false)]
    [string]$applicationPoolName,

    [Parameter(Mandatory = $false)]
    [string]$agentFolderLocation
)

if ($applicationPoolName -eq ""){
    $applicationPoolName = "DefaultAppPool"
}

if ($agentFolderLocation -eq ""){
    $agentFolderLocation = "C:/AppDynamics/"
}
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='$applicationPoolName'].environmentVariables.[name='COR_ENABLE_PROFILING',value='1']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='$applicationPoolName'].environmentVariables.[name='COR_PROFILER',value='{39AEABC1-56A5-405F-B8E7-C3668490DB4A}']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='$applicationPoolName'].environmentVariables.[name='COR_PROFILER_PATH_32',value='$agentFolderLocation/AppDynamics.Profiler_x86.dll']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='$applicationPoolName'].environmentVariables.[name='COR_PROFILER_PATH_64',value='$agentFolderLocation/AppDynamics.Profiler_x64.dll']" /commit:apphost

iisreset

C:\ServiceMonitor.exe w3svc
# Any args from K8s spec can be read using the format below
${env:ARGSNAME} 
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='DefaultAppPool'].environmentVariables.[name='COR_ENABLE_PROFILING',value='1']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='DefaultAppPool'].environmentVariables.[name='COR_PROFILER',value='{39AEABC1-56A5-405F-B8E7-C3668490DB4A}']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='DefaultAppPool'].environmentVariables.[name='COR_PROFILER_PATH_32',value='C:/AppDynamics/AppDynamics.Profiler_x86.dll']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='DefaultAppPool'].environmentVariables.[name='COR_PROFILER_PATH_64',value='C:/AppDynamics/AppDynamics.Profiler_x64.dll']" /commit:apphost

# Any args from K8s spec can be read using the format below
${env:ARGSNAME} 
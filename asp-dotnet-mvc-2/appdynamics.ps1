C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='COR_ENABLE_PROFILING',value='1']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='COR_PROFILER',value='{39AEABC1-56A5-405F-B8E7-C3668490DB4A}']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='COR_PROFILER_PATH_32',value='C:\appdynamics\dotnet-agent\AppDynamics.Profiler_x86.dll']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='COR_PROFILER_PATH_64',value='C:\appdynamics\dotnet-agent\AppDynamics.Profiler_x64.dll']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.AGENT.ACCOUNTACCESSKEY',value='KEY']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.AGENT.ACCOUNTNAME',value='ACCOUNTNAME']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.AGENT.APPLICATIONNAME',value='K8-HS-DEV']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.CONTROLLER.HOSTNAME',value='saas.appdynamics.com']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.CONTROLLER.PORT',value='443']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS.CONTROLLER.SSL.ENABLED',value='true']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS_AGENT_NODE_NAME',value='Node1']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS_AGENT_REUSE_NODE_NAME',value='true']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS_AGENT_REUSE_NODE_NAME_PREFIX',value='node']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS_AGENT_TIER_NAME',value='K8-FRONTEND-SALES']" /commit:apphost
C:\Windows\system32\inetsrv\appcmd.exe set config -section:system.applicationHost/applicationPools /+"[name='APPPOOL_GOES_HERE'].environmentVariables.[name='APPDYNAMICS_AGENT_UNIQUE_HOST_ID',value='UNIQUE_HOST_ID']" /commit:apphost


### This goes into Docker ######

#COPY appdynamics.ps1 appdynamics.ps1
#RUN .\appdynamics.ps1

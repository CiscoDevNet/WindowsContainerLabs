
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

#https://docs.appdynamics.com/display/PRO44/Standalone+Machine+Agent+Configuration+Property+Reference
ENV APPDYNAMICS_ANALYTICS_AGENT_NAME=environment|component|application \
    APPDYNAMICS_ENABLE_ANALYTICS=true\
    APPDYNAMICS_ANALYTICS_PORT=9090 \
    APPDYNAMICS_EVENTS_API_URL=https://fra-ana-api.saas.appdynamics.com:443 \
    APPDYNAMICS_ACCOUNT_NAME=customer1\
    APPDYNAMICS_GLOBAL_ACCOUNT_NAME=customer1_guid \
    APPDYNAMICS_ACCESS_KEY=access_key \
    APPDYNAMICS_CONTROLLER_PROTOCOL=https \ 
    APPDYNAMICS_CONTROLLER_HOST_NAME=customer1.saas.appdynamics.com \
    APPDYNAMICS_CONTROLLER_PORT=443 \ 
    APPDYNAMICS_CONTROLLER_SSL_ENABLED=true \
    APPDYNAMICS_SIM_ENABLED=true \
    APPDYNAMICS_MACHINE_HIERARCHY_PATH=AWS|PROD|EU-WEST2|WorkerNodes \
    MACHINE_AGENT_HOME=c:\appdynamics\machineagent
    
RUN mkdir  "c:\appdynamics\machineagent"

COPY updateAnalyticsAgentConfig.ps1 c:/appdynamics/updateAnalyticsAgentConfig.ps1

COPY start-agent.ps1 c:/appdynamics/start-agent.ps1

COPY machineagent-bundle-64bit-windows*.zip  c:/appdynamics

RUN "ls c:/appdynamics"

RUN "Expand-Archive -Path 'c:/appdynamics/machineagent-bundle-64bit-windows*.zip' -DestinationPath c:/appdynamics/machineagent"

WORKDIR "c:\appdynamics\machineagent"

RUN "ls c:\appdynamics\machineagent"

ENTRYPOINT ["powershell","c:/appdynamics/start-agent.ps1"]

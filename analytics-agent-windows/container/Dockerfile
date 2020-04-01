
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

ENV APPDYNAMICS_AGENT_NAME=environment|component|application \
    APPDYNAMICS_PROTOCOL=https \ 
    APPDYNAMICS_CONTROLLER_HOST=customer1.saas.appdynamics.com \
    APPDYNAMICS_CONTROLLER_PORT=443 \ 
    APPDYNAMICS_EVENTS_API_URL=https://fra-ana-api.saas.appdynamics.com:443 \
    APPDYNAMICS_ACCOUNT_NAME=customer1\
    APPDYNAMICS_GLOBAL_ACCOUNT_NAME=customer1_guid \
    APPDYNAMICS_ACCESS_KEY=access_key \
    JAVA_HOME=c:/appdynamics/analytics-agent-bundle-64bit-windows/jre

#APPDYNAMICS_PROXY_HOST
#APPDYNAMICS_PROXY_PORT

RUN mkdir c:/appdynamics

COPY updateAnalyticsAgentConfig.ps1 c:/appdynamics/updateAnalyticsAgentConfig.ps1

COPY start-agent.ps1 c:/appdynamics/start-agent.ps1

COPY analytics-agent-bundle-64bit-windows/  c:/appdynamics/analytics-agent-bundle-64bit-windows

WORKDIR ${JAVA_HOME}

ENTRYPOINT ["powershell","c:/appdynamics/start-agent.ps1"]

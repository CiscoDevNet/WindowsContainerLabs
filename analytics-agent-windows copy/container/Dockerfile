
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

ENV AGENT_NAME=environment|component|application \
    PROTOCOL=https \ 
    CONTROLLER_HOST=customer1.saas.appdynamics.com \
    CONTROLLER_PORT=443 \ 
    EVENT_ENDPOINT=https://fra-ana-api.saas.appdynamics.com:443 \
    ACCOUNT_NAME=customer1\
    GLOBAL_ACCOUNT_NAME=customer1_guid \
    ACCESS_KEY=access_key \
    JAVA_HOME=c:/appdynamics/analytics-agent-bundle-64bit-windows/jre

#PROXY_HOST
#PROXY_PORT

RUN mkdir c:/appdynamics

COPY updateAnalyticsAgentConfig.ps1 c:/appdynamics/updateAnalyticsAgentConfig.ps1

COPY start-agent.ps1 c:/appdynamics/start-agent.ps1

COPY analytics-agent-bundle-64bit-windows/  c:/appdynamics/analytics-agent-bundle-64bit-windows

WORKDIR ${JAVA_HOME}

ENTRYPOINT ["powershell","c:/appdynamics/start-agent.ps1"]

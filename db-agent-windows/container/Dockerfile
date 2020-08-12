
FROM mcr.microsoft.com/windows/servercore:ltsc2019

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]
ARG APPDYNAMICS_AGENT_VERSION 

LABEL name="AppDynamics Windows DB Agent" \
      vendor="AppDynamics" \
      version="${APPDYNAMICS_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics monitoring solution for Databases" \
      description="AppDynamics monitoring solution for Databases"

# make a directory
ENV APPDYNAMICS_DB_AGENT_HOME=c:\\appdynamics\\dbagent
ENV APPDYNAMICS_AGENT_VERSION=$APPDYNAMICS_AGENT_VERSION
    
RUN mkdir "${env:APPDYNAMICS_DB_AGENT_HOME}"

# Copy start agent script
COPY start-agent.ps1 c:/appdynamics/start-agent.ps1

COPY db-agent-64bit-windows-${APPD_AGENT_VERSION}*.zip $APPDYNAMICS_DB_AGENT_HOME


RUN "ls c:\appdynamics"
RUN "ls c:\appdynamics\dbagent"

#clean up without prompt
RUN "Remove-Item -Path ${APPDYNAMICS_DB_AGENT_HOME}/db-agent-64bit-windows-${APPDYNAMICS_AGENT_VERSION}*.zip -Force"

WORKDIR "${APPDYNAMICS_DB_AGENT_HOME}"

RUN "Write-Host ${env:APPDYNAMICS_AGENT_VERSION}"

RUN "ls ${env:APPDYNAMICS_DB_AGENT_HOME}"

ENTRYPOINT ["powershell","c:\\appdynamics\\start-agent.ps1"]

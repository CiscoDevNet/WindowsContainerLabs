
FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

ARG APPD_AGENT_VERSION 

LABEL name="AppDynamics Java Agent on Windows Container" \
      vendor="AppDynamics" \
      version="${APPD_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics Java Agent on Windows Container " \
      description="AppDynamics Java Agent on Windows Container"

RUN mkdir c:/appdynamics

COPY AppServerAgent-${APPD_AGENT_VERSION}*.zip  c:/appdynamics


RUN  "Expand-Archive -Path c:/appdynamics/AppServerAgent-${APPD_AGENT_VERSION}*.zip -DestinationPath c:/appdynamics/java-agent"; \
     "ls c:/appdynamics/java-agent"; \ 
     "start-sleep 2 && Remove-Item -Path c:/appdynamics/AppServerAgent-${APPD_AGENT_VERSION}*.zip -Recurse "

CMD [ "write-host", "Delivering the Java Agent on Windows Container. Copy the contents of c:/appdynamics/java-agent to the application container" ]


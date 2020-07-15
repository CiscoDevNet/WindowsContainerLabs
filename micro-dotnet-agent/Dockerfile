
FROM mcr.microsoft.com/powershell:lts-nanoserver-1809

SHELL ["pwsh", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

ARG APPD_AGENT_VERSION 

LABEL name="AppDynamics Full .Net Framework Agent " \
      vendor="AppDynamics" \
      version="${APPD_AGENT_VERSION}" \
      release="1" \
      url="https://www.appdynamics.com" \
      summary="AppDynamics Full .Net Framework Agent " \
      description="ApDynamics Full .Net Framework Agent"

RUN mkdir c:/appdynamics

COPY appdynamics.agent.distrib.micro.windows.${APPD_AGENT_VERSION}*.nupkg  c:/appdynamics

# i) Rename the nupkg file to .zip so it can be extractible. 
# ii) extract the zip file into /bin folder 
# iii) copy the content of /bin/tools/* to the dotnet-agent folder. These are the main dlls files that we need 
# iv)  delete the entire content of /bin  folder 

RUN "Rename-Item c:/appdynamics/appdynamics.agent.distrib.micro.windows.${APPD_AGENT_VERSION}*.nupkg c:/appdynamics/dotnet-agent.zip"; \
     "Expand-Archive -Path c:/appdynamics/dotnet-agent.zip -DestinationPath c:/appdynamics/dotnet-agent/bin"; \
     "ls c:/appdynamics/dotnet-agent/bin"; \ 
     "Copy-Item -Path c:/appdynamics/dotnet-agent/bin/tools/* -Destination c:/appdynamics/dotnet-agent -Recurse"; \
     "Remove-Item -Path c:/appdynamics/dotnet-agent/bin -Recurse -Force"; \
     "ls c:/appdynamics/dotnet-agent"
   
#clean up without prompt
RUN "Remove-Item -Path c:/appdynamics/*.nupkg -Force"; \
    " start-sleep 2 && Remove-Item -Path c:/appdynamics/dotnet-agent.zip  –Recurse"

CMD [ "write-host", "Delivering the .Net Agent. Copy the contents of c:/appdynamics/dotnet-agent to the application container" ]


FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY *.sln .
COPY aspnetmvcapp/*.csproj ./aspnetmvcapp/
COPY aspnetmvcapp/*.config ./aspnetmvcapp/
RUN nuget restore

# copy everything else and build app
COPY aspnetmvcapp/. ./aspnetmvcapp/
WORKDIR /app/aspnetmvcapp
RUN msbuild /p:Configuration=Release

FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8 AS runtime
WORKDIR /inetpub/wwwroot
COPY --from=build /app/aspnetmvcapp/. ./

COPY ENTRYPOINT.ps1 C:/ENTRYPOINT.ps1 

############################ BEGIN AppDynamics Section ############################
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted

ENV APPDYNAMICS_AGENT_APPLICATION_NAME=test-application \
    APPDYNAMICS.AGENT.ACCOUNTNAME=customer1 \
    APPDYNAMICS.AGENT.ACCOUNTACCESSKEY=password \
    APPDYNAMICS.CONTROLLER.HOSTNAME=customer1.saas.appdynamics.com \
    APPDYNAMICS.CONTROLLER.PORT=443 \
    APPDYNAMICS.CONTROLLER.SSL.ENABLED=true \
    APPDHOME="C:/ProgramData/AppDynamics/DotNetAgent"

RUN mkdir "C:/AppDynamics"
COPY DotNetAgent/  "C:/AppDynamics/DotNetAgent/"

WORKDIR C:/AppDynamics/DotNetAgent

RUN "Get-ChildItem -File -Path dotNetAgentSetup64*.msi | Rename-Item -NewName dotNetAgentSetup64.msi";\
    Start-Process 'msiexec' -Wait -ArgumentList  '/i dotNetAgentSetup64.msi /q /norestart /lv AgentInstaller.log AD_SetupFile=C:/AppDynamics/DotNetAgent/config.xml'; \
    Start-Sleep -s 30
    
# This steps below are super important for the .Net Agent to run successfully, including the sleep command.  
RUN Remove-Item dotNetAgentSetup64.msi ; \
    Start-Sleep -s 10; \
    Stop-Service AppDynamics.Agent.Coordinator_service -Force; \
    Set-Service -Name AppDynamics.Agent.Coordinator_service -StartupType Manual; \
    Get-Service AppDynamics.Agent.Coordinator_service | Select-Object -Property Name, StartType, Status
     
############################ END AppDynamics Section ############################

EXPOSE 80 8081

ENTRYPOINT ["powershell", "./ENTRYPOINT.ps1"]
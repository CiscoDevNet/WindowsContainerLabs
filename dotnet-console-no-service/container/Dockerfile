# escape=`

FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS builder

WORKDIR C:\src
COPY src\DockerOnWindows.ResourceCheck.sln .
COPY src\DockerOnWindows.ResourceCheck.Console\DockerOnWindows.ResourceCheck.Console.csproj .\DockerOnWindows.ResourceCheck.Console\
COPY src\DockerOnWindows.ResourceCheck.Console\packages.config .\DockerOnWindows.ResourceCheck.Console\
RUN nuget restore DockerOnWindows.ResourceCheck.sln

COPY src C:\src
RUN msbuild .\DockerOnWindows.ResourceCheck.Console\DockerOnWindows.ResourceCheck.Console.csproj `
            /p:OutputPath=c:\out\resource-check /p:Configuration=Release

# app image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

WORKDIR /resource-check
COPY --from=builder C:\out\resource-check .

############################ BEGIN AppDynamics Section ############################

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

#RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted

ENV APPDYNAMICS_AGENT_APPLICATION_NAME=test-application `
    APPDYNAMICS.AGENT.ACCOUNTNAME=customer1 `
    APPDYNAMICS.AGENT.ACCOUNTACCESSKEY=password `
    APPDYNAMICS.CONTROLLER.HOSTNAME=customer1.saas.appdynamics.com `
    APPDYNAMICS.CONTROLLER.PORT=443 `
    APPDYNAMICS.CONTROLLER.SSL.ENABLED=true

ENV APPDHOME="C:/ProgramData/AppDynamics/DotNetAgent"

RUN mkdir "C:/AppDynamics"
COPY DotNetAgent/  "C:/AppDynamics/DotNetAgent/"

WORKDIR C:/AppDynamics/DotNetAgent

RUN "Get-ChildItem -File -Path dotNetAgentSetup64*.msi | Rename-Item -NewName dotNetAgentSetup64.msi";`
    Start-Process 'msiexec' -Wait -ArgumentList  '/i dotNetAgentSetup64.msi /q /norestart /lv AgentInstaller.log AD_SetupFile=C:/AppDynamics/DotNetAgent/config.xml'; `
    Start-Sleep -s 20
# RUN powershell Get-Service AppDynamics.Agent.Coordinator_service
# This steps below are super important for the .Net Agent to run successfully, including the sleep command.  
# The purpise of the remov-item command is to make the image smaller. 
RUN Remove-Item dotNetAgentSetup64.msi ; `
    Start-Sleep -s 10; `
    Stop-Service AppDynamics.Agent.Coordinator_service -Force; `
    Set-Service -Name AppDynamics.Agent.Coordinator_service -StartupType Manual; `
    Get-Service AppDynamics.Agent.Coordinator_service | Select-Object -Property Name, StartType, Status
     
############################ END AppDynamics Section ############################

COPY ENTRYPOINT.ps1 c:/ENTRYPOINT.ps1

ENTRYPOINT ["powershell", "c:/ENTRYPOINT.ps1"]
FROM mcr.microsoft.com/windows/servercore:ltsc2019

#Install My test standalone .Net App
RUN mkdir "C:/MyConsoleApp"
COPY MyConsoleApp/  "C:/MyConsoleApp/"
    
############################ BEGIN AppDynamics Section ############################

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted

ENV APPDYNAMICS_AGENT_APPLICATION_NAME=test-application \
    APPDYNAMICS.AGENT.ACCOUNTNAME=customer1 \
    APPDYNAMICS.AGENT.ACCOUNTACCESSKEY=password \
    APPDYNAMICS.CONTROLLER.HOSTNAME=customer1.saas.appdynamics.com \
    APPDYNAMICS.CONTROLLER.PORT=443 \
    APPDYNAMICS.CONTROLLER.SSL.ENABLED=true

ENV APPDHOME="C:/ProgramData/AppDynamics/DotNetAgent"

RUN mkdir "C:/AppDynamics"
COPY DotNetAgent/  "C:/AppDynamics/DotNetAgent/"

WORKDIR C:/AppDynamics/DotNetAgent

RUN "Get-ChildItem -File -Path dotNetAgentSetup64*.msi | Rename-Item -NewName dotNetAgentSetup64.msi";\
    Start-Process 'msiexec' -Wait -ArgumentList  '/i dotNetAgentSetup64.msi /q /norestart /lv AgentInstaller.log AD_SetupFile=C:/AppDynamics/DotNetAgent/config.xml'; \
    Start-Sleep -s 20
    
# This steps below are super important for the .Net Agent to run successfully, including the sleep command.  
# The purpise of the remov-item command is to make the image smaller. 
RUN Remove-Item dotNetAgentSetup64.msi ; \
    Start-Sleep -s 10; \
    Stop-Service AppDynamics.Agent.Coordinator_service -Force; \
    Set-Service -Name AppDynamics.Agent.Coordinator_service -StartupType Manual; \
    Get-Service AppDynamics.Agent.Coordinator_service | Select-Object -Property Name, StartType, Status
     
############################ END AppDynamics Section ############################

RUN  New-Service -Name "IOServiceCheckerApp" -StartupType Manual -BinaryPathName C:/MyConsoleApp/IOServiceCheckerApp.exe; \
     Start-Sleep -s 10; \
     # Services that are set to auto-start are unable to be restarted by the container entry point command, 
     # It's a Windows container thing and I still don't know why (yet). 
     # The commands below set the service start up type to manual, so it can be restarted by the entry point command after AppD agent is up
     Get-Service IOServiceCheckerApp | Select-Object -Property Name, StartType, Status

ENTRYPOINT ["powershell", "C:/MyConsoleApp/StartMyApp.ps1"]



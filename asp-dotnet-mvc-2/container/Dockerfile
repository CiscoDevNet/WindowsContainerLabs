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

ENV APPDYNAMICS_AGENT_DLL_FOLDER_LOCATION = "C:/AppDynamics"

ENV APPDYNAMICS_AGENT_APPLICATION_NAME=aspnet_app\
    APPDYNAMICS_AGENT_TIER_NAME=aspnet_tier \
    APPDYNAMICS_AGENT_NODE_NAME=node1\     
    APPDYNAMICS.AGENT.ACCOUNTNAME=customer1 \
    APPDYNAMICS.AGENT.ACCOUNTACCESSKEY=5daa2655-9b30-4e8c-a24d-0ffa2b1e97e7 \
    APPDYNAMICS.CONTROLLER.HOSTNAME=training-2033nosshcont-6mihp1mk.appd-cx.com \
    APPDYNAMICS.CONTROLLER.PORT=8090 \
    APPDYNAMICS.CONTROLLER.SSL.ENABLED=false 


RUN mkdir $APPDYNAMICS_AGENT_DLL_FOLDER_LOCATION 
COPY /AppDynamics/. "$APPDYNAMICS_AGENT_DLL_FOLDER_LOCATION/
     
############################ END AppDynamics Section ############################

EXPOSE 80 8081

ENTRYPOINT ["powershell", "C:/ENTRYPOINT.ps1"]
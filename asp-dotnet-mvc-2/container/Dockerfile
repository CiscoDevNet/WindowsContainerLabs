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
COPY  /appdynamics.agent.distrib.micro.windows.20.6.0/tools/aspnetapp.AppDynamicsConfig.json /inetpub/wwwroot/obj/Release/
COPY  /appdynamics.agent.distrib.micro.windows.20.6.0/tools/aspnetapp.AppDynamicsConfig.json /inetpub/wwwroot/bin/
COPY  /appdynamics.agent.distrib.micro.windows.20.6.0/tools/aspnetapp.AppDynamicsConfig.json /inetpub/wwwroot/

COPY ENTRYPOINT.ps1 C:/ENTRYPOINT.ps1 
COPY GenerateLoad.ps1 C:/GenerateLoad.ps1 


############################ BEGIN AppDynamics Section ############################
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; $verbosePreference='Continue';"]

RUN Set-ExecutionPolicy -ExecutionPolicy Unrestricted

 
RUN mkdir "C:/AppDynamics"
COPY /AppDynamics/. "C:/AppDynamics/"
     
############################ END AppDynamics Section ############################

EXPOSE 80 8081

ENTRYPOINT ["powershell", "C:/ENTRYPOINT.ps1"]
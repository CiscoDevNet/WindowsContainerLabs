#Dockerfile for mark node as historical 

FROM mcr.microsoft.com/powershell

# Install required packages
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get clean

# Copy the content of the entire parent folder into SCRIPT_HOME
COPY loader.ps1 /opt/loader.ps1

# Set workdir
WORKDIR /opt

# Run command
CMD ls -ltr & pwsh ./loader.ps1

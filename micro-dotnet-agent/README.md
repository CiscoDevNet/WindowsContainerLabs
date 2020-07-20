**Build your own image**

Download the latest .Net Micro Agent distribution from [nuget.org](https://www.nuget.org/packages/AppDynamics.Agent.Distrib.Micro.Windows/)

Toss the downloaded file as is into this folder, note the agent version number (e.g `20.6.0`) of the nupkg file.  

Locate the `build.ps1` in the folder and run `./build.ps1` passing the version, as it appears in the name of the nupkg file, like this:

`build.ps1 -agentVersion <version-number> -dockerHubHandle <docker-hub-name>`

Where :

-  `version-number` is the agent version to be used for tagging. You must tag the image.

-  `docker-hub-handle` is the image reference, for example, if I want to push the image to my private dockerhub repo, I'd use `iogbole` as the `dockerHubHandle` in the build parameter.  This is an optional field and it defaults to `appdynamics`

Since this image only applies to Windows Container, you  would need to define the appropriate nodeSelectors and tolerations in your kubernetes manifest.

## Test the Image

`docker run -it <image-name> pwsh -c "ls c:/appdynamics/dotnet-agent"`

The output should should contain a list of some dll files and json file. 

s
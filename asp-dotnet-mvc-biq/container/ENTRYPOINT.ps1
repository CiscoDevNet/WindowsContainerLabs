
& "C:\AppDynamics\DotNetAgent\BootstrapAppD.ps1"

& "C:\AppDynamics\DotNetAgent\GenerateLoad.ps1"

# Any args from K8s spec can be read using the format below
$arguments = "" 
foreach ($arg in $args) {
    $arguments = $arguments + " " + $arg
}

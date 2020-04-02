
while ($true) { 
 
    Write-Host "Home"
    Invoke-WebRequest -Uri "http://localhost" -UseBasicParsing 
    Start-Sleep -s 5
    Write-Host "About"
    Invoke-WebRequest -Uri "http://localhost/Home/About" -UseBasicParsing 
    Start-Sleep -s 5
    Write-Host "Contact"
    Invoke-WebRequest -Uri "http://localhost/Home/Contact" -UseBasicParsing 
    Start-Sleep -s 5
    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/values/2" -UseBasicParsing 
    Start-Sleep -s 5
    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/" -UseBasicParsing 
    Start-Sleep -s 5
    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/io" -UseBasicParsing 
    Start-Sleep -s 5

    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/buy" -UseBasicParsing 
    Start-Sleep -s 5

    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/chelly" -UseBasicParsing 
    Start-Sleep -s 5

    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/healthCheck" -UseBasicParsing 
    Start-Sleep -s 5

    Write-Host "API"
    Invoke-WebRequest -Uri "http://localhost/api/value/4" -UseBasicParsing 
    Start-Sleep -s 5

    clear

}
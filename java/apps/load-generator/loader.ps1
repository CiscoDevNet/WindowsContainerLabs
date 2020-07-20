while(1){

#springboot app 
 Invoke-WebRequest -UseBasicParsing http://windows-client-api:8080/home
 Invoke-WebRequest -UseBasicParsing http://windows-client-api:8080/basket
 Invoke-WebRequest -UseBasicParsing http://windows-client-api:8080/supplier
 Invoke-WebRequest -UseBasicParsing http://windows-client-api:8080/product
 Invoke-WebRequest -UseBasicParsing http://windows-client-api:8080/checkout

 #aspnet appd iis 

 Invoke-WebRequest -UseBasicParsing http://front-end
 Invoke-WebRequest -UseBasicParsing http://front-end/Contact
 Invoke-WebRequest -UseBasicParsing http://front-end/About

 Start-Sleep -Seconds 10

}
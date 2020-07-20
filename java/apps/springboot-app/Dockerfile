#FROM openjdk:8u262-nanoserver
FROM openjdk:8u262-windowsservercore-1809

COPY target/demo-0.0.1-SNAPSHOT.war /demo-app.war
EXPOSE 8080

CMD ["java", "-jar", "/demo-app.war"]
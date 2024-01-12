FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

# Use the official Tomcat image as the base image
FROM tomcat:9-jre11
# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*
# Copy your Spring Boot WAR file into the Tomcat webapps directory
COPY target/Dashboard.war /usr/local/tomcat/webapps/ROOT.war
# Expose the default Tomcat port
EXPOSE 8080
# Start Tomcat
CMD ["catalina.sh", "run"]

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.war Dashboard.war
COPY --from=build /Data.csv /Data.csv
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.war"]

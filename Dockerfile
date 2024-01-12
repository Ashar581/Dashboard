FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.war Dashboard.war
COPY --from=build /Data.csv /Data.csv
COPY lib/jstl-1.2.jar /usr/local/tomcat/lib/
COPY lib/standard-1.1.2.jar /usr/local/tomcat/lib/
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.war"]

# Use the official Tomcat image as the base image
FROM tomcat:9-jre11

# Remove the default Tomcat webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your Spring Boot WAR file into the Tomcat webapps directory
COPY --from=build /target/*.war Dashboard.war

# Copy the JSTL libraries into the Tomcat lib directory
COPY --from=build lib/jstl-1.2.jar /usr/local/tomcat/lib/

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]

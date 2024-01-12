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

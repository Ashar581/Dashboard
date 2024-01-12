FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.war Dashboard.war
COPY --from=build /app/Data.csv /Data.csv
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.war"]

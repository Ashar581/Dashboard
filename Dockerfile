FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/Dashboard-0.0.1-SNAPSHOT.jar Dashboard.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.jar"]

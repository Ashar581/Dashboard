FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim

RUN git clone https://github.com/just4give/chartjs-node-canvas-lambda
COPY --from=build /target/*.war Dashboard.war
COPY --from=build /Data.csv /Data.csv
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.war"]

FROM maven:3-openjdk-17 AS build
COPY . .
RUN mvn clean package -DskipTests

FROM node:5
COPY . .
RUN npm install

RUN npm run build

EXPOSE 8080
CMD [ "node", "server.js" ]

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /target/*.war Dashboard.war
COPY --from=build /Data.csv /Data.csv
EXPOSE 8080
ENTRYPOINT ["java","-jar","Dashboard.war"]

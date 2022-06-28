FROM maven:3.6.3-jdk-11-slim AS build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:11
WORKDIR /app
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
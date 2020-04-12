FROM openjdk:latest
WORKDIR ./ ./
COPY ./target/*.jar ./app.jar
CMD ["java", "-jar", "./app.jar"]
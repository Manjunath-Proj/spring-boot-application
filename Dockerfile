FROM: openjdk:17-jdk-slim
EXPOSE 8080
COPY target/springboot-application-0.0.1-SNAPSHOT.jar /app/springboot-application-0.0.1-SNAPSHOT.jar
ENTRYPOINT ["java", "-jar", "/app/springboot-application-0.0.1-SNAPSHOT.jar"]
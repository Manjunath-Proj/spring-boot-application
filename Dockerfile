FROM eclipse-temurin:17-jdk-alpine
EXPOSE 8080
COPY target/springboot-k8s-demo.jar /app/springboot-k8s-demo.jar
ENTRYPOINT ["java", "-jar", "/app/springboot-k8s-demo.jar"]
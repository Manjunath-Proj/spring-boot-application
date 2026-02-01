# Spring Boot Kubernetes Demo Application

A simple Spring Boot application demonstrating deployment to Kubernetes with Docker containerization and Jenkins CI/CD pipeline.

## Application Details

- **Framework**: Spring Boot 3.2.1
- **Java Version**: 17
- **Port**: 8080
- **Docker Image**: `dewdropsmk/springboot:v1`

## Available Endpoints

### GET /message
Returns a success message confirming the application is running.

**Response:**
```
Congratulation you successfully deployed your application to kubernetes !!
```

## Running the Application

### Using Docker

#### Pull and Run the Docker Image

```bash
# Pull the image from Docker Hub
docker pull dewdropsmk/springboot:v1

# Run the container
docker run -d -p 8080:8080 --name springboot-app dewdropsmk/springboot:v1
```

#### Alternative Port Mappings

If port 8080 is already in use on your host:

```bash
# Run on port 9090
docker run -d -p 9090:8080 --name springboot-app dewdropsmk/springboot:v1

# Run on port 3000
docker run -d -p 3000:8080 --name springboot-app dewdropsmk/springboot:v1
```

### Accessing the Application

Once the container is running, access the application:

```bash
# Using curl
curl http://localhost:8080/message

# Or open in browser
http://localhost:8080/message
```

**Note:** Accessing `http://localhost:8080/` (root path) will show a 404 error because there's no mapping for the root endpoint. Always use `/message`.

### Managing the Container

```bash
# Check running containers
docker ps

# View application logs
docker logs springboot-app

# Stop the container
docker stop springboot-app

# Start the container
docker start springboot-app

# Remove the container
docker rm springboot-app
```

## Building from Source

### Prerequisites

- Java 17
- Maven 3.9+
- Docker

### Build Steps

```bash
# Clone the repository
git clone https://github.com/Manjunath-Proj/spring-boot-application.git
cd spring-boot-application

# Build with Maven
mvn clean package

# Build Docker image
docker build -t dewdropsmk/springboot:v1 .

# Run the container
docker run -d -p 8080:8080 dewdropsmk/springboot:v1
```

## CI/CD Pipeline

This project uses Jenkins for automated building, testing, and deployment. The pipeline runs on `k8s-Node-1` and includes:

1. **Check Environment** - Verify Java 17 and Maven setup
2. **Clone Code** - Fetch latest code from GitHub
3. **Compile** - Compile Java source files
4. **Review Code** - Run PMD static code analysis
5. **Test** - Execute unit tests
6. **Package** - Create JAR file
7. **Build Docker Image** - Build and tag Docker image
8. **Push to Docker Hub** - Publish image to Docker registry

## Troubleshooting

### Port Already in Use

If you get a port binding error, either:
- Stop the service using port 8080
- Use a different host port: `docker run -d -p 9090:8080 dewdropsmk/springboot:v1`

### Container Won't Start

Check the logs:
```bash
docker logs springboot-app
```

### 404 Error

Make sure you're accessing the correct endpoint: `/message`, not the root path `/`.

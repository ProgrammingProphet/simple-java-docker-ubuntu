# Simple Java Docker Application

## 📌 Overview

This project demonstrates how to containerize a basic Java application using Docker.
It covers:

* Writing a simple Java program
* Creating a Dockerfile
* Building a Docker image
* Running the container
* Understanding JDK vs JRE usage
* Using multi-stage builds (optional production approach)

This project is suitable for beginners learning Docker in a DevOps workflow.

---

## 🏗 Project Structure

```
simple-java-docker/
│
├── Dockerfile
└── src/
    └── Main.java
```

---

## ☕ Java Application

`Main.java` contains a simple Java program:

```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello from Dockerized Java App!");
    }
}
```

---

## 🐳 Dockerfile (Basic Version - JDK Only)

```dockerfile
FROM eclipse-temurin:21-jdk-alpine

WORKDIR /app

COPY src/Main.java .

RUN javac Main.java

CMD ["java", "Main"]
```

This image:

* Uses OpenJDK 21 (Temurin distribution)
* Compiles the Java file inside the container
* Runs the compiled class

---

## 🚀 Build the Docker Image

From the project root directory:

```bash
docker build -t java-app .
```

---

## ▶️ Run the Container

```bash
docker run java-app
```

Expected output:

```
Hello from Dockerized Java App!
```

---

## 🏭 Production-Grade Version (Multi-Stage Build)

For better practice and smaller images:

```dockerfile
# Stage 1: Build
FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY src/Main.java .
RUN javac Main.java

# Stage 2: Runtime
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/Main.class .
CMD ["java", "Main"]
```

### Why Multi-Stage?

* Smaller final image
* No compiler in runtime
* Reduced attack surface
* Better DevOps practice

---

## 🛠 Requirements

* Ubuntu / Linux (or any OS with Docker installed)
* Docker Engine
* Internet connection (to pull base image)

Check Docker installation:

```bash
docker --version
```

---

## 📚 What This Project Demonstrates

* Basic Dockerfile structure
* Image building process
* Container execution
* Difference between JDK and JRE
* Multi-stage builds
* Layer caching concept

---

## 🧹 Useful Docker Commands

List images:

```bash
docker images
```

List running containers:

```bash
docker ps
```

Remove image:

```bash
docker rmi java-app
```

---

## 🎯 Learning Outcome

After completing this project, you should understand:

* How Docker containers package Java applications
* How to build and run custom images
* Why multi-stage builds are recommended in production
* Basic Docker troubleshooting on Ubuntu AWS EC2

---

## 📌 Author

Aditya Vishwakarma -- Big Thanks to Shubham Bhaiya - TWS
Created as part of a DevOps learning journey.

---

If you are learning Docker, consider extending this project by:

* Adding Maven or Gradle
* Building a Spring Boot application
* Pushing the image to Docker Hub
* Deploying it on AWS EC2 or Kubernetes

---

#pull a base img which give all required tools and libraries 
FROM eclipse-temurin:21-jdk-alpine

#create a folder where the app code wil be store
WORKDIR /app 

#copy the source code to that working directory
COPY src/Main.java /app/Main.java

#compile the application code - generate class file
RUN javac Main.java

#run the application
CMD ["java", "Main"]

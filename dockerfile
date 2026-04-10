# Use official Maven image (has Java + Maven already)
FROM maven:3.9.9-eclipse-temurin-17

# Set working directory
WORKDIR /app

# Copy pom.xml first (for caching dependencies)
COPY pom.xml .

# Download dependencies
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Use lightweight JDK image to run app
FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

# Copy built jar from previous stage
COPY --from=0 /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
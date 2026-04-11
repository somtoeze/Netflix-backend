# Use official Maven image (has Java + Maven already)
FROM Ubuntu

   #intall  necessary packages
RUN apt-get update && apt-get get install -y
RUN apt install openjdk-17-jre headless -y
RUN apt install maven -y

   #setting working directory
WORKDIR /app

   #copy all files to directory
COPY ./src /app/src
COPY ./pom.xml /app

   #build the application
RUN mvn -f  /app/pom.xml clean package -dskiptest

   #copy the built jar file to the container
COPY ./target/*.jar /app/app.jar

   Expose 8080

    #Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

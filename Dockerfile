# Première étape : Construction
FROM ubuntu:latest AS build
# depuis l'image ubuntu en tant que build
RUN apt-get update && apt-get install -y openjdk-17-jdk maven
# télécharger dans le container (temporaire) les dépendances java et maven
WORKDIR /app
# je créer un dossier app dans mon container
COPY . .
# je copie mon projet dans le dossier app
RUN mvn clean package
# je lance mvn clean package pour compiler mon projet

# Deuxième étape : Exécution
FROM openjdk:17-jdk-slim
# depuis l'image openjdk en tant que jdk slim
EXPOSE 8080
# j'expose le port 8080
COPY --from=build /app/target/Render-0.0.1-SNAPSHOT.jar app.jar
# je copie le fichier jar dans le container
ENTRYPOINT ["java", "-jar", "app.jar"]
# je lance le jar
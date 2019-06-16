FROM gradle:5.4.1-jdk11 AS build

RUN mkdir /home/gradle/app
WORKDIR /home/gradle/app

COPY build.gradle build.gradle
COPY settings.gradle settings.gradle
COPY gradle.properties gradle.properties
COPY src src

RUN gradle build

FROM openjdk:11-jre-slim
LABEL maintainer="erebos <erebos12@web.de>"

ENV ARTIFACT_NAME myapp-0.0.1-SNAPSHOT.jar

WORKDIR /usr/app/
COPY --from=build /home/gradle/app/build/libs/$ARTIFACT_NAME ./$ARTIFACT_NAME
EXPOSE 8080
CMD ["/bin/bash", "-c", "java -jar $ARTIFACT_NAME"]

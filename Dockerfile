FROM gradle:7.6.0-jdk17 AS build
WORKDIR /home/app
COPY --chown=gradle:gradle . /home/app
RUN chmod +x ./gradlew && ./gradlew build -x test
# -------------------------
# Build 단계에서 생성된 JAR을 이용
FROM openjdk:18.0-slim
VOLUME /tmp
EXPOSE 8080
COPY --from=build /home/app/build/libs/*.jar app.jar
ENTRYPOINT ["sh", "-c", "java -jar /app.jar"]
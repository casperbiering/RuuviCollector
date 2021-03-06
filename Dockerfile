FROM balenalib/raspberrypi3-alpine-openjdk:8-jdk-3.6-build AS build

RUN apk update && apk add maven nss

ADD . /usr/src/app
WORKDIR /usr/src/app

RUN mvn package

FROM balenalib/raspberrypi3-alpine-openjdk:8-jdk-3.6-run

RUN apk update && apk add nss bluez bluez-deprecated

COPY --from=build /usr/src/app/target/ruuvi-collector-0.2.jar /app/ruuvi-collector.jar
WORKDIR /app
CMD ["java", "-jar", "ruuvi-collector.jar"]

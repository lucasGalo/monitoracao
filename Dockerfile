#Build stage
#  FROM node:10-alpine
#  RUN cd ./traccar-web/modern npm install
#  RUN npm install
# RUN npm run build
# RUN pwd

# Build stage
FROM gradle:7.5.1 AS BUILD_STAGE
COPY --chown=gradle:gradle . /home/gradle
RUN gradle clean assemble

# Package stage
FROM adoptopenjdk:11-jre-hotspot-focal
ENV ARTIFACT_NAME=prosat.jar
ENV APP_HOME=/opt/traccar
COPY --from=BUILD_STAGE /home/gradle/target/*.jar $APP_HOME/$ARTIFACT_NAME
COPY --from=BUILD_STAGE /home/gradle/target/lib $APP_HOME/lib
WORKDIR /opt/traccar

# ARG LIB_FILE=target/lib
# ARG JAR_FILE=target/*.jar
ARG DATA_FILE=data
ARG CONF_FILE=conf
ARG LOGS_FILE=logs
ARG TEMPLATES_FILE=templates
ARG SCHEMA_FILE=schema
ARG MODERN_FILE=traccar-web/modern/app
ARG LEGACY_FILE=legacy
ARG SETUP_FILE=setup

# COPY ${LIB_FILE} /opt/traccar/lib
# COPY ${JAR_FILE} /opt/traccar/$ARTIFACT_NAME
COPY ${DATA_FILE} /opt/traccar/data
COPY ${CONF_FILE} /opt/traccar/conf
COPY ${LOGS_FILE} /opt/traccar/logs
COPY ${TEMPLATES_FILE} /opt/traccar/templates
COPY ${SCHEMA_FILE} /opt/traccar/schema
COPY ${MODERN_FILE} /opt/traccar/modern
COPY ${LEGACY_FILE} /opt/traccar/legacy
COPY ${SETUP_FILE} /opt/traccar/conf

ENTRYPOINT ["java", "-Xms1g", "-Xmx1g", "-Djava.net.preferIPv4Stack=true"]

CMD ["-jar", "prosat.jar", "conf/traccar.xml"]

### gerar build
# $: docker build -t monitoracao:1.0.19 .

### Gerar container
### $: docker run --name monitoracao --hostname monitoracao --detach --restart unless-stopped --publish 80:8082 --publish 5000-5150:5000-5150 --publish 5000-5150:5000-5150/udp --volume /opt/monitoracao/logs:/opt/monitoracao/logs:rw --volume /opt/monitoracao/traccar.xml:/opt/monitoracao/conf/monitoracao.xml:ro monitoracao:1.0.19

### Verificar os logs
### $: docker container logs <container>


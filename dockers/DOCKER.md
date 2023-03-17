## Docker imagem pronta no dokcerhub
## Container create example:
1. **Create work directories:**
    ```bash
    mkdir -p /home/prosat/logs
    ```

1. **Get default traccar.xml:**
    ```bash
    docker run \
    --rm \
    --entrypoint cat \
    lucasgalo/prosat:latest \
    /opt/traccar/conf/traccar.xml > /home/prosat/prosat.xml
    ```

1. **Edit traccar.xml:** <https://www.traccar.org/configuration-file/>

1. **Create container:**
    ```bash
    docker run \
    --name prosat \
    --hostname prosat \
    --detach --restart unless-stopped \
    --publish 80:8082 \
    --publish 5000-5150:5000-5150 \
    --publish 5000-5150:5000-5150/udp \
    --volume /home/prosat/logs:/opt/traccar/logs:rw \
    --volume /home/prosat/prosat.xml:/opt/traccar/conf/traccar.xml:ro \
    lucasgalo/prosat:0.3.0
    ```
### outro método seria baixar da release do git.
### Deixar o DOCKERFILE como abaixo
   ```bash
   FROM adoptopenjdk:11-jre-hotspot-focal
   
   ENV TRACCAR_VERSION 5.6
   
   WORKDIR /opt/traccar
   
   RUN set -ex && \
   apt-get update &&\
   TERM=xterm DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends unzip wget && \
   wget -qO /tmp/traccar.zip https://github.com/traccar/traccar/releases/download/v$TRACCAR_VERSION/traccar-other-$TRACCAR_VERSION.zip && \
   unzip -qo /tmp/traccar.zip -d /opt/traccar && \
   apt-get autoremove --yes unzip wget && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/*
   
   ENTRYPOINT ["java", "-Xms1g", "-Xmx1g", "-Djava.net.preferIPv4Stack=true"]
   
   CMD ["-jar", "tracker-server.jar", "conf/traccar.xml"]
   ```

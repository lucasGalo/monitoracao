   FROM adoptopenjdk:11-jre-hotspot-focal
   
   ENV $PROSAT_VERSION 0.1.0
   
   WORKDIR /opt/traccar
   
   RUN set -ex && \
   apt-get update &&\
   TERM=xterm DEBIAN_FRONTEND=noninteractive apt-get install --yes --no-install-recommends unzip wget && \
   wget -qO /tmp/traccar.zip https://github.com/lucasGalo/monitoracao/releases/download/v$PROSAT_VERSION/prosat-other-$PROSAT_VERSION.zip && \
   unzip -qo /tmp/traccar.zip -d /opt/traccar && \
   apt-get autoremove --yes unzip wget && \
   apt-get clean && \
   rm -rf /var/lib/apt/lists/* /tmp/*
   
   ENTRYPOINT ["java", "-Xms1g", "-Xmx1g", "-Djava.net.preferIPv4Stack=true"]
   
   CMD ["-jar", "Pro-Sat.jar", "conf/traccar.xml"]
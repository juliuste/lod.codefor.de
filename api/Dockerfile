FROM eclipse-temurin:21-alpine

USER root

# hadolint ignore=DL3015,DL3018
RUN apk add --no-cache openssl && mkdir -p /app
WORKDIR /app

# download fuseki
ADD https://repo1.maven.org/maven2/org/apache/jena/jena-fuseki-server/5.0.0/jena-fuseki-server-5.0.0.jar fuseki-server.jar

# download datasets
RUN mkdir data

## vg250-ew
ADD https://scraped.data.juliustens.eu/vg250-ew/data.ttl.gz data/vg250-ew.ttl.gz
RUN cat data/vg250-ew.ttl.gz | gunzip > data/vg250-ew.ttl

RUN rm data/*.gz

COPY server.ttl .

RUN chown -R 1000:1000 /app
USER 1000

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://localhost:8080/actuator/health/ | grep UP || exit 1

ENV JAVA_OPTS="-Xmx1000m -Xms1000m"

# hadolint ignore=DL3025
CMD java $JAVA_OPTS -jar fuseki-server.jar --config=server.ttl --port=8080 --gzip=on

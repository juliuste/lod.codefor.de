FROM eclipse-temurin:21-alpine

USER root

# hadolint ignore=DL3015,DL3018
RUN apk add --no-cache curl openssl && mkdir -p /app
WORKDIR /app

# download fuseki
ADD https://repo1.maven.org/maven2/org/apache/jena/jena-fuseki-server/5.0.0/jena-fuseki-server-5.0.0.jar fuseki-server.jar

RUN curl 'https://scraped.data.juliustens.eu/combined.ttl.gz' | gunzip > data.ttl

COPY server.ttl .

RUN chown -R 1000:1000 /app
USER 1000

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --retries=3 CMD wget -qO- http://localhost:8080/actuator/health/ | grep UP || exit 1

ENV JAVA_OPTS="-Xmx1000m -Xms1000m"

# hadolint ignore=DL3025
CMD java $JAVA_OPTS -jar fuseki-server.jar --config=server.ttl --port=8080 --gzip=on

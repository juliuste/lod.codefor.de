FROM ubuntu:noble

USER root
RUN apt-get update && apt-get install -y curl

WORKDIR /app

ADD https://github.com/gtfierro/reasonable/releases/download/nightly/reasonable-static reasonable
RUN chmod +x reasonable

RUN curl 'http://www.w3.org/2002/07/owl#' -H 'Accept: text/turtle' -L > owl.ttl
RUN curl 'http://www.w3.org/1999/02/22-rdf-syntax-ns#' -H 'Accept: text/turtle' -L > rdf.ttl
RUN curl 'http://www.w3.org/2000/01/rdf-schema#' -H 'Accept: text/turtle' -L > rdfs.ttl
RUN curl 'http://www.opengis.net/ont/geosparql#' -H 'Accept: text/turtle' -L > geosparql.ttl
RUN curl 'http://rdfs.co/juso/0.1.2/ttl' -H 'Accept: text/turtle' -L > juso.ttl
RUN curl 'https://raw.githubusercontent.com/juliuste/open-data-scraper/refs/heads/main/ontologies/codeforde.ttl' -L > codeforde.ttl

COPY ./run.sh ./run.sh

RUN chown -R 1000:1000 /app
USER 1000

ENV S3_BUCKET_NAME="tbd"
ENTRYPOINT [ "./run.sh" ]

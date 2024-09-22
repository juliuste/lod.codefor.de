#!/usr/bin/env bash

set -euxo pipefail

curl -L 'https://scraped.data.juliustens.eu/vg250-ew/data.ttl.gz' > vg250-ew.ttl.gz
cat vg250-ew.ttl.gz | gunzip > vg250-ew.ttl
rm *.gz

./reasonable -o result.ttl codeforde.ttl juso.ttl geosparql.ttl owl.ttl rdf.ttl rdfs.ttl vg250-ew.ttl
cat result.ttl | gzip > result.ttl.gz

aws s3 cp --acl public-read result.ttl.gz s3://"$S3_BUCKET_NAME"/combined.ttl.gz

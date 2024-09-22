#!/usr/bin/env bash

set -exo pipefail

if [ -z "$S3_ACCESS_KEY_ID" ]; then
  echo "Missing environment variable: S3_ACCESS_KEY_ID"
  exit 1
fi
if [ -z "$S3_SECRET_ACCESS_KEY" ]; then
  echo "Missing environment variable: S3_SECRET_ACCESS_KEY"
  exit 1
fi
if [ -z "$S3_ENDPOINT" ]; then
  echo "Missing environment variable: S3_ENDPOINT"
  exit 1
fi
if [ -z "$S3_BUCKET_NAME" ]; then
  echo "Missing environment variable: S3_BUCKET_NAME"
  exit 1
fi

echo "
[default]
access_key = $S3_ACCESS_KEY_ID
secret_key = $S3_SECRET_ACCESS_KEY
check_ssl_certificate = True
guess_mime_type = True
host_base = $S3_ENDPOINT
host_bucket = $S3_ENDPOINT
use_https = True
" > ~/.s3cfg;

curl -L 'https://scraped.data.juliustens.eu/vg250-ew/data.ttl.gz' > vg250-ew.ttl.gz
cat vg250-ew.ttl.gz | gunzip > vg250-ew.ttl
rm *.gz

./reasonable -o result.ttl codeforde.ttl juso.ttl geosparql.ttl owl.ttl rdf.ttl rdfs.ttl vg250-ew.ttl
cat result.ttl | gzip > result.ttl.gz

s3cmd put --acl-public result.ttl.gz s3://"$S3_BUCKET_NAME"/combined.ttl.gz

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

mkdir ~/.aws;
echo "
[default]
aws_access_key_id=$S3_ACCESS_KEY_ID
aws_secret_access_key=$S3_SECRET_ACCESS_KEY
" > ~/.aws/credentials;
echo "
[default]
endpoint_url = $S3_ENDPOINT
region=auto
s3 =
  multipart_threshold = 2000MB
  multipart_chunksize = 2000MB
" > ~/.aws/config;

curl -L 'https://scraped.data.juliustens.eu/vg250-ew/data.ttl.gz' > vg250-ew.ttl.gz
cat vg250-ew.ttl.gz | gunzip > vg250-ew.ttl
rm *.gz

./reasonable -o result.ttl codeforde.ttl juso.ttl geosparql.ttl owl.ttl rdf.ttl rdfs.ttl vg250-ew.ttl
cat result.ttl | gzip > result.ttl.gz

aws s3 cp --acl public-read result.ttl.gz s3://"$S3_BUCKET_NAME"/combined.ttl.gz

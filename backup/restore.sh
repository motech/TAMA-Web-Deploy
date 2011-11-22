#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage $0 <target-directory>"; exit; fi

mkdir -p $1

source ../../prod-deploy-properties/prod.properties

# The destination
DEST=s3+http://$S3_BUCKET

duplicity \
    --encrypt-key=${GPG_KEY} \
    --sign-key=${GPG_KEY} \
    $DEST $1

# Reset the ENV variables. Don't need them sitting around
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export PASSPHRASE=

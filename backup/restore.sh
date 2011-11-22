#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage $0 <target-directory>"; exit; fi

mkdir -p $1

export AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
export AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
export PASSPHRASE=<PASSPHRASE>
GPG_KEY=<GPG_KEY>
S3_BUCKET=<S3_BUCKET>

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

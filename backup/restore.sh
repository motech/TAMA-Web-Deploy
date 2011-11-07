#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage $0 <target-directory>"; exit; fi

mkdir -p $1

export AWS_ACCESS_KEY_ID=AKIAJINWYVHMJ4U7FKAA
export AWS_SECRET_ACCESS_KEY=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
export PASSPHRASE=amat
GPG_KEY=BED50DF2
S3_BUCKET=tama-nightly-backups

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

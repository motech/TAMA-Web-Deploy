#!/bin/bash

if [ $# -lt 1 ]; then echo "Usage $0 <source-directory>"; exit; fi

# Export some ENV variables so you don't have to type anything
source ../../prod-deploy-properties/prod.properties

# The source of your backup
SOURCE=$1

# The s3 destination
DEST=s3+http://$S3_BUCKET

echo uploading $SOURCE to s3 bucket $S3_BUCKET...

duplicity \
    --encrypt-key=$GPG_KEY \
    --sign-key=$GPG_KEY \
    --volsize=250 \
    $SOURCE $DEST

echo done.

# Reset the ENV variables. Don't need them sitting around
unset export AWS_ACCESS_KEY_ID
unset export AWS_SECRET_ACCESS_KEY
unset export PASSPHRASE

#!/bin/bash
echo "***************** Downloading **********************"
curl -f -c cookie.txt -d "j_username=$4&j_password=$5" $1 || exit 1
curl -f -b cookie.txt $2 -o $3 || exit 1
rm cookie.txt
echo "***************** Downloaded ***********************"

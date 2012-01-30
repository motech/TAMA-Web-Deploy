#!/bin/sh
#usage script language filename

KOOKOO_URL=http://kookoo.in/restkookoo/index.php/api/cache/audio
KOOKOO_API_KEY=<API_KEY>
TAMA_HOSTNAME=<HOST_NAME>
TAMA_APP_NAME=<TAMA_APP_NAME>


for i in $2; do
 wave_file_name=`basename $i|tr [A-Z] [a-z]`
 echo "Deleting...:$wave_file_name"
 curl $KOOKOO_URL/api_key/$KOOKOO_API_KEY/url/http:%5C%5C$TAMA_HOSTNAME%5C$TAMA_APP_NAME%5Cwav%5Cstream%5C$1%5C$wave_file_name/delete/true
 echo "Uploading...:$wave_file_name"
 curl -d "api_key=$KOOKOO_API_KEY&url=http://$TAMA_HOSTNAME/$TAMA_APP_NAME/wav/stream/$1/$wave_file_name" $KOOKOO_URL
done

echo "Done"


#!/bin/sh

if [ -z "$1" ]
then
   echo "Usage: ./cache.sh <path_to_TAMA-Web-Audio_folder>"
   echo "Example: ./cache.sh /home/motech/TAMA-Web-Audio"
   exit 3
fi

KOOKOO_URL=http://kookoo.in/restkookoo/index.php/api/cache/audio
KOOKOO_API_KEY=KKbedce53758c2e0b0e9eed7191ec2a466
TAMA_HOSTNAME=tama.showcase.thoughtworks.com

echo "Processing english files"

for i in `find $1/en -name "*.wav" `; do 
 wave_file_name=`basename $i|tr [A-Z] [a-z]`
 echo "Deleting...en:$wave_file_name"
 curl $KOOKOO_URL/api_key/$KOOKOO_API_KEY/url/http:%5C%5C$TAMA_HOSTNAME%5Ctama%5Cwav%5Cen%5C$wave_file_name/delete/true
 echo "Uploading...en:$wave_file_name"
 curl -d "api_key=$KOOKOO_API_KEY&url=http://$TAMA_HOSTNAME/tama/wav/en/$wave_file_name" $KOOKOO_URL
done

echo "Processing marathi files"

for i in `find $1/mr -name "*.wav" `; do 
 wave_file_name=`basename $i|tr [A-Z] [a-z]`
 echo "Deleting...mr:$wave_file_name"
 curl $KOOKOO_URL/api_key/$KOOKOO_API_KEY/url/http:%5C%5C$TAMA_HOSTNAME%5Ctama%5Cwav%5Cmr%5C$wave_file_name/delete/true
 echo "Uploading...mr:$wave_file_name"
 curl -d "api_key=$KOOKOO_API_KEY&url=http://$TAMA_HOSTNAME/tama/wav/mr/$wave_file_name" $KOOKOO_URL 
done

echo "Done"

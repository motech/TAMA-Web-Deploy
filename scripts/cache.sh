#!/bin/sh

if [ ! "$#" -eq "2" ]
then
   echo "Usage: ./cache.sh <path_to_TAMA-Web-Audio_folder> API_KEY"
   echo "Example: ./cache.sh /home/motech/TAMA-Web-Audio apikey"
   exit 3
fi

KOOKOO_URL=http://kookoo.in/restkookoo/index.php/api/cache/audio
KOOKOO_API_KEY=$2
TAMA_HOSTNAME=tama.showcase.thoughtworks.com

cd $1;

for dir in `ls -p | grep "/" | tr -d /`; do
 echo "Processing "$dir" files"
 for i in `find $dir -name "*.wav" `; do
  wave_file_name=`basename $i|tr [A-Z] [a-z]`
  echo "Deleting..."$dir":"$wave_file_name"
  curl $KOOKOO_URL/api_key/$KOOKOO_API_KEY/url/http:%5C%5C$TAMA_HOSTNAME%5Ctama%5Cwav%5Cstream%5C$dir%5C$wave_file_name/delete/true
  echo "Uploading..."$dir":"$wave_file_name"
  curl -d "api_key=$KOOKOO_API_KEY&url=http://$TAMA_HOSTNAME/tama/wav/stream/$dir/$wave_file_name" $KOOKOO_URL
 done
done

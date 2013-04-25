#!/bin/sh

TAMA_WEB_AUDIO_PATH=$1
KOOKOO_API_KEY=$2
TAMA_HOSTNAME=$3
APPLICATION_NAME=$4

if [ ! "$#" -eq "4" ]
then
   echo "Usage: ./upload_delta_to_cache.sh <path_to_TAMA-Web-Audio_folder> API_KEY HOST_NAME APPLICATION_NAME"
   echo "Example: ./upload_delta_to_cache.sh /home/motech/TAMA-Web-Audio apikey hostname tama"
   exit 3
fi
cd $TAMA_WEB_AUDIO_PATH

sha1=`git log --oneline -1 | awk '{print $1'}`

git pull --rebase

sha2=`git log --oneline -1 | awk '{print $1'}`

#echo $sha1
#echo $sha2

if [ $sha1 = $sha2 ]; then
    echo "No files have changed to be uploaded to the Cache"
    exit
fi

KOOKOO_URL=http://kookoo.in/restkookoo/index.php/api/cache/audio

for file in `git diff --name-only $sha1 $sha2`; do
    dir=${file%%\/*}
    wave_file_name=`basename $file |tr [A-Z] [a-z]`
    echo "Deleting..."$dir":"$wave_file_name"
  	curl $KOOKOO_URL/api_key/$KOOKOO_API_KEY/url/http:%5C%5C$TAMA_HOSTNAME%5C$APPLICATION_NAME%5Cwav%5Cstream%5C$dir%5C$wave_file_name/delete/true
  	echo "Uploading..."$dir":"$wave_file_name"
  	curl -d "api_key=$KOOKOO_API_KEY&url=http://$TAMA_HOSTNAME/$APPLICATION_NAME/wav/stream/$dir/$wave_file_name" $KOOKOO_URL

done

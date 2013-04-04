#!/bin/sh
BUILD_ENV=$1
BUILD=$2
HUDSON_ADDRESS=$4
WORKING_DIR=/tmp/deploy
DEPLOY_VERSION=0.1-SNAPSHOT
DEPLOY_TARGET=$3
HUDSON_JOB_NAME=tama-web-deploy

rm -rf $WORKING_DIR
mkdir $WORKING_DIR
cd $WORKING_DIR

wget http://'$HUDSON_ADDRESS'/view/tama/job/$HUDSON_JOB_NAME/lastSuccessfulBuild/TAMA-Web-Deploy\$TAMA-Web-Deploy/artifact/TAMA-Web-Deploy/TAMA-Web-Deploy/$DEPLOY_VERSION/TAMA-Web-Deploy-$DEPLOY_VERSION-bin.zip
unzip TAMA-Web-Deploy-$DEPLOY_VERSION-bin.zip
rm -rf TAMA-Web-Deploy-$DEPLOY_VERSION-bin.zip
cd TAMA-Web-Deploy-$DEPLOY_VERSION && sudo ant $3 -f deploy.xml -Denv=$BUILD_ENV -Dbuild=$BUILD


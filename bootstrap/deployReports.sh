#!/bin/sh
BUILD_ENV=$1
BUILD=$2
WORKING_DIR=/tmp/deployReports
DEPLOY_VERSION=1.0-SNAPSHOT
DEPLOY_TARGET=$3
HUDSON_JOB_NAME=tama-reports-deploy

rm -rf $WORKING_DIR
mkdir $WORKING_DIR
cd $WORKING_DIR

wget 'http://192.168.42.26/view/tama/job/'$HUDSON_JOB_NAME'/lastSuccessfulBuild/org.motechproject.tama.reports$tama-reports-deploy/artifact/org.motechproject.tama.reports/tama-reports-deploy/'$DEPLOY_VERSION'/tama-reports-deploy-'$DEPLOY_VERSION'.jar'
unzip tama-reports-deploy-$DEPLOY_VERSION.jar
rm -rf tama-reports-deploy-$DEPLOY_VERSION.jar
sudo ant $3 -f deploy.xml -Denv=$BUILD_ENV -lib . -Dbuild=$BUILD

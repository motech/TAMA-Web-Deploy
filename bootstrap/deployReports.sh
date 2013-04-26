#!/bin/sh
BUILD_ENV=$1
HUDSON_ADDRESS=$4
BUILD=$2
WORKING_DIR=/tmp/deployReports
DEPLOY_VERSION=1.01
DEPLOY_TARGET=$3
HUDSON_JOB_NAME=tama-reports-deploy-1.01

rm -rf $WORKING_DIR
mkdir $WORKING_DIR
cd $WORKING_DIR

wget 'http://'$HUDSON_ADDRESS'/view/tama/job/'$HUDSON_JOB_NAME'/lastSuccessfulBuild/org.motechproject.tama.reports$tama-reports-deploy/artifact/org.motechproject.tama.reports/tama-reports-deploy/'$DEPLOY_VERSION'/tama-reports-deploy-'$DEPLOY_VERSION'.jar'
unzip tama-reports-deploy-$DEPLOY_VERSION.jar
rm -rf tama-reports-deploy-$DEPLOY_VERSION.jar
sudo ant $3 -f deploy.xml -Denv=$BUILD_ENV -lib . -Dbuild=$BUILD

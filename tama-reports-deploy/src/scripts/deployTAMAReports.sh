#!/bin/sh
BUILD_ENV=$1
BUILD=$2
WORKING_DIR=/tmp/deployReports
DEPLOY_VERSION=1.0-SNAPSHOT
HUDSON_JOB_NAME=tama-reporting

rm -rf $WORKING_DIR
mkdir $WORKING_DIR
cd $WORKING_DIR

wget 'http://old-ci.motechproject.org/view/tama/job/tama-reports-deploy/lastSuccessfulBuild/org.motechproject.tama.reports$tama-reports-deploy/artifact/org.motechproject.tama.reports/tama-reports-deploy/'$DEPLOY_VERSION'/tama-reports-deploy-'$DEPLOY_VERSION'.jar'
unzip tama-reports-deploy-$DEPLOY_VERSION.jar
rm -rf tama-reports-deploy-$DEPLOY_VERSION.jar
sudo ant deploy.from.hudson.with.reset.db -Denv=$BUILD_ENV -lib . -Dbuild=$BUILD

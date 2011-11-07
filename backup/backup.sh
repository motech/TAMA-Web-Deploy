#!/bin/bash

# Set up some variables for logging
LOGFILE="/var/log/tama_backup.log"
DAILYLOGFILE="/var/log/tama_daily_backup.log"
DATE=`date +%Y-%m-%d`
MAILADDR="tama@mailinator.com"

# Clear the old daily log file
cat /dev/null > $DAILYLOGFILE

# Trace function for logging, don't change this
trace () {
        stamp=`date +%Y-%m-%d_%H:%M:%S`
        echo "$stamp: $*" >> $DAILYLOGFILE
}

service tomcat stop >> $DAILYLOGFILE
service activemq stop >> $DAILYLOGFILE
service couchdb stop >> $DAILYLOGFILE

WORK=temp
mkdir -p $WORK

mysqldump --all-databases -uroot -ppassword > $WORK/mysql.sql 2>> $DAILYLOGFILE

cp -fR /var/lib/couchdb $WORK/couchdb >> $DAILYLOGFILE

cp -fR $MQ_HOME/data/kahadb $WORK/kahadb >> $DAILYLOGFILE

./upload.sh $WORK >> $DAILYLOGFILE

service couchdb start >> $DAILYLOGFILE
service activemq start >> $DAILYLOGFILE
service tomcat start >> $DAILYLOGFILE

# Send the daily log file by email
cat "$DAILYLOGFILE" | mail -s "tama backup log - $DATE" $MAILADDR

# Append the daily log file to the main log file
cat "$DAILYLOGFILE" >> $LOGFILE

rm -rf $WORK

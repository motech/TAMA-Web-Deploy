#!/bin/bash

# Set up some variables for logging
LOGFILE="/var/log/tama_backup.log"
DAILYLOGFILE="/var/log/tama_daily_backup.log"
DATE=`date +%Y-%m-%d`
MAILADDR="tama@mailinator.com"

# Clear the old daily log file
cat /dev/null > $DAILYLOGFILE
source /etc/environment
# Trace function for logging, don't change this
trace () {
        stamp=`date +%Y-%m-%d_%H:%M:%S`
        echo "$stamp: $*" >> $DAILYLOGFILE
}

/etc/init.d/tomcat stop >> $DAILYLOGFILE
/etc/init.d/activemq stop >> $DAILYLOGFILE
/etc/init.d/couchdb stop >> $DAILYLOGFILE

WORK=temp
mkdir -p $WORK

mysqldump --all-databases -uroot -ppassword > $WORK/mysql.sql 2>> $DAILYLOGFILE

cp -fR /var/lib/couchdb $WORK/couchdb >> $DAILYLOGFILE

cp -fR $MQ_HOME/data/kahadb $WORK/kahadb >> $DAILYLOGFILE

./upload.sh $WORK >> $DAILYLOGFILE

/etc/init.d/couchdb start >> $DAILYLOGFILE
/etc/init.d/activemq start >> $DAILYLOGFILE
/etc/init.d/tomcat start >> $DAILYLOGFILE

# Send the daily log file by email
cat "$DAILYLOGFILE" | mail -s "tama backup log - $DATE" $MAILADDR

# Append the daily log file to the main log file
cat "$DAILYLOGFILE" >> $LOGFILE

rm -rf $WORK

#Vars
PWD=/tmp/version2-deploy

#cwd
rm -rf $PWD
mkdir $PWD

#Copy resources
cp mysql2pgsql.perl $PWD

#Move in
cd $PWD

#take mysql dump
echo "Generating Mysql dump..."
mysqldump -uroot -ppassword  --hex-blob  --no-create-info --result-file=dump.sql motechquartz QRTZ_JOB_DETAILS  QRTZ_TRIGGERS QRTZ_BLOB_TRIGGERS QRTZ_CALENDARS QRTZ_CRON_TRIGGERS QRTZ_FIRED_TRIGGERS QRTZ_JOB_LISTENERS QRTZ_PAUSED_TRIGGER_GRPS QRTZ_SCHEDULER_STATE QRTZ_SIMPLE_TRIGGERS QRTZ_TRIGGER_LISTENERS

#make sql dump compatible with postgres
echo "Processing Mysql dump..."
perl mysql2pgsql.perl dump.sql dumppg.sql

#decode hex strings as blobs
echo "Decoding hex..."
sed "s/0x\([0-9,A-F]*\))/decode('\1','hex'))/g" dumppg.sql > dumppg_decoded.sql


#create postgres db
echo "Creating database...."
sudo -u postgres createdb motechquartz;

#Load schema
echo "Loading Schema..."
sudo -u postgres psql motechquartz < ../../sql/quartz_tables.sql

#Load data
echo "Loading data..."
sudo -u postgres psql motechquartz < $PWD/dumppg_decoded.sql

#Cleaning up
echo "Cleaning up..."
rm -rf $PWD

echo "Done."



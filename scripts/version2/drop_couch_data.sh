echo "Stopping couchdb"
sudo service couchdb stop

echo "Clearing couchb data"
rm -rf /var/lib/couchdb/*
rm -rf /var/lib/couchdb/.*

echo "Starting couchdb"
sudo service couchdb start
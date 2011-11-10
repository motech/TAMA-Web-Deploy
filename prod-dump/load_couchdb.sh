#!/bin/bash

service stop tomcat

rm -rf ./couchdb/_users.couch
cp -rf ./couchdb/* /var/lib/couchdb/1.0.1
chown -R couchdb /var/lib/couchdb/

./patient_mask.py

service start tomcat

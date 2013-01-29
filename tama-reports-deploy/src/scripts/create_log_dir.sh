#!/bin/bash
#Usage create_log_dir app_name username groupname password
if [ ! -d "/var/log/$1" ]; then
	echo $4 | sudo -S mkdir /var/log/$1
	echo $4 | sudo -S chown -R $2:$3 /var/log/$1;
fi

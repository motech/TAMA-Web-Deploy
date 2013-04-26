echo "Stopping activemq"
sudo service activemq stop

echo "Clearing mq data"
cat kahadb_logging.properties >> /home/tamasuper/apache-activemq-5.5.1/conf/log4j.properties

echo "Starting activemq"
sudo service activemq start
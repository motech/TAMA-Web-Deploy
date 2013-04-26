echo "Stopping activemq"
sudo service activemq stop

echo "Clearing mq data"
rm -rf /home/tamasuper/apache-activemq-5.5.1/data/kahadb

echo "Starting activemq"
sudo service activemq start
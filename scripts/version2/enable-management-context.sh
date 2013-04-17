echo "Stopping activemq"
sudo service activemq stop

echo "Modify activemq config"
sed 's/createConnector="false"/createConnector="true"/g' /home/tamasuper/apache-activemq-5.5.1/conf/activemq.xml

echo "Starting activemq"
sudo service activemq start
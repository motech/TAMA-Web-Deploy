echo "Stopping activemq"
sudo kill -9 $(ps aux | grep activemq | awk '{print $2}' | sort | head -1 )

echo "Modify activemq config"
sed 's/createConnector="false"/createConnector="true"/g' /home/tamasuper/apache-activemq-5.5.1/conf/activemq.xml

echo "Starting activemq"
sudo service activemq start
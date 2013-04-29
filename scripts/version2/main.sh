DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Stopping the application..."
sudo service tomcat stop

cd $DIR
echo "Installing dependencies..."
sh ./install_dependencies.sh

cd $DIR
echo "Creating databases..."
sh ./create_databases.sh

cd $DIR
echo "Update Audio Files..."
sh ./update-audio-files.sh

cd $DIR
echo "Enabling activemq management context..."
sh ./enable-management-context.sh

cd $DIR
echo "Removing old messages..."
sh ./remove_mq_messages.sh

cd $DIR
echo "Resetting couch..."
sh ./drop_couch_data.sh

cd $DIR
echo "Updating kahadb logging..."
sh ./set_kahadb_props.sh

cd $DIR
echo "Adding postgres to auto start..."
chkconfig --add postgresql-9.1

cd $DIR
echo "Setting shm vars..."
sh ./set_shm_opts.sh

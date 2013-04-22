echo "Stopping the application..."
sudo service tomcat stop

cd "$(dirname "$0")"
echo "Installing dependencies..."
sh ./install_dependencies.sh

cd "$(dirname "$0")"
echo "Creating databases..."
sh ./create_databases.sh

cd "$(dirname "$0")"
echo "Update Audio Files..."
sh ./update-audio-files.sh

cd "$(dirname "$0")"
echo "Caching Audio files..."
sh ../cache.sh /home/tamasuper/deploy/TAMA-Web-Audio KK3e4ce46d72c6bebe803d53be3e48947c tamaproject.in

cd "$(dirname "$0")"
echo "Enabling activemq management context..."
sh ./enable-management-context.sh

cd "$(dirname "$0")"
echo "Adding postgres to auto start..."
chkconfig --add postgresql-9.1

cd "$(dirname "$0")"
echo "Setting shm vars..."
sh ./set_shm_opts.sh

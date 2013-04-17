cd "$(dirname "$0")"
echo "Installing dependencies..."
sh ./install_dependencies.sh
cd "$(dirname "$0")"
echo "Creating databases..."
sh ./create_databases.sh
cd "$(dirname "$0")"
echo "Migrating Jobs..."
sh ./migrate_jobs.sh
cd "$(dirname "$0")"
echo "Update Audio Files"
sh ./update-audio-files.sh
cd "$(dirname "$0")"
echo "Caching Audio files"
sh ../cache.sh /home/tamasuper/deploy/TAMA-Web-Audio KK3e4ce46d72c6bebe803d53be3e48947c

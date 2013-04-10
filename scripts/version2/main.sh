cd "$(dirname "$0")"
echo "Installing dependencies..."
sh ./install_dependencies.sh
cd "$(dirname "$0")"
echo "Creating databases..."
sh ./create_databases.sh
cd "$(dirname "$0")"
echo "Migrating Jobs..."
sh ./migrate_jobs.sh

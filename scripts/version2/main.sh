cd "$(dirname "$0")"
echo "Migrating Jobs..."
sh ./migrate_jobs.sh
cd "$(dirname "$0")"
echo "Installing dependencies..."
sh ./install_dependencies.sh
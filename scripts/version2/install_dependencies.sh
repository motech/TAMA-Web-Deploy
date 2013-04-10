#Vars
PWD=/tmp/install

#cwd
rm -rf $PWD
mkdir $PWD

#Copy resources
cp ./configuration.pp $PWD

#Move in
cd $PWD

echo "Fetching resources..."
wget https://raw.github.com/motech/motech-scm/master/bootstrap.sh

echo "Installing..."
sudo sh ./bootstrap.sh -c configuration.pp

echo "Starting postgres..."
sudo service postgresql start

echo "Cleaning up..."
rm -rf PWD
echo "Done."
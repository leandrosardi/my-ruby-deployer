# this routine install 
BlackStack::Deployer::add_routine({
  :name => 'install-cockroachdb',
  :commands => [
    { 
        :sudo => true,
        :command => '
cd ~; 
sudo mv /usr/local/bin/cockroach /usr/local/bin/cockroach.back.%timestamp%;
sudo mv cockroach-v21.2.10.linux-amd64 cockroach-v21.2.10.linux-amd64.back.%timestamp%;
curl https://binaries.cockroachdb.com/cockroach-v21.2.10.linux-amd64.tgz | tar -xz && sudo cp -i cockroach-v21.2.10.linux-amd64/cockroach /usr/local/bin/;
sudo mv /usr/local/lib/cockroach /usr/local/lib/cockroach.back.%timestamp%;
mkdir /usr/local/lib/cockroach;
yes | sudo cp -i cockroach-v21.2.10.linux-amd64/lib/libgeos.so /usr/local/lib/cockroach/;
yes | sudo cp -i cockroach-v21.2.10.linux-amd64/lib/libgeos_c.so /usr/local/lib/cockroach/;
sudo mv certs certs.back.%timestamp%;
sudo mv my-safe-directory my-safe-directory.back.%timestamp%;
sudo mkdir certs;
sudo mkdir my-safe-directory;
sudo cockroach cert create-ca --certs-dir=certs --ca-key=my-safe-directory/ca.key;
sudo cockroach cert create-node localhost %eth0_ip% $(hostname) --certs-dir certs --ca-key my-safe-directory/ca.key;
sudo cockroach cert create-client root --certs-dir=certs --ca-key=my-safe-directory/ca.key;
sudo cockroach start --certs-dir=certs --store=%name% --listen-addr=%eth0_ip%:%db_port% --http-addr=%eth0_ip%:%dashboard_port% --join=%eth0_ip%:%db_port% --background --max-sql-memory=.25 --cache=.25;
sudo cockroach init --host=%eth0_ip%:%db_port% --certs-dir=certs;
        ',
        :matches => /Cluster successfully initialized/
    }, {
    # TODO: connect the cockroach cluster, create database and user and grants.
    #cd ~;cockroach sql --host 34.203.199.68 --certs-dir certs -e "CREATE USER IF NOT EXISTS %ssh_username% WITH PASSWORD 'bsws2022';"
  ],
});
# setup deploying rutines
BlackStack::Deployer::add_routine({
  :name => 'install-cockroach-cluster',
  :commands => [
    { 
        :sudo => false,
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
        :command => "cockroach sql --host %eth0_ip%:%db_port% --certs-dir certs -e \"CREATE USER blackstack WITH PASSWORD 'bsws2022';\"",
        :matches => /CREATE ROLE/
    }, {
        :command => "cockroach sql --host %eth0_ip%:%db_port% --certs-dir certs -e \"CREATE DATABASE blackstack
WITH
--OWNER = blackstack
ENCODING = 'UTF8'
--LC_COLLATE = 'Spanish_Argentina.1252'
--LC_CTYPE = 'Spanish_Argentina.1252'
--TABLESPACE = pg_default
CONNECTION LIMIT = -1;\"",
        :matches => /CREATE DATABASE/
    }, {
        :command => "cockroach sql --host %eth0_ip%:%db_port% --certs-dir certs -e \"GRANT ALL ON DATABASE blackstack TO blackstack;\"",
        :matches => /GRANT/
    }, {
        :command => "cockroach sql --host %eth0_ip%:%db_port% --certs-dir certs -e \"SHOW GRANTS ON DATABASE blackstack;\"",
        :matches => /database_name\.*|\.*grantee\.*|\.*privilege_type/
    }


    # TODO: connect the cockroach cluster, create database and user and grants.
    #cd ~;cockroach sql --host 34.203.199.68 --certs-dir certs -e "CREATE USER IF NOT EXISTS %ssh_username% WITH PASSWORD 'bsws2022';"
  ],
});

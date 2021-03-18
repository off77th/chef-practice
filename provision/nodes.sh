#!/usr/bin/env bash

wget -P /tmp https://packages.chef.io/files/stable/chef/16.10.17/ubuntu/18.04/chef_16.10.17-1_amd64.deb
dpkg -i /tmp/chef_16.10.17-1_amd64.deb

mkdir /etc/chef
# Company .pem key MOVE to client to connect to chef-server
cp mycompany.pem /etc/chef/validator.pem
#touch first_boot.json
echo '{
    "run_list" :[
        "role[base]"
    ]
}' > first_boot.json

echo 'log_level :info
log_location STDOUT
ssl_verify_mode :verify_none
verify_api_cert false
chef_server_url "https://10.0.10.10/organizations/mycompany"
validation_client_name "mycompany-validator"
validation_key "/etc/chef/validator.pem"
node_name "TestNode1"
'
curl -L https://omnitruck.chef.io/install.sh | sudo bash
sudo chef-client -j /etc/chef/first_boot.json
rm /etc/chef/valodator.pem


# configuring host file
cat >> /etc/hosts <<EOL
# vagrant environment nodes
10.0.10.10  chef-server
10.0.10.21  web1
10.0.10.22  web2
EOL
#!/usr/bin/env bash

apt-get update -y -qq > /dev/null
apt-get upgrade -y -qq > /dev/null
apt-get -y -q install linux-headers-$(uname -r) build-essential > /dev/null

wget -P /tmp https://packages.chef.io/files/stable/chef-server/14.1.0/ubuntu/18.04/chef-server-core_14.1.0-1_amd64.deb
dpkg -i /tmp/chef-server-core_14.1.0-1_amd64.deb

#chown -R vagrant:vagrant /home/vagrant
mkdir /home/vagrant/certs

chef-server-ctl reconfigure
printf "\033c"
chef-server-ctl user-create chefadmin Chef Admin chefadmin@example.com 'password' --filename /home/vagrant/certs/chefadmin.pem
chef-server-ctl org-create mycompany "My Company" --association_user chefadmin --filename /home/vagrant/certs/mycompany.pem
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license


# configuring host file
cat >> /etc/hosts <<EOL
# vagrant environment nodes
10.0.10.10  chef-server
10.0.10.21  web1
10.0.10.22  web2
EOL

printf "\033c"
echo "Chef Console is ready: http://chef-server with login: chefadmin password: password"


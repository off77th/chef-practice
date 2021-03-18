# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  
  config.vm.define :chef_server do |chef_server_config|
    chef_server_config.vm.box = "bento/ubuntu-18.04"
    chef_server_config.vm.hostname = "chef-server"
    chef_server_config.vm.network :private_network, ip: "10.0.10.10"
    chef_server_config.vm.network "forwarded_port", guest: 80, host: 8080
    chef_server_config.vm.provider "virtualbox" do |vb|
      vb.memory = "4096"
    end
    chef_server_config.vm.provision :shell, path: "provision/bootstrap-chef-server.sh"
  end


  (1..2).each do |i|
    config.vm.define "node#{i}" do |node|
      node.vm.hostname="node#{i}"
      node.vm.box = "bento/ubuntu-18.04"
      node.vm.network :private_network, ip:"10.0.10.2#{i}"
      node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
      node.vm.provision :shell, path: "provision/nodes.sh"
    end
  end
  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.33.10"
end

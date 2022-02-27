# -*- mode: ruby -*-
# vi: set ft=ruby :

# Install vagrant-disksize to allow resizing the vagrant box disk.
unless Vagrant.has_plugin?("vagrant-disksize")
    raise  Vagrant::Errors::VagrantError.new, "vagrant-disksize plugin is missing. Please install it using 'vagrant plugin install vagrant-disksize' and rerun 'vagrant up'"
end

$setup_script = <<SCRIPT
  sudo apt update
  sudp apt upgrade -y
  sudo apt install -y jq rename curl git tmux
  git clone https://github.com/tezos-israel/rpi.git /home/vagrant/setup-rpi
  mkdir /home/vagrant/setup-rpi/out
  touch /home/vagrant/setup-rpi/out/step1
  sudo chown -R vagrant:vagrant /home/vagrant/setup-rpi
SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"

  config.vm.provider "virtualbox" do |vb|
    # Customize the amount of memory on the VM:
    vb.memory = "16384"
  end

  config.vm.provision "shell", inline: $setup_script

  config.disksize.size = '20GB'
end

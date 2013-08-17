# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  # I used a 32 bit box definition because my processor doesn't have VT-x capabilities
  config.vm.box = "precise32"
  # This should all work for a 64 bit vm just by changing the 32 above and below to 64
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"
  config.vm.hostname = "jenkins-vagrant.jdydev.com"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision :shell do |shell|
    shell.inline = "if [ ! -d '/etc/puppet/modules' ]; then
                      mkdir -p /etc/puppet/modules;
                      puppet module install puppetlabs/apache;
                    fi;
                    ip addr show | grep 'inet ' | sed -e 's/.*inet //' -e 's#/.*##' | grep -v 127.0.0.1"
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "setup.pp"
  end
end

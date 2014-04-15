# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  RUNDECK_IP="192.168.50.4"
  HOST1_IP="192.168.50.5"

  #deb_repo_url="http://dl.bintray.com/gschueler/rundeck-ci-snapshot-deb"
  deb_repo_url="http://dl.bintray.com/rundeck/rundeck-deb"


  config.vm.define :rundeck do |rundeck|
    rundeck.vm.box = "precise64"
    rundeck.vm.box_url = "http://files.vagrantup.com/precise64.box"
    rundeck.vm.hostname = "rundeck"
    rundeck.vm.network :private_network, ip: "#{RUNDECK_IP}"
    rundeck.vm.network :forwarded_port, guest: 4440, host: 4440
    rundeck.vm.provision :shell, :path => "install-rundeck.sh", :args => deb_repo_url
    rundeck.vm.provision :shell, :path => "add-project.sh"
  end
  config.vm.define :host1 do |host1|
    host1.vm.box = "CentOS-6.3-x86_64-minimal"
    host1.vm.hostname = "host1"
    host1.vm.network :private_network, ip: "#{HOST1_IP}"
    host1.vm.provision :shell, :inline => "yum -y install words"
    host1.vm.provision :shell, :path => "provision/copy-key.sh", :args => "/vagrant/provision/id_rsa.pub"
  end


end

# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

	#================#
  # Ansible Server #
  #================#
  
  config.vm.define "ansible-server" do |cfg|
    cfg.vm.box = "centos/7"
 	cfg.vm.provider "virtualbox" do |vb|
	  vb.name = "Ansible-Server"
	end
	cfg.vm.host_name = "ansible-server"
	cfg.vm.network "private_network", ip: "192.168.56.10"
	cfg.vm.network "forwarded_port", guest: 22, host: 60010, auto_correct: true, id: "ssh"
	cfg.vm.synced_folder "../data", "/vagrant", disabled: true
  end
end
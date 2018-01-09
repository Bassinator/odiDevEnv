# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "ol74"
  config.vm.hostname = 'odiDevEnv'
  config.vm.synced_folder "~/Downloads", "/vagrant_downloads/"

  config.vm.provision "ansible_local" do |ansible|
    ansible.verbose = "vvv"
    ansible.playbook = "devEnv.yml"
  end
end

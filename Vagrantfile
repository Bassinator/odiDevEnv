# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  class Username
    def to_s
      print "Virtual machine needs you ex or hk Helsana user and password.\n"
      print "Username: "
      STDIN.gets.chomp
    end
  end

  class Password
    def to_s
      begin
      system 'stty -echo'
      print "Password: "
      pass = URI.escape(STDIN.gets.chomp)
      ensure
      system 'stty echo'
      end
      pass
    end
  end


  config.vm.box = "ol74"

  #following fixes a bug see https://github.com/hashicorp/vagrant/issues/7648
  config.vm.provider 'virtualbox' do |vb|
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
  end
  #config.vm.hostname = 'odiDevEnv'
  #config.vm.network "public_network", ip: "192.168.1.4"
  #config.vm.network "private_network", ip: "192.168.50.4",
  #  virtualbox__intnet: true
  #config.vm.synced_folder "~/Downloads", "/vagrant_downloads/"
  #config.vm.synced_folder "C:\\Users\\EX3NS\\Downloads", "/vagrant_downloads/"
  config.vm.synced_folder 'U:\Team\ICC\8 Work\64-bit\VirtualBox', "/media/Virtualbox"
  config.vm.synced_folder 'U:\Team\ICC\8 Work\DPF Upgrade\12.2.1', "/media/sf_DPF_Upgrade/12.2.1"

  #TODO: replace with ruby see: https://github.com/hashicorp/vagrant/issues/2662
  #config.vm.provision "shell" , path: "script.sh", :args => [Username.new, Password.new]
  #config.vm.provision "shell" , path: "script.sh", env: {"USERNAME" => Username.new, "PASSWORD" => Password.new}
  config.vm.provision "shell" , path: "script.sh", env: {"USERNAME" =>"ex3ns", "PASSWORD" => "ma3xi3Ap"}

  config.vm.provision "ansible_local" do |ansible1|
    ansible1.verbose = "vvv"
    ansible1.playbook = "baseSetup.yml"
  end

  config.vm.provision "ansible_local" do |ansible2|
    ansible2.verbose = "vvv"
    ansible2.playbook = "devEnv.yml"
  end
end

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

  config.vm.provider 'virtualbox' do |vb|
    vb.name = "SPF Development VM"
    user_account = ENV['USERNAME']

    # following fixes a bug see https://github.com/hashicorp/vagrant/issues/7648v.gui = true
    vb.customize ['modifyvm', :id, '--cableconnected1', 'on']
    vb.memory = 8192
    vb.customize ['modifyvm', :id, '--accelerate3d', 'on']
    # 3d acceleration only works if started with gui. Needed vor ODI
    vb.gui = true
    vb.cpus = 4
    vb.customize ['modifyvm', :id, '--vram', '64']
    vb.customize ['modifyvm', :id, '--clipboard', 'bidirectional']

    new_second_disk = 'C:\Users\\' + user_account + '\VirtualBox VMs\\' + vb.name + '\OL7U4_x86_64-ora.vmdk'
    old_second_disk = 'C:\Users\\' + user_account + '\VirtualBox VMs\\' + vb.name + '\OL7U4_x86_64-disk2.vmdk'
    vb.customize ['storageattach', :id, '--storagectl', 'IDE Controller', '--port', 0, '--device', 0, '--type', 'dvddrive', '--medium', 'C:\Program Files\Oracle\VirtualBox\VBoxGuestAdditions.iso']



    unless File.exist?(new_second_disk)
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', 'none']
      vb.customize ['closemedium', 'disk', old_second_disk, '--delete']
      vb.customize ['createhd', '--filename', new_second_disk, '--format', 'VMDK','--size', 40 * 1024]
      vb.customize ['storageattach', :id, '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium',  new_second_disk]
    end
  end

  config.vm.synced_folder 'U:\Team\ICC\8 Work\64-bit\VirtualBox', "/media/Virtualbox"
  config.vm.synced_folder 'U:\Team\ICC\8 Work\DPF Upgrade\12.2.1', "/media/sf_DPF_Upgrade/12.2.1"

  # ask account, if hashed secrets not yet stored on disk
  unless File.exist?('.secrets')
    username=Username.new();
    password=Password.new();
  end

  config.vm.provision "shell" , path: "script.sh", env: {"USERNAME" =>username, "PASSWORD" => password}

  config.vm.provision "ansible_local" do |ansible1|
    ansible1.verbose = "v"
    ansible1.playbook = "env.yml"
    ansible1.install = true
  end

  config.vm.provision "ansible_local" do |ansible2|
    ansible2.verbose = "v"
    ansible2.playbook = "client.yml"
    ansible2.install = true
  end

  config.vm.provision "shell", privileged: false, inline: <<-EOF
    if [ -f /vagrant/.end_play ]; then
      echo "====================================";
      echo "Vagrant Box updated. REBOOT required";
      echo "  type: vagrant reload --provision  ";
      echo "to finish provisioning process      ";
      echo "====================================";
    else
      echo "Vagrant Box provisioned!"
    fi
  EOF


end

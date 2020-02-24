# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
  config.vm.box = "ubuntu/bionic64" 
  config.vm.define "router1" do |router1|
    router1.vm.host_name = "router1"
    router1.vm.network "private_network",
                         ip: "10.10.10.11",
                         virtualbox__intnet: "router1-to-n9kv"
    router1.vm.network "private_network",
                         ip: "1.1.1.1",
                         virtualbox__intnet: "Network to Advertise"
    router1.vm.provision "ansible" do |ansible|
      ansible.playbook = "router1.yml"
      ansible.extra_vars = { ansible_python_interpreter:"/usr/bin/python3" }

    end
  end

  config.vm.define "tick" do |tick|
    tick.vm.host_name = "tick"
    tick.vm.network "private_network",
                        ip: "30.30.30.11",
                        virtualbox__intnet: "tick-to-n9kv"
    tick.vm.network "private_network",
                         ip: "2.2.2.2",
                         virtualbox__intnet: "Network to Advertise"
    tick.vm.provision "ansible" do |ansible|
      ansible.playbook = "tick.yml"
      #ansible.verbose = true
      ansible.extra_vars = { ansible_python_interpreter:"/usr/bin/python3" }
    end
  end

  config.vm.define "n9kv1" do |n9kv1|

        n9kv1.vm.box = "9.3.3"

        n9kv1.ssh.insert_key = false
        n9kv1.vm.boot_timeout = 600
        n9kv1.ssh.shell = "run bash"

        if Vagrant.has_plugin?("vagrant-vbguest")
          config.vbguest.auto_update = false
        end

        config.vm.synced_folder ".", "/vagrant", disabled: true
        config.vm.box_check_update = false
        n9kv1.vm.provision "ansible" do |ansible|
          #ansible.become = true
          #ansible.verbose = true
          #ansible.gather_facts = false
          #ansible.become_user = "root"
          ansible.playbook = "n9kv1.yml"
          ansible.compatibility_mode = "2.0"
        end
        #n9kv1.vm.synced_folder './certs', '/bootflash/home/vagrant/certs'
        #n9kv1.vm.network :forwarded_port, guest: 80, host: 10001
        n9kv1.vm.network :forwarded_port, guest: 22, host: 2022
        n9kv1.vm.network :forwarded_port, guest: 50051, host: 50051
        n9kv1.vm.network :forwarded_port, guest: 80, host: 80
        n9kv1.vm.network :forwarded_port, guest: 443, host: 443


        n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "router1-to-n9kv"

        n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "bird2-to-n9kv"

        n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "tick-to-n9kv"

        #n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "nxosv_network4"

        #n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "nxosv_network5"

        #n9kv1.vm.network "private_network", auto_config: false, virtualbox__intnet: "nxosv_network6"

        #n9kv.vm.network "private_network", auto_config: false, virtualbox__intnet: "nxosv_network7"

        n9kv1.vm.provider :virtualbox do |vb|

                vb.customize [ "guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000 ]
                vb.customize ['modifyvm',:id,'--nicpromisc2','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc3','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc4','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc5','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc6','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc7','allow-all']
                vb.customize ['modifyvm',:id,'--nicpromisc8','allow-all']

        end
      end
        
end
Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.provider 'virtualbox' do |virtualbox|
    virtualbox.name = "jekyll"
    virtualbox.cpus = 1
    virtualbox.memory = 2048
  end
  config.vm.provider 'hyperv' do |hyperv|
    hyperv.vmname = "jekyll"
    hyperv.cpus = 1
    hyperv.memory = 2048
  end
  config.vm.network "public_network"
  config.vm.provision :shell, path: "vagrant.provision.sh", privileged: false
end

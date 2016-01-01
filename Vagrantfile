Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise32"
  config.vm.provider 'virtualbox' do |virtualbox|
    virtualbox.name = "jekyll"
    virtualbox.cpus = 1
    virtualbox.memory = 2048
  end
  config.vm.provision :shell, path: "vagrant.provision.sh", privileged: false
end

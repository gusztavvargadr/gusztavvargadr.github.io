Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.provider 'virtualbox' do |vb|
    vb.cpus = 2
    vb.memory = 2048
  end

  config.vm.network 'forwarded_port', guest: 4000, host: 4000

  config.vm.provision 'shell', path: 'vagrant.provision.sh', privileged: false
end

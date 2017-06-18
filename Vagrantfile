Vagrant.configure(2) do |config|
  config.vm.box = 'johnpbloch/trusty64'

  config.vm.network 'public_network', bridge: ENV['VAGRANT_NETWORK_BRIDGE']

  config.vm.provider 'hyperv' do |hyperv, override|
    hyperv.memory = 1024
    hyperv.cpus = 1
    hyperv.differencing_disk = true

    override.vm.synced_folder '.', '/vagrant', smb_username: ENV['VAGRANT_SMB_USERNAME'], smb_password: ENV['VAGRANT_SMB_PASSWORD']
  end

  config.vm.provision 'shell', path: 'vagrant.provision.sh', privileged: false
end

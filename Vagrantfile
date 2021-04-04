# -*- mode: ruby -*-
# vi: set ft=ruby :

# Check for missing plugins
required_plugins = %w(vagrant-hostmanager)
plugin_installed = false
required_plugins.each do |plugin|
  unless Vagrant.has_plugin?(plugin)
    system "vagrant plugin install #{plugin}"
    plugin_installed = true
  end
end

# If new plugins installed, restart Vagrant process
if plugin_installed === true
  exec "vagrant #{ARGV.join' '}"
end

### configuration parameters ###

# Vagrant variables
VAGRANTFILE_API_VERSION = "2"

# virtual machines to create
servers = [
  {
    :hostname => "envoy-sandbox",
    :ip => "192.168.77.200",
    :ram => 8192,
    :cpus => 4,
    :box => "bento/ubuntu-20.04"
  }
]

### main ###

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # vagrant-hostmanager options
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = false

  # Forward ssh agent to easily ssh into the different machines
  config.ssh.forward_agent = true

  # create servers
  servers.each do |server|
    config.vm.define server[:hostname] do |config|
      # vm definitions
      config.vm.hostname = server[:hostname]
      config.vm.box = server[:box]
      config.vm.network :private_network, ip: server[:ip]

      memory = server[:ram]
      cpus = server[:cpus]

      # providers
      config.vm.provider :virtualbox do |vb|
        vb.customize [
          "modifyvm", :id,
          "--memory", memory.to_s,
          "--cpus", cpus.to_s,
          "--ioapic", "on",
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on"
        ]
      end

      # provisioners

      # Install Docker
      config.vm.provision :docker
    
      # Install requirements
      config.vm.provision "prereqs", type: "shell", run: "always" do |m|
        m.path = "scripts/prereqs.sh"
      end

    end
  end
end

hosts = {
  "dev" => "192.168.1.50",
  "pre" => "192.168.1.51"
}

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/vivid64"
  config.ssh.insert_key = false
  hosts.each do |name, ip|
    config.vm.define name do |vm|
      vm.vm.hostname = "%s" % name
      # vm.vm.network "private_network", ip: ip
      vm.vm.network "public_network", bridge: "en0: Wi-Fi (AirPort)", ip: ip
      vm.vm.provider "virtualbox" do |v|
        v.name = name
      end
      vm.vm.provision "shell", path: "provisioning.sh"
    end
  end
end

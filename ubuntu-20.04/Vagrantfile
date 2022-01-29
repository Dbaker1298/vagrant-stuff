Vagrant.configure("2") do |config|
  # This will be applied to every vagrant file that comes after it
  config.vm.box = "ubuntu/bionic64"
  # K8s Control Plane
  ## Master Node
  config.vm.define "master" do |k8s_master|
    k8s_master.vm.provision "shell", path: "node_script.sh"
    k8s_master.vm.network "private_network", ip: "192.168.56.4" 
    k8s_master.vm.hostname = "master"
    k8s_master.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--audio", "none"]
      v.memory = 4024
      v.cpus = 2
    end
  end
end

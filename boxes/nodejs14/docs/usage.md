# Usage instructions

1.  **Create a configuration file for Vagrant**

    In your project root directory, create a file named `Vagrantfile` with the following contents.

    ```ruby
    # -*- mode: ruby -*-
    # vi: set ft=ruby :

    # ------------------------------------------------------------------------------
    # Vagrant configuration file.
    #
    # The most common configuration options are documented in inline comments below.
    # @see //docs.vagrantup.com/
    # ------------------------------------------------------------------------------

    # Specify the minimum Vagrant version required.
    Vagrant.require_version ">= 2.2.0"

    # This file is compatible with version 2
    # of the Vagrantfile standard.
    VAGRANTFILE_API_VERSION = "2"

    Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

      # Base box.
      config.vm.box = "kieranpotts/nodejs14"

      # Optionally, constrain updates of the base box to a specific major
      # version number.
      config.vm.box_version = ">= 1.0, < 2.0"

      # Keep the base box up-to-date automatically? If you disable this, the 
      # base box will be updated only when you run `vagrant box outdated`.
      config.vm.box_check_update = true

      # VirtualBox-specific settings.
      config.vm.provider "virtualbox" do |vb|

        # Run the VM in headless or GUI mode?
        vb.gui = false

        # A unique name to identify the guest machine from VirtualBox's GUI.
        vb.name = "my-devbox"

        # Allocate CPU cores and memory.
        vb.customize ["modifyvm", :id, "--cpus", 1]
        vb.customize ["modifyvm", :id, "--memory", 1024]

        # Stop Vagrant from hanging when using private keys for SSH auth.
        # @see //github.com/hashicorp/vagrant/issues/8157#issuecomment-304492943
        vb.customize ["modifyvm", :id, "--cableconnected1", "on"]

        # By default, Virtualbox doesn't allow symlinks on shared folders (for
        # security reasons). But installers for Node commonly create bin
        # symlinks. Windows users must also boot the VM from a terminal
        # "running as Administrator" for this to work.
        vb.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate//v-root", "1"]

        # Set the timesync threshold to 10 seconds, instead of the default 20
        # minutes. This ensures that the VM's clock is kept closely synced with
        # the host machine's time (it can get out of sync if the laptop goes to
        # sleep, for instance).
        vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

      end

      # There is no need to generate a unique keypair for SSH
      # if the VM will be accessed locally only.
      config.ssh.insert_key = false

      # Allocate a local private network IP address to the VM. You can use the
      # following IP ranges:
      # - 10.0.0.1 ... 10.255.255.254
      # - 172.16.0.1 ... 172.31.255.254
      # - 192.168.0.1 ... 192.168.255.254
      config.vm.network :private_network, :ip => "192.168.50.10"

      # Stop Vagrant from hanging when using private keys for SSH auth.
      # @see //github.com/hashicorp/vagrant/issues/8157#issuecomment-301292017
      config.vm.network :forwarded_port, :guest => 22, :host => 2222, :host_ip => "127.0.0.1", :id => 'ssh'

      # Port forwarding for Nginx.
      config.vm.network :forwarded_port, :guest => 80, :host => 80
      config.vm.network :forwarded_port, :guest => 443, :host => 443

      # Port forwarding for MailDev.
      config.vm.network :forwarded_port, :guest => 1025, :host => 1025 # SMTP port to catch emails
      config.vm.network :forwarded_port, :guest => 1080, :host => 1080 # Web interface

      # Port forwarding for Node.js Inspector.
      config.vm.network :forwarded_port, :guest => 9229, :host => 9229

      # Port forwarding for MongoDB.
      config.vm.network :forwarded_port, :guest => 27017, :host => 27017

      # Port forwarding for MariaDB.
      config.vm.network "forwarded_port", :guest => 3306, :host => 3306

      # Disable the default `/vagrant` directory share...
      config.vm.synced_folder ".", "/vagrant", :disabled => true

      # ... instead, map this project's root directory on the host machine to
      # `/home/vagrant/synced` inside the guest VM.
      config.vm.synced_folder ".", "/home/vagrant/synced",
        :create => true,
        :group => "vagrant", :owner => "vagrant",
        :mount_options => ["dmode=777", "fmode=666"],
        :type => "rsync"

      # Fix tty warnings while provisioning Ubuntu.
      # @see //foo-o-rama.com/vagrant--stdin-is-not-a-tty--fix.html
      config.vm.provision "fix-no-tty", type: "shell" do |script|
        script.privileged = false
        script.inline = "sudo sed -i '/tty/!s/mesg n/tty -s \\&\\& mesg n/' /root/.profile"
      end

      # Provision the server by installing system-level requirements.
      # The path to the provisioning script is local and relative to `Vagrantfile`.
      # Use `vagrant up --no-provision` to skip this.
      if File.exist?("./boot/provision.sh")
        config.vm.provision :shell, :path => "./boot/provision.sh",
          :privileged => false,
          :run => "always",
          :args => ["/home/vagrant/synced"]
      end

      # Run the startup script every time the VM is started.
      # This can be used for starting application and services.
      if File.exist?("./boot/startup.sh")
        config.vm.provision :shell, :path => "./boot/startup.sh",
          :privileged => false,
          :run => "always",
          :args => ["/home/vagrant/synced"]
      end

    end
    ```

    Make edits to your Vagrant configuration file as necessary. You should set `vb.name` to a unique string value, which will be used by VirtualBox as an identifier for the VM instance. Alternatively, you can delete this setting and VirtualBox will generate a random identifier.

2.  **Create provisioning and startup script.**

    Create a directory called `boot` containing two files, `provision.sh` and `startup.sh`. The filesystem for your project should now look like this:

    ```txt
    .
    ├─ boot
    │  ├─ provision.sh
    │  └─ startup.sh
    └─ Vagrantfile
    ```

    Add the following contents to both of the shell scripts in the `boot` directory.

    ```sh
    #!/bin/bash

    # Capture input arguments.
    # $1 = Absolute path to the directory in the guest VM that is mounted
    #      from an directory on the host machine.
    synced_dir=$1

    # Path to the `boot` directory. This is used to create absolute paths
    # for all `source` commands, allowing the provisioning script to be
    # run from any location in the VM.
    boot_dir="${synced_dir}/boot"
    ```

    The `./boot/provision.sh` and `./boot/startup.sh` scripts will be run whenever your devbox is provisioned and started-up respectively. Use the `provision.sh` script to install additional software that is required for the application you're developing, and use `startup.sh` to automatically build and run your application when the VM is started.

    The Bash scripts are run without elevated privileges (`script.privileged = false` in the `Vagrantfile`), which means that any commands that require elevated privileges must be prefixed `sudo`.

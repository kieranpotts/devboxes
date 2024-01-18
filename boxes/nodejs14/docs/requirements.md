# Requirements

This devbox requires **[Vagrant](//www.vagrantup.com/) ^2.2.0** and **[VirtualBox](//www.virtualbox.org/) ^6.1.0** to be installed on your computer. (Older versions of VirtualBox may work fine, but have not been tested.)

We've experienced problems with the [vagrant-vbguest](//github.com/dotless-de/vagrant-vbguest) plugin, which automatically installs [VirtualBox Guest Additions](//www.virtualbox.org/manual/ch04.html) inside every virtual machine. You may need to uninstall it.

```sh
$ vagrant plugin uninstall vagrant-vbguest
```

If you're using Windows, you may need to enable hardware virtualization, which usually needs to be done via your BIOS.

You may also need to disable Hyper-V via Windows Features. Note that Hyper-V is used by Docker, so you may need to toggle Hyper-V on and off as you switch between Docker and VirtualBox environments.

```txt
bcdedit /set hypervisorlaunchtype on
bcdedit /set hypervisorlaunchtype off
```

Restart your operating system after completing these steps.

# Requirements

To build new devboxes from the source code in this repository, you'll need the following software installed on your computer:

- Vagrant ^2.2.0
- VirtualBox ^6.1.0

The following Vagrant plugin, which automatically installs [VirtualBox Guest Additions](//www.virtualbox.org/manual/ch04.html) inside every virtual machine, causes problems. Make sure it is uninstalled from your Vagrant instance.

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

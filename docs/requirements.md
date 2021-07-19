# Requirements

To build new devboxes from the source code in this repository, you'll need the following software installed on your computer:

- Vagrant ^2.2.0
- VirtualBox ^5.2.0

> ℹ We've had some problems with Guest Additions breaking synced folders when using VirtualBox 6.0. For this reason, we support only v5.2 of VirtualBox at this time. @see https://stackoverflow.com/questions/42074246/

If you're using Windows, you may need to enable hardware virtualization, which usually needs to be done via your BIOS. You may also need to **disable** Hyper-V via Windows Features. Note that Hyper-V is used by Docker, so you may often need to toggle Hyper-V on and off, which you can do with the following commands:

```txt
bcdedit /set hypervisorlaunchtype on
bcdedit /set hypervisorlaunchtype off
```

# Troubleshooting

You might need to install the following plugin for Vagrant, which will automatically install [VirtualBox Guest Additions](https://www.virtualbox.org/manual/ch04.html) in each virtual machine you build:

```sh
$ vagrant plugin install vagrant-vbguest
```

If you get errors about a mismatch between the installed version of Guest Additions between host and guest, run the following command to force-install consistent versions:

```sh
vagrant vbguest --do install
```

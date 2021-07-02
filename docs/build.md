# Build

Follow these instruction to build a new version of one of the devboxes.

Change to the `boxes` directory.

```sh
$ cd boxes
```

List the contents of the directory.

```sh
$ ls -la
```

Each sub-directory encapsulates the provisioning and test scripts for a single Vagrant box. Change to the sub-directory for the box you want to rebuild. Example:

```sh
$ cd php70
```

Change to the box's `src` directory.

```sh
$ cd src
```

Destroy any previous builds of this box that may still exist on your local filesystem.

```sh
$ vagrant destroy --force
```

To be sure, delete the `.vagrant` directory, too.

```sh
$ rm -rf .vagrant
```

Run the following command to update the base base (eg `bento/ubuntu-18.04`) from which the local development box is extended.

```sh
$ vagrant box update
```

Rebuild the box from scratch.

```sh
$ vagrant up --provision
```

When the provisioning script is complete, SSH into the box and checking it is configured as expected.

```sh
$ vagrant ssh
```

If there are any problems, adjust the provisioning scripts and start the process over from step one. If everything is OK, exit the VM.

```sh
$ exit
```

Delete all the contents of the `dist` directory, if it exists. Then repackage the VM as a shareable box file. Change `[name]` to the box name, eg "php70".

```sh
$ rm -rf ../dist
$ vagrant package --output ../dist/[name].box
```

Vagrant will power down the VM in order to package it. The packaging process takes several minutes.

Proceed to [testing](./test.md) the new box before [deploying](./deploy.md) it.

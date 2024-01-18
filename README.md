# Devboxes

> **This project is no longer maintained.**

This is a monorepo that encapsulates the source code for several Vagrant-provisioned local development environments for various software stacks. These development environments are packaged as Vagrant boxes and distributed publicly via the [Vagrant Cloud](//app.vagrantup.com/kieranpotts/) box registry.

Most Vagrant boxes are naked operating systems intended to form a "bare metal" baseline for provisioning with system and application software. But these "devboxes" are fully-provisioned web servers for various server-side software stacks.

All these devboxes are compatible only with [VirtualBox](//www.virtualbox.org/). They are not designed for use with other virtualization solutions such as VMWare, Hyper-V or Docker. VirtualBox is a free, cross-platform virtualization application that is actively developed by Oracle.

## Documentation

The following documentation is for maintainers of this project. For installation and usage instructions for the devboxes, see the release notes in the box repositories on [Vagrant Cloud](//app.vagrantup.com/kieranpotts/).

- [Requirements](./docs/requirements.md)
- [Build](./docs/build.md)
- [Test](./docs/test.md)
- [Deploy](./docs/deploy.md)
- [Versioning](./docs/versioning.md)

---

Copyright © 2021 Kieran Potts \
[MIT License](./LICENSE.txt)

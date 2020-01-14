# Versioning

Any upgrade of any major component of a box's software stack — for example, upgrading to a newer LTS release of Ubuntu or Node.js, but excluding the upgrade of development tools — is marked by a **major version bump** for the box.

Version numbers are kept synchronised between the Git source code repository and the build artefacts that are distributed via Vagrant Cloud.

Dependent projects can constrain themselves to a single major version of a box. For example, to use only the latest version of v1, but not v2 or higher, the following configuration can be included in the `Vagrantfile`:

```
config.vm.box_version = ">= 1.0, < 2.0"
```

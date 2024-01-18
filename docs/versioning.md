# Versioning

Any upgrade to any major component of a box's software stack — for example, upgrading to a newer LTS release of Ubuntu or Node, but excluding the upgrade of development tools — is marked by a **major version bump**.

Dependent projects can constrain themselves to a single major version of a box. For example, to use only the latest version of v1, but not v2 or higher, the following configuration can be included in the consumer's `Vagrantfile`:

```txt
config.vm.box_version = ">= 1.0, < 2.0"
```

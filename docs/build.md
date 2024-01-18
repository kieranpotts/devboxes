# Build

Follow these instruction to build a new version of one of the devboxes. It is recommended to run these commands in a terminal running under adminsitrator-level privileges.

1.  **Navigate to a box's source directory**

    Change to the boxes directory.

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

    Change to the box's src directory.

    ```sh
    $ cd src
    ```

2.  **Clean-up previous build artifacts**

    Destroy any previous builds of this box that may still exist on your local filesystem.

    ```sh
    $ vagrant destroy --force
    ```

    To be sure, delete the .vagrant directory, too.

    ```sh
    $ rm -rf .vagrant
    ```

3.  **Update the base box**

    Run the following command to update the base base (eg `bento/ubuntu-18.04`) from which the local development box is extended. If the base box has not previously been downloaded to your system, it will be in the next `vagrant up` step.

    ```sh
    $ vagrant box update
    ```

4.  **Rebuild the box from scratch**

    ```sh
    $ vagrant up --provision
    ```

5.  **Test the box**

    When the provisioning script is complete, SSH into the box and check it is configured as expected.

    ```sh
    $ vagrant ssh
    ```

    If there are any problems, adjust the provisioning scripts and start the process over. If everything is OK, exit the VM.

    ```sh
    $ exit
    ```

6.  **Create a distributable package**

    Delete all the contents of the dist directory, if it exists. Then repackage the VM as a shareable box file. Change "[name]" to the box's unique name, eg "php70".

    ```sh
    $ rm -rf ../dist
    $ vagrant package --output ../dist/[name].box
    ```

    Vagrant will power down the VM in order to package it. The packaging process takes several minutes.

Proceed to [testing](./test.md) the new box before [deploying](./deploy.md) it.

# Test

Having [built](./build.md) a new version of one of the devboxes, you should thoroughly test it before [deploying](./deploy.md) the new release to the Vagrant Cloud box registry.

1.  **Import the base box**

    From the box's root directory, ./boxes/[name]/, run the following command. This adds the ".box" file — generated in the [previous step](./build.md) — to your current VM provider (VirtualBox). Use the `--force` flag to update any earlier versions of the box you may have installed previously.

    ```sh
    $ vagrant box add --force kieranpotts/[name] dist/[name].box
    ```

    The result should be:

    ```txt
    Successfully added box 'kieranpotts/[name]' (v0) for 'virtualbox'!
    ```

2.  **Change to the example directory**

    ```sh
    $ cd example
    ```

3.  **Prepare for a clean build**

    Destroy previous builds of the example box.

    ```sh
    $ vagrant destroy --force && rm -rf .vagrant
    ```

4.  **Create an environment configuration**

    Create an environment configuration file, .env, in the boot directory. You can just copy the example configuration file, .env-example.

    ```sh
    $ cp boot/.env-example boot/.env
    ```

    Optionally, you can make custom configuration changes in the .env file, for example to avoid DNS name clashes. This file is exluded from source control.

5.  **Provision the example box**

    From the example directory, re-provision the example box from scratch by running the following command.

    ```sh
    $ vagrant up --provision
    ```

6.  **Hack your local DNS!**

    While the text box is being provisioned, add the following configuration to your local system's hosts file. For iOS and Unix-like systems, the path to the hosts file is /etc/hosts. For Windows it is \Windows\System32\drivers\etc\hosts.

    ```txt
    192.168.50.10 devbox.local
    192.168.50.10 www.devbox.local
    192.168.50.10 mail.devbox.local
    ```

7.  **Test**

    When the provisioning is complete, reload your web browser and browse to the following resource:

    ```txt
    https://devbox.local/
    ```

    You will see a "Connection is Insecure / Untrusted" warning. That's OK. It means that the HTTPS connection is working fine. The reason why you see this message is because the website uses a self-signed certificate rather than one created by a trusted certificate provider. You need to "add an exception", instructing your browser to ignore the security issue and render the website as normal. If you are not able to add an exception because of "HSTS", follow the instructions [in this article](//www.thesslstore.com/blog/clear-hsts-settings-chrome-firefox/).

    The HTTP response message should be similar to the following:

    ```txt
    HTTP/1.1 200 OK
    Content-Type: text/html

    It works!
    ```

    You can also request the example app using the www domain prefix. Example:

    ```txt
    https://www.devbox.local/
    ```

    The plain http:// scheme for the application's main hostname and its alias should redirect to the HTTP Secure Protocol.

    Finally, you can test requests to static content by requesting this URL:

    ```txt
    https://devbox.local/static.html
    ```

8.  **Finish**

    Power down the example box by running the following command from your terminal.

    ```sh
    $ vagrant halt
    ```

If the tests are successfully, you can [deploy](./deploy.md) the new build of the box to Vagrant Cloud.

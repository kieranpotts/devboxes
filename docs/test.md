# Test

Having [built](built.md) a new version of one of the local development boxes, you should throughly test it before [deploying](deploy.md) the new release.

1.  Add the newly-generated `.box` file to your current VM provider (VirtualBox). Append `-test` to the name of the box to distinguish it from the production version. Use the `--force` flag to update any earlier versions of the test box you may have installed previously.

    From the box's root directory, `boxes/[name]`, run this command:

    ```sh
    $ vagrant box add --force kieranpotts/[name]-test dist/[name].box
    ```

    Result:

    ```
    Successfully added box 'kieranpotts/[name]-test' (v0) for 'virtualbox'!
    ```

2.  Test the new box with the test application that is included in the `test` directory.

    ```sh
    $ cd test
    ```

3.  Check that the `vagrant.yaml` in the `test` directory references `kieranpotts/[name]-test`, like this:

    ```
    # The name of the base box.
    box: kieranpotts/[name]-test
    ```

    Destroy previous builds of the test box.

    ```sh
    $ vagrant destroy
    ```

    To be sure, delete the `test/.vagrant` directory, too.

4.  Create an environment configuration file, `.env`, in the `boot` directory.

    You can just copy the example configuration file, `.env-example`:

    ```sh
    $ cp boot/.env-example boot/.env
    ```   

5.  Reprovision the test box from scatch by running the following command from the `test` directory.

    ```sh
    $ vagrant up --provision
    ```

6.  While the text box is provisioned, add the following configuration to your local system's `hosts` file. 

    For iOS and Unix-like systems, the path to the hosts file is `/etc/hosts`. For Windows it is `\Windows\System32\drivers\etc\hosts`.

    ```
    192.168.50.10 test.devbox.local
    192.168.50.10 www.test.devbox.local
    ```

7.  When the provisioning is complete, open a web browser and browse to the following resource:

    ```
    https://test.devbox.local/
    ```

    You will see a "Connection is Insecure / Untrusted" warning. That's OK. It means that the HTTPS connection is working fine. The reason why you see this message is because the website uses a self-signed certificate rather than one created by a trusted certificate provider. You need to "add an exception", instructing your browser to ignore the security issue and render the website as normal. If you are not able to add an exception because of "HSTS", follow the instructions [in this article](https://www.thesslstore.com/blog/clear-hsts-settings-chrome-firefox/).

    The HTTP response message should be similar to the following:

    ```
    HTTP/1.1 200 OK
    Content-Type: text/html

    It works!
    ```

    You can also request the test app using the `www` domain prefix. Example:

    ```
    https://www.test.devbox.local/
    ```

    The plain `http://` scheme for the application's main hostname and its alias should redirect to the HTTP Secure Protocol.

8.  Power down the test box by running the following command from your terminal.

    ```sh
    $ vagrant halt
    ```

If the tests are successfully, optionally you can [deploy](deploy.md) the new build of the box to Vagrant Cloud.

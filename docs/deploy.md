# Deploy

Vagrant boxes are large — occupying several gigabytes of disk space, typically — so they are not committed to the version control repository. Instead, box packages are distributed separately via [Vagrant Cloud](https://app.vagrantup.com/).

1.  Login to Vagrant Cloud.

    Go to https://app.vagrantup.com/kieranpotts/boxes/ and choose the box you want to update.

    Click **New Version**.

2.  Input the new **Version Number**. This must be in the format `[0-9]+[.][0-9]+[.][0-9]+`. Do not include the "v" prefix. Please refer to our [versioning policy](versioning.md) for our Vagrant development boxes.

3.  For the **Desciption**, input a list of major system software and the installed versions. This can be copied from the box's `README`. Example:

    ```
    This box is for server-side web applications requiring the following software stack:

    - PHP v7.0
    - Nginx v1.14
    - MariaDB v10.2
    - Redis v4
    - Sendmail v8

    The following system software is provided:

    - Ubuntu v18.04 LTS
    - Curl
    - OpenSSL
    - `pip` for Python 3
    - `zip` / `unzip`

    The following development tools are also included:

    - Composer
    - Git
    - Htop
    - Ngrok
    - Tmux
    - Vim
    - Xdebug
    ```

    Click **Create version**.

4.  Click **Add a provider**.

    For the **Provider** write `virtualbox`.

    Leave the other input fields to their default values and click **Continue to upload**.

    Select the `[name].box` file from the `dist` directory and start the upload. This will take several minutes depending on your broadband speed.

5.  When the upload is complete, click **Versions** and you should see the new version listed. However, new versions are not automatically released. To release the box — so it can be seen by the `vagrant` CLI client — click **Release...**.

    Confirm the version number and description, and click **Release version**.

6.  Follow the [SrcFlow workflow](https://srcflow.com/) to update the CHANGELOG and tag a new release in the version control repository. Use the same version number as for the Vagrant Cloud distributable.

---

To learn more about the life cycle of boxes distributed via Vagrant Cloud, see https://www.vagrantup.com/docs/vagrant-cloud/boxes/index.html.

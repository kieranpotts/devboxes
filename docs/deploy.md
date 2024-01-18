# Deploy

Vagrant boxes are large — typically occupying several gigabytes of disk space — so they are not committed to the source control repository. Instead, box packages are distributed separately via the [Vagrant Cloud](//app.vagrantup.com/) box registry.

1.  Login to Vagrant Cloud.

2.  Go to //app.vagrantup.com/kieranpotts/. If you want to update an existing box, choose the box and click **New Version**. To upload the first release of a brand new box, go to the **Dashboard** then click **New Vagrant Box**.

3.  Input the new **Version Number**. This must be in the format `[0-9]+[.][0-9]+[.][0-9]+`. Do NOT include the "v" prefix. Please refer to our [versioning policy](./versioning.md).

4.  For the **Desciption**, provide a list of major system software (with major version numbers) that's pre-installed in the box. This information can be copied from the box's README.

5.  Click **Create version**.

6.  Click **Add a provider**. For the **Provider** write `virtualbox`.

7.  Leave the other input fields to their default values and click **Continue to upload**. Select the [name].box file from the dist directory and start the upload. This will take several minutes depending on your broadband speed.

8.  When the upload is complete, click **Versions** and you should see the new version listed. However, new versions are not automatically released. To release the box — so it can be seen by the `vagrant` CLI client — click **Release...**. Confirm the version number and description, and click **Release version**.

[Learn more about the life cycle of boxes](//www.vagrantup.com/docs/vagrant-cloud/boxes/index.html) distributed via Vagrant Cloud.

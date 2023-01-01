# Cloud Shell, VMs, Buckets, Service Accounts

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - Getting Started with Google Kubernetes Engine Course](https://www.cloudskillsboost.google)

## High Level Objectives

- Learn how to access the Cloud Console and Cloud Shell
- Become familiar with the Cloud Console
- Become familiar with Cloud Shell features, including the Cloud Shell code editor
- Use the Cloud Console and Cloud Shell to create buckets and VMs and service accounts
-Perform other commands in Cloud Shell


### Use the Cloud Console and Cloud Shell to create buckets and VMs and service accounts

- Create a bucket with the same name as your project ID. (Choose how to control access to objects and uncheck Enforce public access prevention on this bucket, now select Fine-grained)
- Create a VM `first-vm`. Allow HTTP traffic
- Create an IAM service account `test-service-account`
- On the Grant this service account access to project page, specify the role as `Basic > Editor`.
- Manage keys - Download JSON key

### Explore Cloud Shell

- Use Cloud Shell to set up the environment variables for this task

```bash
MY_BUCKET_NAME_1=[BUCKET_NAME]

MY_BUCKET_NAME_2=[BUCKET_NAME_2]

MY_REGION=us-central1
```

- Move the credentials file you created earlier into Cloud Shell
- Create a second Cloud Storage bucket and verify it in the Cloud Console

```bash
gsutil mb gs://$MY_BUCKET_NAME_2
```

- Use the gcloud command line to create a second virtual machine.
  Select a zone from the first column of the list.

```bash
gcloud compute zones list | grep $MY_REGION
# You replace [ZONE] with your selected zone:
MY_ZONE=[ZONE]

# Set this zone to be your default zone by executing the following command:
gcloud config set compute/zone $MY_ZONE

# Execute the following command to store a name in an environment variable you will use to create a VM. You will call your second VM second-vm:
MY_VMNAME=second-vm

# Create a VM in the default zone that you set earlier in this task using the new environment variable to assign the VM name:
gcloud compute instances create $MY_VMNAME \
--machine-type "e2-standard-2" \
--image-project "debian-cloud" \
--image-family "debian-11" \
--subnet "default"

# List the virtual machine instances in your project:
gcloud compute instances list

# Look at the External IP column. Notice that the external IP address of the first VM you created is shown as a link. The Google Cloud Console offers the link because you configured this VM's firewall to allow HTTP traffic.
```

- Use the gcloud command line to create a second service account
- In Cloud Shell, execute the following command to create a new service account:

```bash
gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"

# In Cloud Shell, execute the following command to grant the second service account the Project viewer role:
gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer

```

### Work with Cloud Storage in Cloud Shell

```bash
# Copy a picture of a cat from a Google-provided Cloud Storage bucket to your Cloud Shell:
gsutil cp gs://cloud-training/ak8s/cat.jpg cat.jpg

# Copy the file into the first buckets that you created earlier:
gsutil cp cat.jpg gs://$MY_BUCKET_NAME_1

# Copy the file from the first bucket into the second bucket:
gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg
```

- In the Cloud Console, on the Navigation menu(Navigation menu icon), click Cloud Storage > Browser, select both the buckets that you created, and verify that both contain the cat.jpg file


- Set the access control list for a Cloud Storage object
- Execute the following command in Cloud Shell:

```bash
gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl.txt
cat acl.txt

# To change the object to have private access, execute the following command:
gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg

# To verify the new ACL that's been assigned to cat.jpg, execute the following two commands:
gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg  > acl-2.txt
cat acl-2.txt
```

- In Cloud Shell, execute the following command to view the current configuration:

```bash
gcloud config list

# In Cloud Shell, execute the following command to change the authenticated user to the first service account (which you created in an earlier task) through the credentials that you downloaded to your local machine and then uploaded into Cloud Shell (credentials.json):
gcloud auth activate-service-account --key-file credentials.json

gcloud config list

# To verify the list of authorized accounts in Cloud Shell, execute the following command:
gcloud auth list

# To verify that the current account (test-service-account) cannot access the cat.jpg file in the first bucket that you created, execute the following command:
# Because you restricted access to this file to the owner earlier in this task.
gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./cat-copy.jpg

# Verify that the current account (test-service-account) can access the cat.jpg file in the second bucket that you created:
gsutil cp gs://$MY_BUCKET_NAME_2/cat.jpg ./cat-copy.jpg

# To switch to the lab account, execute the following command, replacing [USERNAME] with the username provided in the Qwiklabs 
gcloud config set account [USERNAME]

# To verify that you can access the cat.jpg file in the [BUCKET_NAME] bucket (the first bucket that you created), execute the following command.
gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./copy2-of-cat.jpg

# Make the first Cloud Storage bucket readable by everyone, including unauthenticated users:
gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1

# Get the public URL of the object
```

### Explore the Cloud Shell code editor


- On the Cloud console tab, click Open Terminal and in Cloud Shell, execute the following command to clone a git repository:

```bash
git clone https://github.com/googlecodelabs/orchestrate-with-kubernetes.git

mkdir test

# Add the following text as the last line of the cleanup.sh file:
```

- Add the following text as the last line of the cleanup.sh file:
```bash
echo Finished cleanup! 
```

- In Cloud Shell, execute the following commands to change directory and display the contents of cleanup.sh:
- Create new file. 
- Save the file in orchestrate-with-kubernetes folder and name the file index.html
- Replace the string REPLACE_WITH_CAT_URL with the URL of the cat image from an earlier task

```bash
<html><head><title>Cat</title></head>
<body>
<h1>Cat</h1>
<img src="REPLACE_WITH_CAT_URL">
</body></html>
```

- first-vm, click the SSH button.

```bash
sudo apt-get remove -y --purge man-db
sudo touch /var/lib/man-db/auto-update
sudo apt-get update
sudo apt-get install nginx
```

- In your Cloud Shell window, copy the HTML file you created using the Code Editor to your virtual machine:

```bash
gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=us-central1-c
```

- In the SSH login window for your VM, copy the HTML file from your home directory to the document root of the nginx Web server:

```bash
sudo cp index.nginx-debian.html /var/www/html
```

- Click the link in the External IP column for your first-vm. A new browser tab opens, containing a Web page that contains the cat image.


# Getting Started with Cloud Storage and Cloud SQL

[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

## Deploy a WebServer VM instance

- Create instance `bloghost` with `Debian GNU/Linux 11 (bullseye)` image and ensure that you allow `http` traffic
- Add the following startup script

```bash
apt-get update
apt-get install apache2 php php-mysql -y
service apache2 restart
```

## Create a Cloud Storage bucket using the gsutil command line

- Use cloudshell for the following

```bash
export LOCATION=US

echo $DEVSHELL_PROJECT_ID 

## Create bucket
gsutil mb -l $LOCATION gs://$DEVSHELL_PROJECT_ID

## Copy image from public bucket to your local i.e. cloudshell
gsutil cp gs://cloud-training/gcpfci/my-excellent-blog.png my-excellent-blog.png

## Copy from cloudshell to new bucket
gsutil cp my-excellent-blog.png gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png

## Modify the Access Control List of the object you just created so that it is readable by everyone
gsutil acl ch -u allUsers:R gs://$DEVSHELL_PROJECT_ID/my-excellent-blog.png
```

## Create the Cloud SQL instance

- Create SQL instance with db engine as MySQL, instance id as `blog-db`, password as `rootpass`
- Use Single Zone
- Wait for it to get created
- Go to `Users` and add user `blogdbuser` and give password as `blogdbuserpassword`
- Go to `Connections`. Give name as `web front end`. For external IP give `bloghostVM_public_ip/32`


## Configure an application in a Compute Engine instance to use Cloud SQL

- SSH to bloghost
- Run the following

```bash
cd /var/www/html
sudo vi index.php
```
- and paste content into the file

```php
<html>
<head><title>Welcome to my excellent blog</title></head>
<body>
<h1>Welcome to my excellent blog</h1>
<?php
 $dbserver = "CLOUDSQLIP";
$dbuser = "blogdbuser";
$dbpassword = "DBPASSWORD";
// In a production blog, we would not store the MySQL
// password in the document root. Instead, we would store it in a
// configuration file elsewhere on the web server VM instance.
$conn = new mysqli($dbserver, $dbuser, $dbpassword);
if (mysqli_connect_error()) {
        echo ("Database connection failed: " . mysqli_connect_error());
} else {
        echo ("Database connection succeeded.");
}
?>
</body></html>
```

- Save and restart

```bash
sudo service apache2 restart
```

- Visit `bloghostVM_publicIP/index.php`
- Edit the file and add `CLOUDSQLIP` and `DBPASSWORD`
- Restart and visit again

## Configure an application in a Compute Engine instance to use a Cloud Storage object

- Go to buckets and copy public url of `my-excellent-blog.png`
- Add this to index.php

```html
 <img src='PUBLIC_URL'>
```
- Restart and visit again


# Getting Started With Cloud Marketplace


[https://www.cloudskillsboost.google](https://www.cloudskillsboost.google)

[Select - DevOps Engineer, SRE Learning Path](https://www.cloudskillsboost.google/paths)

> Task :  We will use the Cloud MarketPlace to deploy a LAMP stack

## High Level Tasks

- Search for "LAMP Packaged by Bitnami" in the Marketplace
- Launch
- You should see the status as deployed as it is completed
- Go to the site address
- SSH
- In the created SSH window

```bash
cd /opt/bitnami

sudo sh -c 'echo "<?php phpinfo(); ?>" > apache2/htdocs/phpinfo.php'
```

- Open the `SITE_ADDRESS` again to view your changes
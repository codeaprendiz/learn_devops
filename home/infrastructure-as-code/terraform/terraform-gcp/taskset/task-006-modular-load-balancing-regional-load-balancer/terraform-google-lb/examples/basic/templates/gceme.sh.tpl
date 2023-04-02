# This is a bash script that installs Apache and PHP on a Debian-based Linux machine and sets up a web page that
# displays the metadata of the
# Google Cloud instance that the script is running on. The script starts by updating the package list with apt-get
# update and installs Apache
# and PHP with apt-get install -y apache2 libapache2-mod-php.
#
# The script then uses a here document to write a PHP script to /var/www/html/index.php that displays the metadata of the
# instance using the Google Cloud metadata server. The PHP script defines a metadata_value function that makes an HTTP GET
# request to the metadata server with a specific header indicating the use of the Google Cloud metadata server. The PHP script
# then prints the metadata values in an HTML table.
#
# The script also checks if the PROXY_PATH environment variable is set and creates a directory at /var/www/html/${PROXY_PATH}
# if it is. It then copies the index.php file to this directory to enable the script to be accessed through a proxy server.
#
# Finally, the script enables and restarts the Apache web server with systemctl enable apache2 and systemctl restart apache2.

#!/bin/bash -xe

apt-get update
apt-get install -y apache2 libapache2-mod-php

cat > /var/www/html/index.php <<'EOF'
<?php
function metadata_value($value) {
    $opts = [
        "http" => [
            "method" => "GET",
            "header" => "Metadata-Flavor: Google"
        ]
    ];
    $context = stream_context_create($opts);
    $content = file_get_contents("http://metadata/computeMetadata/v1/$value", false, $context);
    return $content;
}
?>

<!doctype html>
<html>
<head>
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/css/materialize.min.css">

<!-- Compiled and minified JavaScript -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.0/js/materialize.min.js"></script>
<title>Frontend Web Server</title>
</head>
<body>
<div class="container">
<div class="row">
<div class="col s2">&nbsp;</div>
<div class="col s8">


<div class="card blue">
<div class="card-content white-text">
<div class="card-title">Backend that serviced this request</div>
</div>
<div class="card-content white">
<table class="bordered">
  <tbody>
	<tr>
	  <td>Name</td>
	  <td><?php printf(metadata_value("instance/name")) ?></td>
	</tr>
	<tr>
	  <td>ID</td>
	  <td><?php printf(metadata_value("instance/id")) ?></td>
	</tr>
	<tr>
	  <td>Hostname</td>
	  <td><?php printf(metadata_value("instance/hostname")) ?></td>
	</tr>
	<tr>
	  <td>Zone</td>
	  <td><?php printf(metadata_value("instance/zone")) ?></td>
	</tr>
    <tr>
	  <td>Machine Type</td>
	  <td><?php printf(metadata_value("instance/machine-type")) ?></td>
	</tr>
	<tr>
	  <td>Project</td>
	  <td><?php printf(metadata_value("project/project-id")) ?></td>
	</tr>
	<tr>
	  <td>Internal IP</td>
	  <td><?php printf(metadata_value("instance/network-interfaces/0/ip")) ?></td>
	</tr>
	<tr>
	  <td>External IP</td>
	  <td><?php printf(metadata_value("instance/network-interfaces/0/access-configs/0/external-ip")) ?></td>
	</tr>
  </tbody>
</table>
</div>
</div>

<div class="card blue">
<div class="card-content white-text">
<div class="card-title">Proxy that handled this request</div>
</div>
<div class="card-content white">
<table class="bordered">
  <tbody>
	<tr>
	  <td>Address</td>
	  <td><?php printf($_SERVER["HTTP_HOST"]); ?></td>
	</tr>
  </tbody>
</table>
</div>

</div>
</div>
<div class="col s2">&nbsp;</div>
</div>
</div>
</html>
EOF
sudo mv /var/www/html/index.html /var/www/html/index.html.old

[[ -n "${PROXY_PATH}" ]] && mkdir -p /var/www/html/${PROXY_PATH} && cp /var/www/html/index.php /var/www/html/${PROXY_PATH}/index.php

systemctl enable apache2
systemctl restart apache2

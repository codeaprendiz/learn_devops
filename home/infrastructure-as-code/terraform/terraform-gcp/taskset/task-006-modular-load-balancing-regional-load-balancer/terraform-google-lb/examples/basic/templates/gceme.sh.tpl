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

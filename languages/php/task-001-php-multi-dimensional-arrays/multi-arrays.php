<?php

$mongodbClusterHost = [
    'www' => ['host' => 'mongodb.com', 'user' => 'admin', 'password' => 'thisisit', 'protocol' => 'mongodb+srv', ],
    'cli-app' => [ 'user' => 'app-user' , 'password' => 'cli-is-password',],

];

print_r($mongodbClusterHost);

print_r(array_keys($mongodbClusterHost));


print_r($mongodbClusterHost['cli-app']['user']);
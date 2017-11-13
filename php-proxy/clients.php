<?php

require_once ("vendor/autoload.php");


$client = new PhpProxy();

$authResponse = $client->call('backend.auth', array("user" => $_GET["user"], "password" => $_GET["password"]));

$auth = json_decode($authResponse);

if ($auth->login == true) {
  $response = $client->call('backend.clients', array());
  print_r($response);
} else {
  print_r($authResponse);
}
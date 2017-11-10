<?php

require_once ("vendor/autoload.php");


$client = new PhpProxy();

$response = $client->call('backend.invoices', array("client_id" => $_GET['client_id']));

if (isset($_SERVER['HTTP_ORIGIN'])) {
    header("Access-Control-Allow-Origin: *");
    header('Access-Control-Allow-Credentials: true');
    header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
}

print_r($response);

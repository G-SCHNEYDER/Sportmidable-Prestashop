<?php
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

// Collects all the needed arguments.
$message = Tools::getValue('message');
$visibility = Tools::getValue('visibility');
$idOrder = Tools::getValue('id_order');
$employeeId = Tools::getValue('employee_id');

$response = ['status' => 200];

if(!Dashboard::addCustomerMessage($idOrder, $message, $visibility, $employeeId)) {
  $response = ['status' => 500, 'error' => 'An error occurred while saving the message.'];
}

echo json_encode($response);

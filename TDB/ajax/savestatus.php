<?php
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

// Collects all the needed arguments.
$statusId = Tools::getValue('status_id');
$detailId = Tools::getValue('detail_id');
$date = Tools::getValue('date');
$orderId = Tools::getValue('orderId');

$response = ['status' => 200];

if(!Dashboard::saveStatus($detailId, $statusId)) {
  $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
}

if(($statusId == 3 || $statusId == 4) && !empty($date)) {
  if(!Dashboard::saveStatusDate($detailId, $statusId, $date)) {
    $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
  }
}



echo json_encode($response);

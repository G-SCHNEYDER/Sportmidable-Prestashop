<?php
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

// Collects all the needed arguments.
$detailId = Tools::getValue('detail_id');

$response = ['status' => 200];

if(!Dashboard::resetStatus($detailId)) {
  $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
}

echo json_encode($response);

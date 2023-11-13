<?php include_once('../functions.php');
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

// Collects all the needed arguments.
$date = Tools::getValue('date');
$statusId = Tools::getValue('status_id');
$detailId = Tools::getValue('detail_id');
$orderId = Tools::getValue('order_id');

if (empty($date)) {
    $date = null;
}

$response = ['status' => 200];

if (!Dashboard::saveStatus($detailId, $statusId)) {
    $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
}

if (!Dashboard::saveStatusOrder($orderId, $statusId, $employeeId)) {
    $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
}

if (!Dashboard::saveStatusDate($detailId, $statusId, $date)) {
    $response = ['status' => 500, 'error' => 'An error occurred while saving the status.'];
}

echo json_encode($response);

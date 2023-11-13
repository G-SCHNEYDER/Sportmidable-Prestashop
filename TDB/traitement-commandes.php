<?php set_time_limit(0);

function debug($chaine, $die = false)
{
    echo "<hr /><pre>";
    var_dump($chaine);
    echo "</pre><hr />";
    if ($die) {
        die();
    }
}

include_once('../config/config.inc.php');
include_once('../config/settings.inc.php');
include_once('../modules/registrationfields/models/Fields.php');
include_once('database/db_connection.php');
include_once('helper.php');

$employeeId = 4;

//----------------------------------------------------------------------------------------------------------------------

if (!empty($_GET['x'])) {

    $datas = Dashboard::getAllOrder($_GET['x'], !empty($_GET['y']) ? $_GET['y'] : $_GET['x']);

    foreach ($datas as $data) {

        debug($data['id_order']);

        $order = new Order($data['id_order']);
        $current_state = $data['current_state'];

        if ($current_state == 5) {
            continue;
        }

        $details = $order->getProducts();
        $statutLivre = [];
        foreach ($details as $d) {
            $status = Dashboard::getStatus($d['id_order_detail']);
            if ($status['id'] == 8) {
                $statutLivre[] = $status['id'];
            }
        }

        if (!in_array($current_state, [5, 23]) && count($details) == count($statutLivre) > 0) {
            debug('Partiel');
            $order->setCurrentState(23, $employeeId);
        } elseif (!in_array($current_state, [5]) && count($details) == count($statutLivre)) {
            debug('Livré');
            $order->setCurrentState(5, $employeeId);
        }
    }
}
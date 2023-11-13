<?php
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

$idOrder = Tools::getValue('id_order');

// Returns the order messages in json.
echo Dashboard::getMessages($idOrder);


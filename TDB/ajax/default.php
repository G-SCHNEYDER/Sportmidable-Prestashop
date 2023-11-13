<?php
include_once('../../config/config.inc.php');
include_once('../../config/settings.inc.php');
include_once('../helper.php');

$action = Tools::getValue('action');


if($action == "savecommentaire"){
	savecommentaire($_REQUEST["idOrderDetail"], $_REQUEST["message"]);
}

if($action == "saveremarquelivraison"){
	saveremarquelivraison($_REQUEST["idOrderDetail"], $_REQUEST["message"]);
}

function savecommentaire($idOrderDetail, $message){
	$orderdetail = new OrderDetailCore($idOrderDetail);
	$orderdetail->commentaireprive = $message;
	$orderdetail->update();

	echo "ok";
}

function saveremarquelivraison($idOrderDetail, $message){
	$orderdetail = new OrderDetailCore($idOrderDetail);
	$orderdetail->remarquelivraison = $message;
	$orderdetail->update();

	echo "ok";
}
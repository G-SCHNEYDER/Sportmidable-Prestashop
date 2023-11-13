<?php 

//phpinfo();
include_once('../config/config.inc.php');
include_once('../config/settings.inc.php');

// Load order object
$order = new Order(207);
//echo $order->setOrderDetailStatus(207, 2, 1);exit;
// echo $order->setOrderDetailStatusDate(207, 2, "2020-12-02");exit;


$orderdetail = $order->getProductsDetail();

$id_order_detail =  $orderdetail[0]["id_order_detail"];




echo "<pre>";


for($i=0; $i < count($orderdetail); $i++){
	$idProduit = $orderdetail[$i]["product_id"];
	$idProductAttribute = $orderdetail[$i]["product_attribute_id"];

	$produit = new Product($idProduit);
	//echo "<b>".$produit["name"]."</b>";

	//echo "$idProduit-$idProductAttribute";
	$combination = new Combination($idProductAttribute);
	$combinationoptions = $combination->getWsProductOptionValues();
	for($j=0; $j < count($combinationoptions); $j++){
		$idAttribute = $combinationoptions[$j]["id"];
		$attribute = new Attribute($idAttribute);
		echo $attribute->name[1]." ".$attribute->id_attribute_group."<br>";
		//var_dump($attribute);
	}
	//var_dump($combination);exit;

	$attributesParam = $produit->getAttributesParams($idProduit, $idProductAttribute);
	//var_dump($attributesParam);
}





?>

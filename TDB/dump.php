<?php
include_once('../config/config.inc.php');
include_once('../config/settings.inc.php');
include_once('../modules/registrationfields/models/Fields.php');
include_once('database/db_connection.php');

$conn = openCon();
$result = $conn->query('SELECT id_order FROM ps_orders WHERE 1');
$ids = [];

while ($row = $result->fetch_row()) {
  //printf ("%s\n", $row[0]);
  $ids[] = $row[0];
}

closeCon($conn);

//$orderIds = Order::getOrdersIdByDate('2020-01-01', '2020-09-22');
echo '<pre>'; 
foreach ($ids as $orderId) {
  $order = new Order((int) $orderId);
  $productsDetail = $order->getProductsDetail();

  $customer = $order->getCustomer();
  $orderDetails = $order->getOrderDetailList();
  $shop = new Shop($order->id_shop);
  $messages = CustomerMessage::getMessagesByOrderId($orderId);
  //echo Country::getNameById(1, $shop->getAddress()->id_country);
  //echo 'tracking: ';
  //echo $cat->getName(1);
  $carrier = new CarrierCore($order->getIdOrderCarrier());
  //echo $carrier->name;
//var_dump($customer->id);
  $fields = Fields::getAllFields('val.id_customer = '.$customer->id, 1);
  if(!empty($fields)) {
    var_dump($fields[0]['field_value']);
  }
  /*$customFields = Fields::getCustomFieldValues(3);
  foreach($customFields as $customField) {
    var_dump(Fields::getFieldsValueById($customField['field_value_id']));
  }*/

  foreach ($orderDetails as $orderDetail) {
    //var_dump($orderDetail['product_name']);
    //echo $orderDetail['product_id'];
    $product = new Product($orderDetail['product_id']);
    //$customizations = $product->getCustomizationFields(1, $order->id_shop);
    $customization = new Customization($orderDetail['id_customization']);
    $custs = $customization->getWsCustomizedDataTextFields();
    var_dump($custs);
    foreach($custs as $cust) {
      var_dump($customization->getLabel($cust['id_customization_field'], 1, $order->id_shop));
    }
    //$combination = new Combination($orderDetail['product_attribute_id']);
    //$combinationoptions = $combination->getWsProductOptionValues();
    //echo Manufacturer::getNameById((int) $product->id_manufacturer);
    //var_dump($order->getWsShippingNumber());
    //$attribs = ['size' => '', 'color_1' => '', 'color_2' => ''];
    //$colorPosition = null;

    /*for($j=0; $j < count($combinationoptions); $j++){
	    $idAttribute = $combinationoptions[$j]["id"];
	    $attribute = new Attribute($idAttribute);
	    //echo $attribute->name[1]."<br>";
	    if(empty($attribute->color)) {
	      $attribs['size'] = $attribute->name[1];
	    }
	    elseif($colorPosition === null) {
	      $colorPosition = $attribute->position;
	      $attribs['color_1'] = $attribute->name[1];
	    }
	    else {
	      if($attribute->position > $colorPosition) {
		$attribs['color_2'] = $attribute->name[1];
	      }
	      else {
		$attribs['color_2'] = $attribs['color_1'];
		$attribs['color_1'] = $attribute->name[1];
	      }
	    }
	      
    }*/
    $attributesParams = $product->getAttributesParams($orderDetail['product_id'], $orderDetail['product_attribute_id']);
    foreach ($attributesParams as $params) {
      //echo $params['group'].' '.$params['name'].'<br />';
    }
    //var_dump($attributesParams);
    //var_dump($attribs);
    echo '<br />';
  }

}



?>


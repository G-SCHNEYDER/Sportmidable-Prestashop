<?php

class Dashboard
{
    /*static function getOrders()
    {
        $conn = openCon();
        $conditions = [];
        //$conditions[] = 'id_order > 4800';
        if ($_GET["commandes"] == 'encours') {
            $conditions[] = 'current_state IN(2,3,4,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
        } elseif ($_GET["commandes"] == 'shop') {
            $conditions[] = 'id_shop = '.$_GET["shop"];
            if ($_GET["statut"] == 'encours') {
                $conditions[] = 'current_state IN(2,3,4,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
            } elseif ($_GET["statut"] == 'livre') {
                $conditions[] = 'current_state IN(2,3,4,5,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
            }
        } elseif ($_GET["commandes"] == 'livrees') {
            $conditions[] = 'current_state = 5';
        }
        $cs = '';
        if (!empty($conditions)) {
            $cs = ' WHERE '.implode(' and ', $conditions);
        }
        $result = $conn->query("SELECT * FROM ps_orders $cs ORDER BY date_add DESC");
        $datas = [];
        while ($row = $result->fetch_array(MYSQLI_ASSOC)) {
            $datas[$row['id_order']] = $row;
        }
        closeCon($conn);
        return $datas;
    }*/
    static function getOrdersPaginate($parPage = 25, $premier = 1)
    {
        $conn = openCon();
        $conditions = [];
        //$conditions[] = 'id_order > 4800';
        if ($_GET["commandes"] == 'encours') {
            $conditions[] = 'current_state IN (2,3,4,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
        } elseif ($_GET["commandes"] == 'shop') {
            $conditions[] = 'id_shop = '.$_GET["shop"];
            if ($_GET["statut"] == 'encours') {
                $conditions[] = 'current_state IN (2,3,4,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
            } elseif ($_GET["statut"] == 'livre') {
                $conditions[] = 'current_state IN (2,3,4, 5,9,11,23,27,29,33,34,35,36,38,39,40,41,54,55)';
            } else {
                $conditions[] = 'current_state != 6';
            }
        } elseif ($_GET["commandes"] == 'livrees') {
            $conditions[] = 'current_state = 5';
        } else {
            $conditions[] = 'current_state != 6';
        }
        $cs = '';
        if (!empty($conditions)) {
            $cs = 'WHERE '.implode(' and ', $conditions);
        }
        //----------------------------------------------------------------------------------------
        $orders = [];
        $query = $conn->query("SELECT * FROM ps_orders $cs ORDER BY date_add DESC LIMIT $premier, $parPage");
        while ($row = $query->fetch_array(MYSQLI_ASSOC)) {
            $orders[$row['id_order']] = $row;
        }
        //----------------------------------------------------------------------------------------
        $query = $conn->query("SELECT count(*) as nb FROM ps_orders $cs");
        $result = $query->fetch_array(MYSQLI_ASSOC);
        $nb = $result['nb'];
        //----------------------------------------------------------------------------------------
        closeCon($conn);
        return [
            'orders' => $orders,
            'nb' => $nb
        ];
    }

    static function getAllOrder($debut = 0, $fin = 0)
    {
        $conn = openCon();
        $result = $conn->query("SELECT * FROM ps_orders WHERE id_order BETWEEN '$debut' AND '$fin' and current_state != 6 ORDER BY date_add DESC");
        $datas = [];
        while ($row = $result->fetch_assoc()) {
            $datas[] = $row;
        }
        closeCon($conn);
        return $datas;
    }

    static function getShops()
    {
        $conn = openCon();
        $result = $conn->query("SELECT * FROM ps_shop WHERE active = 1 and deleted = 0 ORDER BY name");
        $datas = [];
        while ($row = $result->fetch_assoc()) {
            $datas[] = $row;
        }
        closeCon($conn);
        return $datas;
    }

    /*static function getOrderDetail($id_order_detail) {

        $conn = openCon();

        $result = $conn->query("SELECT * FROM ps_order_detail WHERE id_order = $id_order_detail");
        $datas = [];

        while ($row = $result->fetch_assoc()) {
            $datas[] = $row;
        }

        closeCon($conn);

        return $datas;
    }*/
    static function getCarrier($id_order)
    {
        $conn = openCon();
        $result = $conn->query(
            "SELECT * FROM ps_order_carrier oc left join ps_carrier c on c.id_carrier = oc.id_carrier WHERE oc.id_order = $id_order"
        );
        $data = $result->fetch_assoc();
        closeCon($conn);
        return $data;
    }

    static function getAddress($id_address)
    {
        $conn = openCon();
        $result = $conn->query("SELECT * FROM ps_address WHERE id_address = $id_address");
        $data = $result->fetch_assoc();
        closeCon($conn);
        return $data;
    }

    static function getManufacturers()
    {
        $conn = openCon();
        $result = $conn->query("SELECT * FROM ps_manufacturer order by name");
        $datas = [];
        while ($row = $result->fetch_row()) {
            $datas[] = $row;
        }
        closeCon($conn);
        return $datas;
    }

    /*
     * Returns the id of the employee currently logged in.
     *
     */
    static function getEmployeeId()
    {
        $cookie = new Cookie('psAdmin', '', (int) Configuration::get('PS_COOKIE_LIFETIME_BO'));
        if (isset($cookie->id_employee) && $cookie->id_employee) {
            return $cookie->id_employee;
        }
        return false;
    }

    static function employeeById($id_employee)
    {
        $conn = openCon();
        $result = $conn->query("SELECT * FROM ps_employee WHERE id_employee = '$id_employee'");
        $row = $result->fetch_row();
        closeCon($conn);
        return $row;
    }

    static function getProductName($detail)
    {
        $productName = $detail['product_name'];
        if (preg_match('#^(.+)( - )(.+)#', $productName, $matches)) {
            $productName = $matches[1];
        }
        return $productName;
    }

    /*
     * Sets the product attributes to their corresponding values.
     */
    static function getProductAttributes($productAttributeId)
    {
        $combination = new Combination($productAttributeId);
        $combinationoptions = $combination->getWsProductOptionValues();
        $attributes = ['size' => '', 'color_1' => '', 'color_2' => '', 'color_code' => ''];
        for ($i = 0; $i < count($combinationoptions); $i++) {
            $idAttribute = $combinationoptions[$i]['id'];
            $attribute = new Attribute($idAttribute);
            $value = $attribute->name[1];
            switch ($attribute->id_attribute_group) {
                case 6:
                    $attributes['size'] = $value;
                    break;
                case 7:
                    $attributes['color_1'] = $value;
                    break;
                case 8:
                    $attributes['color_2'] = $value;
                    break;
                case 22:
                    $attributes['color_code'] = $value;
                    break;
            }
        }
        return $attributes;
    }

    /*
     * Sets the alerts for each status.
     */
    static function setAlerts($order, $product, $detail, $status, $shop, &$alerts)
    {
        // Use order date for not yet treated order products.
        $statusDate = ($status['id'] == 0 || $status['id'] == 5) ? $order->date_add : $status['history'][$status['id']];
        if ($status['id'] == 0 || $status['id'] == 5) {
            $statusDate = $order->date_add;
            // }elseif($status['id'] == 0){
            //   $statusDate = $order->date_add;
        } else {
            $statusDate = $status['history'][$status['id']];
        }
        if (empty($statusDate) || $statusDate == '0000-00-00') {
            return;
        }
        // Removes the time part (for dates coming from the order).
        $statusDate = substr($statusDate, 0, 10);
        // Checks for late order products.
        if ($daysLate = self::isLate($status['id'], $statusDate)) {
            $alerts[$status['id']][] = [
                'id_order' => $order->id,
                'id_order_detail' => $detail['id_order_detail'],
                'shop_name' => $shop->name,
                'status' => self::getStatusLabels()[$status['id']],
                'status_date' => $statusDate,
                'product_reference' => $product->reference,
                'product_name' => Dashboard::getProductName($detail),
                'days_late' => $daysLate
            ];
        }
    }

    /*
     * Fetches and returns the messages linked to a given order.
     *
     */
    static function getMessages($orderId, $json = true)
    {
        $messages = CustomerMessage::getMessagesByOrderId($orderId);
        $data = [];
        foreach ($messages as $message) {
            $row = [
                'message' => $message['message'],
                'date' => $message['date_upd'],
                'employe' => $message['efirstname'].' '.$message['elastname']
            ];
            $data[] = $row;
        }
        if ($json) {
            $data = json_encode($data);
        }
        return $data;
    }

    /*
     * Returns the product customization fields and their values.
     */
    static function getProductCustomizations($customizationId)
    {
        $customization = new Customization($customizationId);
        $fields = $customization->getWsCustomizedDataTextFields();
        $customizations = [];
        foreach ($fields as $key => $row) {
            $field = [];
            if (!empty($row['value'])) {
                $field['name'] = $customization->getLabel($row['id_customization_field'], 1);
                $field['value'] = $row['value'];
                $customizations[] = $field;
            }
        }
        return $customizations;
    }

    /*
     * Returns the product packs fields and their values.
     */
    static function getProductPacks($orderId, $productAttributeId)
    {
        $conn = openCon();
        $result = $conn->query(
            'SELECT customization_infos FROM ps_pm_advancedpack_cart_products '.'WHERE id_product_attribute='.$productAttributeId.' AND id_order='.$orderId
        );
        $row = $result->fetch_row();
        $result->free();
        $packs = [];
        if ($row[0]) {
            $data = json_decode($row[0], true);
            $fieldIds = [];
            foreach ($data as $key => $value) {
                $fieldIds[] = $key;
            }
            $result = $conn->query(
                'SELECT id_customization_field, name FROM ps_customization_field_lang '.'WHERE id_customization_field IN('.implode(
                    ',',
                    $fieldIds
                ).')'
            );
            $rows = mysqli_fetch_all($result, MYSQLI_ASSOC);
            foreach ($data as $key => $value) {
                $field = [];
                foreach ($rows as $row) {
                    if ($row['id_customization_field'] == $key) {
                        $field['name'] = $row['name'];
                        $field['value'] = $value;
                        $packs[] = $field;
                    }
                }
            }
            $result->free();
        }
        closeCon($conn);
        return $packs;
    }

    /*
     * Adds a customer message.
     * controllers/admin/AdminOrdersController.php from line 611
     */
    static function addCustomerMessage($idOrder, $message, $visibility, $id_employee = null)
    {
        $order = new Order((int) $idOrder);
        $customer = $order->getCustomer();
        //check if a thread already exist
        $id_customer_thread = CustomerThread::getIdCustomerThreadByEmailAndIdOrder($customer->email, $idOrder);
        if (!$id_customer_thread) {
            $customer_thread = new CustomerThread();
            $customer_thread->id_contact = 0;
            $customer_thread->id_customer = (int) $order->id_customer;
            $customer_thread->id_shop = (int) $order->id_shop;
            $customer_thread->id_order = (int) $order->id;
            $customer_thread->id_lang = 1; // French by default
            $customer_thread->email = $customer->email;
            $customer_thread->status = 'open';
            $customer_thread->token = Tools::passwdGen(12);
            $customer_thread->add();
        } else {
            $customer_thread = new CustomerThread((int) $id_customer_thread);
        }
        //$id_employee = 22; // For test purpose only !
        if ($id_employee === null) {
            $id_employee = self::getEmployeeId();
        }
        $customer_message = new CustomerMessage();
        $customer_message->id_customer_thread = $customer_thread->id;
        $customer_message->id_employee = (int) $id_employee;
        $customer_message->message = $message;
        $customer_message->private = $visibility;
        if (!$customer_message->add()) {
            return false;
        }
        if (!$visibility) {
            $message = $customer_message->message;
            if (Configuration::get('PS_MAIL_TYPE', null, null, $order->id_shop) != Mail::TYPE_TEXT) {
                $message = Tools::nl2br($customer_message->message);
            }
            $orderLanguage = new Language((int) $order->id_lang);
            $varsTpl = [
                '{lastname}' => $customer->lastname,
                '{firstname}' => $customer->firstname,
                '{id_order}' => $order->id,
                '{order_name}' => $order->getUniqReference(),
                '{message}' => $message,
            ];
            if (!@Mail::Send(
                (int) $order->id_lang,
                'order_merchant_comment',
                Context::getContext()->getTranslator()->trans('New message regarding your order', [], 'Emails.Subject', $orderLanguage->locale),
                $varsTpl,
                $customer->email,
                $customer->firstname.' '.$customer->lastname,
                null,
                null,
                null,
                null,
                _PS_MAIL_DIR_,
                true,
                (int) $order->id_shop
            )) {
                $msg = date(
                        'Y/m/d h:i:s'
                    ).' - Failed to send email to: '.$customer->email.' order id:'.$order->id.' id employee: '.$id_employee;
                file_put_contents('error_email.log', print_r($msg, true), FILE_APPEND);
            }
        }
        return true;
    }

    /*
     * Returns the date and status id for a given order detail id.
     *
     */
    static function getStatus($detailId)
    {
        $detail = new OrderDetail($detailId);
        $results = $detail->getOrderDetailStatus($detailId);
        $status = ['id' => 0, 'history' => []];
        if (empty($results)) {
            return $status;
        }
        foreach ($results as $result) {
            if ((int) $result['last']) {
                $status['id'] = $result['id_status'];
            }
            $status['history'][$result['id_status']] = $result['date'];
        }
        return $status;
    }

    /*
     * For test purpose only.
     *
     */
    static function _getStatus($detailId)
    {
        // Computes a random date and id. For test purpose only.
        $date = self::randomDate('2020-09-10', '2020-10-05', 'Y-m-d');
        $id = rand(0, 8);
        // For test purpose only.
        $history = [];
        for ($i = 0; $i < $id + 1; $i++) {
            $history[$i] = self::randomDate('2020-09-10', '2020-10-05', 'Y-m-d');
        }
        return ['id' => $id, 'history' => $history];
    }

    /*
     * Returns the status labels according to the corresponding status id.
     *
     */
    static function getStatusLabels()
    {
        return [
            0 => 'NON TRAITÉ',
            1 => 'COMMANDE',
            2 => 'STOCK',
            3 => 'RUPTURE',
            4 => 'RELIQUAT',
            5 => 'RECU',
            6 => 'MARQUAGE / PRET',
            7 => 'EXPEDITION',
            8 => 'LIVRÉ'
        ];
    }

    /*
     * Saves or updates a status for a given order detail id.
     *
     */
    static function saveStatus($detailId, $statusId)
    {
        $detail = new OrderDetail($detailId);
        return $detail->setOrderDetailStatus($detailId, $statusId);
    }

    static function saveStatusOrder($orderId, $statusId, $employeeId)
    {
        $order = new Order($orderId);
        $current_state = $order->getCurrentState();
        if (!in_array($current_state, [3, 5, 23]) && in_array($statusId, [1, 2, 3, 4, 5, 6, 7])) {
            return $order->setCurrentState(3, $employeeId);
        } elseif ($statusId == 8) {
            $details = $order->getProducts();
            $statutLivre = [];
            foreach ($details as $d) {
                $status = self::getStatus($d['id_order_detail']);
                if ($status['id'] == 8) {
                    $statutLivre[] = $status['id'];
                }
            }
            if (!in_array($current_state, [5, 23]) && count($details) > 1 && count($details) == count($statutLivre) > 0) {
                return $order->setCurrentState(23, $employeeId);
            } elseif (!in_array($current_state, [5]) && count($details) == count($statutLivre)) {
                return $order->setCurrentState(5, $employeeId);
            }
        }
        return;
    }

    /*
     * Reinitializes status for a given order detail id.
     *
     */
    static function resetStatus($detailId)
    {
        $detail = new OrderDetail($detailId);
        return $detail->resetOrderDetailStatus($detailId);
    }

    /*
     * Saves or updates a status date for a given order detail id.
     *
     */
    static function saveStatusDate($detailId, $statusId, $date = null)
    {
        $detail = new OrderDetail($detailId);
        return $detail->setOrderDetailStatusDate($detailId, $statusId, $date);
    }

    static function getSummary($orderId, $detailId)
    {
        $order = new Order((int) $orderId);
        $shop = new Shop($order->id_shop);
        $detail = new OrderDetail((int) $detailId);
        $customer = $order->getCustomer();
        $product = new Product($detail['product_id']);
        $brand = Manufacturer::getNameById((int) $product->id_manufacturer);
        $status = self::getStatus($detail['id_order_detail']);
        $fields = Fields::getAllFields('val.id_customer = '.$customer->id, 1);
        $imagePath = '';
        $category = '';
        if (!empty($fields)) {
            $category = $fields[0]['field_value'];
        }
        $summary = [
            'detail_id' => $detailId,
            'order_id' => $order->id,
            'shop' => $shop->name,
            'firstname' => $customer->firstname,
            'lastname' => $customer->lastname,
            'category' => $category,
            'reference' => $product->reference,
            'name' => $product->name[1],
            'brand' => $brand,
            'status' => self::getStatusLabels()[$status['id']],
            'image_path' => $imagePath
        ];
        return $summary;
    }

    /*
     * Computes the number of late days according to the given date and status id.
     * @param  int    $statusId  The status id.
     * @param  string $date      The date to compare to.
     * @return int	       The number of late days (if any).
     */
    static function isLate($statusId, $date)
    {
        $delays = [0 => 10, 1 => 15, 2 => 18, 3 => 18, 4 => 10, 5 => 18, 7 => 18, 8 => 20, 9 => 25, 6 => 10];
        // Some statuses are not defined.
        if (!array_key_exists($statusId, $delays)) {
            return 0;
        }
        // Removes the time part, just in case.
        $date = substr($date, 0, 10);
        $days = self::getNbOfDays($date);
        // Checks for the sign.
        if (substr($days, 0, 1) == '+') {
            return 0;
        }
        // Removes the minus sign from the figure.
        $days = substr($days, 1);
        if ($days > $delays[$statusId]) {
            return (int) $days;
        }
        return 0;
    }

    /**
     * Returns the given UTC date into the current timezone (ie: Europe/Paris).
     *
     * @param  string  $date  The date to set (must be in MySQL format yyyy-mm-dd).
     * @param  string  $format  The format to return the date into.
     *
     * @return string          The date into the current time zone.
     */
    static function getLocalDate($date, $format = 'Y-m-d H:i:s')
    {
        $localDate = new DateTime($date);
        $localDate->setTimezone(new DateTimeZone('Europe/Paris'));
        return $localDate->format($format);
    }

    /**
     * Returns the number of days from the current date against a given date.
     *
     * @param  string  $date  The date to compare (must be in MySQL format yyyy-mm-dd).
     *
     * @return string          The number of days prefixed with the minus or plus sign
     *                         according to the given date.
     */
    static function getNbOfDays($date)
    {
        $date1 = new DateTime($date);
        $date2 = new DateTime(date('Y-m-d'));
        return $date2->diff($date1)->format('%R%a');
    }

    /**
     * Method to generate random date between two dates - For test purpose only !
     *
     * @param $sStartDate
     * @param $sEndDate
     * @param  string  $sFormat
     *
     * @return bool|string
     */
    static function randomDate($sStartDate, $sEndDate, $sFormat = 'Y-m-d H:i:s')
    {
        // Convert the supplied date to timestamp
        $fMin = strtotime($sStartDate);
        $fMax = strtotime($sEndDate);
        // Generate a random number from the start and end dates
        $fVal = mt_rand($fMin, $fMax);
        // Convert back to the specified date format
        return date($sFormat, $fVal);
    }

    static function add_or_update_params($url, $key, $value)
    {
        $a = parse_url($url);
        $query = $a['query'] ? $a['query'] : '';
        parse_str($query, $params);
        $params[$key] = $value;
        $query = http_build_query($params);
        $result = '';
        if ($a['scheme']) {
            $result .= $a['scheme'].':';
        }
        if ($a['host']) {
            $result .= '//'.$a['host'];
        }
        if ($a['path']) {
            $result .= $a['path'];
        }
        if ($query) {
            $result .= '?'.$query;
        }
        return $result;
    }
}



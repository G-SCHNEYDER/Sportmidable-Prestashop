<?php session_start();
include_once('functions.php');
include_once('../config/config.inc.php');
include_once('../config/settings.inc.php');
include_once('../modules/registrationfields/models/Fields.php');
include_once('database/db_connection.php');
include_once('helper.php');
#include_once('../modules/deliverydate/deliverydate.php');
#include_once('../override/modules/deliverydate/deliverydate.php');
// Checks first that the employee is logged.
if (!$employeeId = Dashboard::getEmployeeId()) {
	die('<h1 style="color: #f00; text-align: center; margin-top: 60px">Merci de vous connecter avant à l\'administration de votre Prestashop<br>pour accéder à ce tableau de bord.</h1>');
}
$employee = Dashboard::employeeById($employeeId);
$shops = Dashboard::getShops();
if (empty($_SESSION['pagination'])) {
	$_SESSION['pagination'] = 25;
}
if (!empty($_GET['pagination'])) {
	if (is_numeric($_GET['pagination'])) {
		$_SESSION['pagination'] = (int)strip_tags($_GET['pagination']);
	} else {
		$_SESSION['pagination'] = 10000;
	}
} ?>

<!DOCTYPE html>
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="robots" content="all,follow">

	<title>TDB Sportmidable</title>

	<link rel="apple-touch-icon" sizes="180x180" href="/TDB/assets/favicon/apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="/TDB/assets/favicon/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="/TDB/assets/favicon/favicon-16x16.png">
	<link rel="manifest" href="/TDB/assets/favicon/site.webmanifest">

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css"
		  integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w=="
		  crossorigin="anonymous"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.0/css/bootstrap.min.css"
		  integrity="sha512-P5MgMn1jBN01asBgU0z60Qk4QxiXo86+wlFahKrsQf37c9cro517WzVSPPV1tDKzhku2iJ2FVgL67wG03SGnNA==" crossorigin="anonymous"
		  referrerpolicy="no-referrer"/>

	<link rel="stylesheet" href="assets/css/dashboard.css?<?php echo uniqid(); ?>"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/datatables/1.10.21/css/dataTables.bootstrap4.min.css"
		  integrity="sha512-PT0RvABaDhDQugEbpNMwgYBCnGCiTZMh9yOzUsJHDgl/dMhD9yjHAwoumnUk3JydV3QTcIkNDuN40CJxik5+WQ==" crossorigin="anonymous"
		  referrerpolicy="no-referrer"/>
	<link rel="stylesheet"
		  href="https://cdn.datatables.net/buttons/1.6.4/css/buttons.dataTables.min.css">
	<link rel="stylesheet"
		  href="https://cdn.datatables.net/fixedcolumns/3.3.2/css/fixedColumns.dataTables.min.css">
	<link rel="stylesheet"
		  href="https://cdn.datatables.net/fixedheader/3.1.7/css/fixedHeader.dataTables.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script
			src="https://cdn.datatables.net/v/bs4-4.1.1/jq-3.3.1/dt-1.10.21/datatables.min.js"></script>
	<script
			src="https://cdn.datatables.net/fixedcolumns/3.3.2/js/dataTables.fixedColumns.min.js"></script>
	<script
			src="https://cdn.datatables.net/fixedheader/3.1.7/js/dataTables.fixedHeader.min.js"></script>
	<script src="assets/js/dataTables.fixedHeader.min.js"></script>

	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<!-- Select columns -->
	<script src="https://cdn.datatables.net/buttons/1.6.4/js/dataTables.buttons.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.colVis.min.js"></script>
	<!-- Export data -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.html5.min.js"></script>
	<script src="https://cdn.datatables.net/buttons/1.6.4/js/buttons.print.min.js"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.13.3/sweetalert2.min.js"
			integrity="sha512-9FvknuL9tC/meU7bZ0UwSMS7mI9pwepLMdbuP2seYGgmPhgiUnSSp8iAXKvciWHU86cEhzvHiXMVPHH0QXO9Uw=="
			crossorigin="anonymous"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/10.13.3/sweetalert2.min.css"
		  integrity="sha512-A374yR9LJTApGsMhH1Mn4e9yh0ngysmlMwt/uKPpudcFwLNDgN3E9S/ZeHcWTbyhb5bVHCtvqWey9DLXB4MmZg=="
		  crossorigin="anonymous"/>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"
			integrity="sha512-2ImtlRlf2VVmiGZsjm9bEyhjGW4dU7B6TNwh/hx/iSByxNENtj3WVE6o/9Lj4TJeVXPi4bnOIMXFIJJAeufa0A==" crossorigin="anonymous"
			referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/i18n/fr.min.js"
			integrity="sha512-2gJlMVg/vRkqj5vQZOrV+TYi/z/IZIOVbWBWXgcAMOH0BiDYpnmroPRTrUB5iT+IgfxU6OU0D43J2flnbg8lfA==" crossorigin="anonymous"
			referrerpolicy="no-referrer"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css"
		  integrity="sha512-nMNlpuaDPrqlEls3IX/Q56H36qvBASwb3ipuo3MxeWbsQB1881ox0cRv7UPTgBlriqoynt35KjEwgGUeUXIPnw==" crossorigin="anonymous"
		  referrerpolicy="no-referrer"/>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@ttskch/select2-bootstrap4-theme@x.x.x/dist/select2-bootstrap4.min.css">

</head>
<body>

<nav class="navbar navbar-expand-md navbar-dark bg-dark fixed-top">
	<a class="navbar-brand" href="/TDB/"><img src="/TDB/assets/favicon/favicon-32x32.png" alt="logo"/></a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span> Menu
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item<?php echo !empty($_GET) && $_GET['commandes'] == 'encours' ? ' active' : ''; ?>">
				<a class="nav-link" href="/TDB/?commandes=encours"><i class="fas fa-shopping-cart"></i> En cours</a>
			</li>
			<li class="nav-item<?php echo !empty($_GET) && $_GET['commandes'] == 'shop' ? ' active' : ''; ?>">
				<a class="nav-link" href="#" data-toggle="modal" data-target="#shopsModal"><i class="fas fa-shopping-cart"></i> Par club</a>
			</li>
			<li class="nav-item<?php echo !empty($_GET) && $_GET['commandes'] == 'livrees' ? ' active' : ''; ?>">
				<a class="nav-link" href="/TDB/?commandes=livrees"><i class="fas fa-shopping-cart"></i> Livrées</a>
			</li>
			<li class="nav-item<?php echo !empty($_GET) && $_GET['commandes'] == 'toutes' ? ' active' : ''; ?>">
				<a class="nav-link" href="/TDB/?commandes=toutes"><i class="fas fa-shopping-cart"></i> Toutes</a>
			</li>
			<li class="nav-item<?php echo !empty($_GET["guidedestailles"]) ? ' active' : ''; ?>">
				<a class="nav-link" href="/TDB/?guidedestailles=1"><i class="fas fa-arrows-alt-v"></i> Guide des tailles</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#" data-toggle="modal" data-target="#preferencesModal"><i class="fas fa-cogs"></i> Préférences</a>
			</li>
		</ul>
		<span class="navbar-text text-info">Connecté sous <?php echo $employee['4']; ?> <?php echo $employee['3']; ?></span>
	</div>
</nav>

<?php if (empty($_GET)) {
	include('modules/accueil.php');
} elseif (!empty($_GET['guidedestailles'])) {
	include('modules/guidedestailles.php');
} elseif (!empty($_GET['commandes'])) {
	$currentPage = !empty($_GET['page']) ? (int)strip_tags($_GET['page']) : 1;
	$parPage = $_SESSION['pagination'];
	$premier = ($currentPage * $parPage) - $parPage;
	$datas = Dashboard::getOrdersPaginate($parPage, $premier);
	$pages = ceil($datas['nb'] / $parPage);
	$orders = $datas['orders']; ?>

	<div class="content">

		<nav>
			<ul class="pagination justify-content-center">
				<li class="page-item <?= ($currentPage == 1) ? "disabled" : "" ?>">
					<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $currentPage - 1); ?>" class="page-link">
						<i class="fa fa-angle-double-left"></i>
					</a>
				</li>
				<?php for ($page = max($currentPage - 5, 1); $page <= max(1, min($pages, $currentPage + 5)); $page++): ?>
					<li class="page-item <?= ($currentPage == $page) ? "active" : "" ?>">
						<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $page); ?>"
						   class="page-link"><?= $page ?></a>
					</li>
				<?php endfor; ?>
				<li class="page-item <?= ($currentPage == $pages) ? "disabled" : "" ?>">
					<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $currentPage + 1); ?>" class="page-link">
						<i class="fa fa-angle-double-right"></i>
					</a>
				</li>
			</ul>
		</nav>

		<div class="dashboard-buttons" id="dashboard-buttons"></div>

		<div class="search-container mb-5">
			<div class="search-date-container">
				<table class="search-dates" border="0" cellspacing="5" cellpadding="5" id="search-range-date">
					<tbody>
					<tr>
						<td>
							<select name="status" id="status-column" class="form-control">
								<option value="5">NON TRAITÉE</option>
								<option value="22">COMMANDE</option>
								<option value="23">STOCK</option>
								<option value="24">RUPTURE RELIQUAT</option>
								<option value="26">RECU</option>
								<option value="27">MARQUAGE / PRET</option>
								<option value="28">EXPEDITION</option>
								<option value="29">LIVRÉ</option>
							</select>
						</td>
					</tr>
					<tr>
						<td>Date début:</td>
						<td><input type="text" id="start-date" name="start_date"></td>
					</tr>
					<tr>
						<td>Date fin:</td>
						<td><input type="text" id="end-date" name="end_date"></td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-info" id="search-date-range"><span class="fas fa-edit"></span>Chercher</button>
							<button class="btn btn-info" id="reset-search-date-range"><span class="fas fa-edit"></span>Effacer</button>
						</td>
					</tr>
					</tbody>
				</table>
			</div>

			<div class="search-order-id-container">
				<table class="search-order-id" border="0" cellspacing="5" cellpadding="5" id="search-order-id">
					<tbody>
					<tr>
						<td>ID Commande:</td>
						<td><input type="text" id="order-id" name="order_id"></td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-info" id="btn-search-order-id"><span class="fas fa-edit"></span>Chercher</button>
							<button class="btn btn-info" id="btn-reset-order-id"><span class="fas fa-edit"></span>Effacer</button>
						</td>
					</tr>
					</tbody>
				</table>
			</div>

			<div class="search-keyword-container">
				<table class="search-keyword" border="0" cellspacing="5" cellpadding="5" id="search-keyword">
					<tbody>
					<tr>
						<td>Rechercher:</td>
						<td><input type="text" id="keyword" name="keyword"></td>
					</tr>
					<tr>
						<td>
							<button class="btn btn-info" id="btn-search-keyword">
								<span class="fas fa-edit"></span>Chercher
							</button>
							<button class="btn btn-info" id="btn-reset-keyword">
								<span class="fas fa-edit"></span>Effacer
							</button>
						</td>
					</tr>
					</tbody>
				</table>
			</div>
			<button class="btn btn-danger" id="btn-reset-all"><span class="fas fa-edit"></span>Tout Effacer</button>
		</div>

		<table class="display dataTable table table-bordered nowrap" id="dashboard" role="grid" style="width:100%;">
			<thead>
			<tr>
				<th></th>
				<th class="exportable">ID</th>
				<th>Résumé</th>
				<th>Facture</th>
				<th class="exportable">Pays</th>
				<th class="exportable">Boutique</th>
				<th class="exportable">Date</th>
				<th class="exportable">Facture</th>
				<th class="exportable">Nom</th>
				<th class="exportable">Prénom</th>
				<th class="exportable">Catégorie</th>
				<th class="exportable">Référence</th>
				<th class="exportable">Désignation</th>
				<th class="exportable">Marque</th>
				<th class="exportable">Délais</th>
				<th class="exportable">Fournisseur</th>
				<th class="exportable">Quantité</th>
				<th class="exportable">Coloris 1</th>
				<th class="exportable">Coloris 2</th>
				<th class="exportable">Taille</th>
				<th class="exportable">Marquage</th>
				<th>Message</th>
				<th class="exportable">Remarque</th>
				<th class="exportable">Statut</th>
				<th>Statut</th>
				<th class="exportable jaune">Commande</th>
				<th class="roserouge">Rupture&nbsp;/&nbsp;Reliquat</th>
				<th class="exportable roserouge">Rupture&nbsp;/&nbsp;Reliquat</th>
				<th class="exportable bleu">Reçu</th>
				<th class="exportable orange">Marquage</th>
				<th class="exportable vertfonce">Livré</th>
				<th class="exportable">Mode&nbsp;livraison</th>
				<th>Message</th>
				<th class="exportable">Remarque livraison</th>
				<th class="exportable">No&nbsp;suivi</th>
				<th class="exportable">Email</th>
			</tr>
			<tr>
				<td><a data-etat="on" id="togglecheck" class="btn btn-light">Tout</a></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			</thead>
			<tfoot>
			<th></th>
			<th>ID</th>
			<th>Résumé</th>
			<th>Facture</th>
			<th>Pays</th>
			<th>Boutique</th>
			<th>Date</th>
			<th>Facture</th>
			<th>Nom</th>
			<th>Prénom</th>
			<th>Catégorie</th>
			<th>Référence</th>
			<th>Désignation</th>
			<th>Marque</th>
			<th>Délais</th>
			<th>Fournisseur</th>
			<th>Quantité</th>
			<th>Coloris 1</th>
			<th>Coloris 2</th>
			<th>Taille</th>
			<th>Marquage</th>
			<th>Message</th>
			<th>Remarque</th>
			<th>Statut</th>
			<th>Statut</th>
			<th>Commande</th>
			<th class="">Rupture&nbsp;/&nbsp;Reliquat</th>
			<th>Rupture&nbsp;/&nbsp;Reliquat</th>
			<th>Reçu</th>
			<th>Marquage</th>
			<th>Livré</th>
			<th>Mode&nbsp;livraison</th>
			<th>Message</th>
			<th>Remarque livraison</th>
			<th>No&nbsp;suivi</th>
			<th>Email</th>
			</tfoot>
			<tbody>
			<?php $alerts = [0 => [], 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => []];
			$orderMessages = OrderMessage::getOrderMessages(1);
			foreach ($orders as $orderId => $o) {
				$order = new Order((int)$orderId);
				$shop = new Shop($order->id_shop);
				$customer = $order->getCustomer();
				$address = new Address($order->id_address_invoice);
				$details = $order->getOrderDetailList();
				$JsonMessages = Dashboard::getMessages($orderId);
				$messages = json_decode($JsonMessages);
				$dernier_messages_client = false;
				if (!empty($messages)) {
					$m = end($messages);
					if (empty(trim($m->employe))) {
						$dernier_messages_client = true;
					}
				}
				//$carrier = new CarrierCore($order->getIdOrderCarrier());
				$transport = Dashboard::getCarrier($orderId);
				$livraison = Dashboard::getAddress($order->id_address_delivery);
				//$orderStatus[$statutcommande]['name']
				$statutcommande = $order->current_state;
				$fields = Fields::getAllFields('val.id_customer = ' . $customer->id, 1);
				$category = '';
				if (!empty($fields)) {
					$category = $fields[0]['field_value'];
				}
				$i = 0;
				foreach ($details as $detail) {
					$designations = designations($detail['product_name']);
					$classcommande = "";
					if (!$i) {
						$classcommande = "debut";
					}
					if ($i + 1 == count($details)) {
						$classcommande .= " fin";
					}
					$i++;
					$product = new Product($detail['product_id']);
					$cover = Image::getCover($detail['product_id']);
					$imagePath = '';
					if (!empty($cover['id_image'])) {
						$link = new Link;
						$imagePath = $link->getImageLink($product->link_rewrite[1], $cover['id_image'], 'home_default');
					}
					$brand = Manufacturer::getNameById((int)$product->id_manufacturer);
					$supplier = Supplier::getNameById((int)$product->id_supplier);
					$detailId = $detail['id_order_detail'];

                    #$deliveryDatesInfo = DeliveryDateOverride::getDeliveryInfosFromOrder($order);
                    #$deliveryDate = (count($deliveryDatesInfo) > 0 && isset($deliveryDatesInfo[$detailId])) ? $deliveryDatesInfo[$detailId] : '-';

					$attributes = Dashboard::getProductAttributes($detail['product_attribute_id']);
					// getProductCustomizations method sometimes misses informations
                    // Checking first with native method if product has customization or not
                    // If native method says yes then ok
                    // In the other case wa call getProductCustomizations
                    $customizations = [];
                    $customizedDatas = Product::getAllCustomizedDatas((int)$order->id_cart, Context::getContext()->language->id, true, Context::getContext()->shop->id, (int)$detail['id_customization']);
                    if ($customizedDatas) {
                        $customizations = Dashboard::getProductCustomizations($detail['id_customization']);
                    }
					$packs = Dashboard::getProductPacks($orderId, $detail['product_attribute_id']);
					$customText = (!empty($detail['customtext'])) ? ' (' . $detail['customtext'] . ')' : '';
					// Concatenates 2 ids for more convenience.
					$tagId = $orderId . '-' . $detail['product_id'];
					/*if($statutcommande == 5) {
						$status = 5;
					}else{*/
					$status = Dashboard::getStatus($detail['id_order_detail']);
					//}
					Dashboard::setAlerts($order, $product, $detail, $status, $shop, $alerts);
					?>

					<tr id="product-row-<?php
					echo $detailId; ?>" data-order-id="<?php
					echo $orderId; ?>"
						data-order-detail-id="<?php echo $detailId; ?>"
						class="<?php echo $classcommande; ?> statutcommande-<?php echo $statutcommande; ?> status-<?php echo $status['id']; ?>"
						role="row">
						<td><input type="checkbox" name="ag"/></td>
						<td id="info-order-id-<?php echo $detailId; ?>"><?php echo $order->id; ?></td>
						<td>
							<button class="summary btn btn-info" data-detail="<?php echo $detailId; ?>" data-order="<?php echo $orderId; ?>"
									data-product="<?php echo $product->id; ?>"
									data-toggle="modal" data-target="#summaryModal">
								<span class="fas fa-edit"></span>
							</button>
						</td>
						<td>
							<a target="_blank" class="btn btn-info"
							   href="../admin968bkzk7v/index.php?controller=AdminPdf&submitAction=generateInvoicePDF&id_order=<?php
							   echo $orderId; ?><?php /*&token=<?php echo Tools::getAdminTokenLite('AdminPdf');*/ ?>"><i
										class="fas fa-file-invoice"></i></a>
						</td>
						<td id="info-country-<?php echo $detailId; ?>"><?php echo Country::getNameById(1, $livraison['id_country']); ?></td>
						<td><a target="_blank" id="info-shop-<?php
							echo $detailId; ?>"
							   href="../admin968bkzk7v/index.php?controller=AdminOrders&vieworder=&id_order=<?php
							   echo $orderId; ?><?php /*&token=<?php echo Tools::getAdminTokenLite('AdminOrders');*/ ?>"><?php
								echo $shop->name; ?></a>
						</td>
						<td id="info-date-<?php echo $detailId; ?>">
							<?php echo Dashboard::getLocalDate($order->date_add, 'd/m/Y'); ?>
						</td>
						<td id="info-datefacture-<?php echo $detailId; ?>"><?php echo Dashboard::getLocalDate($order->invoice_date, 'd/m/Y'); ?></td>
						<td id="info-last-name-<?php echo $detailId; ?>"><?php echo $customer->lastname; ?></td>
						<td id="info-first-name-<?php echo $detailId; ?>"><?php echo $customer->firstname; ?></td>
						<td id="info-category-<?php echo $detailId; ?>"><?php echo $category; ?></td>
						<td id="info-reference-<?php echo $detailId; ?>"><?php echo $product->reference; ?></td>
						<td id="info-designation-<?php echo $detailId; ?>">
							<?php if (!empty($imagePath) && !preg_match("#/.jpg$#i", $imagePath)) { ?>
								<img src="//<?php echo $imagePath; ?>" alt="" height="100" loading="lazy" class="imgProd"/>
							<?php }
                            if (!empty($detail['product_name'])) {
                                echo $detail['product_name'];
                            }
                            elseif (!empty($designations['designation'])) {
                                echo $designations['designation'];
                            }
                            ?>
						</td>
						<td id="info-brand-<?php echo $detailId; ?>"><?php echo $brand; ?></td>
						<td id="info-deliverydates-<?php echo $detailId; ?>"><?php #echo $deliveryDate; ?></td>
						
						
						<td id="info-supplier-<?php echo $detailId; ?>"><?php echo $supplier; ?></td>
						<td class="<?php echo $detail['product_quantity'] > 1 ? 'qty-alert' : ''; ?>" id="info-quantity-<?php echo $detailId; ?>">
							<?php echo $detail['product_quantity']; ?>
						</td>
						<td id="info-color-1-<?php echo $detailId; ?>">
							<?php echo !empty($designations['declinaisons']['Couleur 1']) ? $designations['declinaisons']['Couleur 1'] : $attributes['color_1']; ?>
						</td>
						<td id="info-color-2-<?php echo $detailId; ?>">
							<?php
							echo !empty($designations['declinaisons']['Couleur 2']) ? $designations['declinaisons']['Couleur 2'] : $attributes['color_2']; ?>
						</td>
						<td id="info-size-<?php echo $detailId; ?>">
							<?php echo !empty($designations['declinaisons']['Taille']) ? $designations['declinaisons']['Taille'] : $attributes['size']; ?>
						</td>
						<td>
							<div class="scrollable" id="info-labeling-<?php echo $detailId; ?>">
								<?php if (!empty($designations['declinaisons']['Je personnalise'])) {
									echo 'Je personnalise : <b>' . $designations['declinaisons']['Je personnalise'] . '</b><br />';
								}
								foreach ($packs as $field) {
									echo $field['name'] . ': <b>' . $field['value'] . '</b><br />';
								}
								foreach ($customizations as $field) {
									echo $field['name'] . ': <b>' . $field['value'] . '</b><br />';
								} ?>
							</div>
						</td>
						<td>
							<script type="application/json" id="message-data-<?php echo $tagId; ?>"><?php echo $JsonMessages; ?></script>
							<button class="edit-message btn <?php echo $dernier_messages_client ? 'btn-danger' : 'btn-secondary'; ?>"
									data-order="<?php echo $orderId; ?>"
									data-product="<?php echo $detail['product_id']; ?>"
									data-employee="<?php echo $employeeId; ?>">
								<span id="nb-messages-<?php echo $tagId; ?>"><?php echo count($messages); ?></span> <i class="fas fa-envelope"></i>
							</button>
						</td>
						<td><textarea name="commentaireprive"><?php echo $detail['commentaireprive'] ?></textarea>
							<button class="sendcommentaire btn btn-light">OK</button>
						</td>
						<td class="status" id="status-label-<?php echo $detailId; ?>" data-currentstatus="<?php echo $status['id']; ?>">
							<?php echo Dashboard::getStatusLabels()[$status['id']]; ?>
						</td>
						<td class="status">
							<button class="summary btn btn-info" id="status-reset-<?php echo $detailId; ?>" data-detail="<?php echo $detailId; ?>">
								<i class="fas fa-edit"></i> Reset
							</button>
						</td>
						<td class="status-date status-odd" id="status-date-label-1-<?php echo $detailId; ?>" data-status="1"
							data-detail="<?php echo $detailId; ?>"
							data-date="<?php echo (isset($status['history'][1])) ? $status['history'][1] : ''; ?>"
							data-order="<?php echo $orderId; ?>" data-employee="<?php echo $employeeId; ?>">
							<?php if (isset($status['history'][1]) && !empty($status['history'][1]) && $status['history'][1] != '0000-00-00') {
								echo Dashboard::getLocalDate($status['history'][1], 'd/m/Y');
							} else { ?>
								Saisir date
								<?php
							} ?>
						</td>
						<td class="status-odd">
							Rupture
							<input type="radio" name="order_status_<?php echo $detailId; ?>" id="status-3-<?php echo $detailId; ?>"
								   value="3" <?php echo ($status['id'] == 3) ? 'checked' : ''; ?> data-detail="<?php echo $detailId; ?>">
							<br> Reliquat
							<input type="radio" name="order_status_<?php echo $detailId; ?>" id="status-4-<?php echo $detailId; ?>"
								   value="4" <?php echo ($status['id'] == 4) ? 'checked' : ''; ?> data-detail="<?php echo $detailId; ?>">
						</td>
						<?php $statusDate = '';
						if ($status['id'] == 3 && !empty($status['history'][3]) && $status['history'][3] != '0000-00-00') {
							$statusDate = $status['history'][3];
						} elseif ($status['id'] == 4 && !empty($status['history'][4]) && $status['history'][4] != '0000-00-00') {
							$statusDate = $status['history'][4];
						} ?>
						<td class="status-date status-odd" id="status-date-label-3-<?php echo $detailId; ?>" data-status="4"
							data-detail="<?php echo $detailId; ?>" data-date="<?php echo $statusDate; ?>"
							data-order="<?php echo $orderId; ?>" data-employee="<?php echo $employeeId; ?>">
							<?php if (!empty($statusDate)) {
								echo Dashboard::getLocalDate($status['history'][$status['id']], 'd/m/Y');
							} else { ?>
								Saisir date
							<?php } ?>
						</td>
						<td class="status-date" id="status-date-label-5-<?php echo $detailId; ?>" data-status="5"
							data-detail="<?php echo $detailId; ?>"
							data-date="<?php echo (isset($status['history'][5])) ? $status['history'][5] : ''; ?>"
							data-order="<?php echo $orderId; ?>" data-employee="<?php echo $employeeId; ?>">
							<?php if (isset($status['history'][5]) && !empty($status['history'][5]) && $status['history'][5] != '0000-00-00') {
								echo Dashboard::getLocalDate($status['history'][5], 'd/m/Y');
							} else { ?>
								Saisir date
							<?php } ?>
						</td>
						<td class="status-date status-odd" id="status-date-label-6-<?php echo $detailId; ?>" data-status="6"
							data-detail="<?php echo $detailId; ?>"
							data-date="<?php echo (isset($status['history'][6])) ? $status['history'][6] : ''; ?>"
							data-order="<?php echo $orderId; ?>" data-employee="<?php echo $employeeId; ?>">
							<?php if (isset($status['history'][6]) && !empty($status['history'][6]) && $status['history'][6] != '0000-00-00') {
								echo Dashboard::getLocalDate($status['history'][6], 'd/m/Y');
							} else { ?>
								Saisir date
							<?php } ?>
						</td>
						<td class="status-date status-odd" id="status-date-label-8-<?php echo $detailId; ?>" data-status="8"
							data-detail="<?php echo $detailId; ?>"
							data-date="<?php echo (isset($status['history'][8])) ? $status['history'][8] : ''; ?>"
							data-order="<?php echo $orderId; ?>" data-employee="<?php echo $employeeId; ?>">
							<?php if (isset($status['history'][8]) && !empty($status['history'][8]) && $status['history'][8] != '0000-00-00') {
								echo Dashboard::getLocalDate($status['history'][8], 'd/m/Y');
							} else { ?>
								Saisir date
							<?php } ?>
						</td>
						<td id="info-delivering-mode-<?php echo $detailId; ?>">
							<?php echo $transport['name'];
							echo !empty($livraison['company']) ? '<br/>' . $livraison['company'] : ''; ?>
						</td>
						<td>
							<button class="edit-message btn <?php echo $dernier_messages_client ? 'btn-danger' : 'btn-secondary'; ?>"
									data-order="<?php echo $orderId; ?>"
									data-product="<?php echo $detail['product_id']; ?>"
									data-employee="<?php echo $employeeId; ?>">
								<i class="fas fa-envelope"></i> <span id="nb-messages-<?php echo $tagId; ?>"><?php echo count($messages); ?></span>
							</button>
						</td>
						<td><textarea name="remarquelivraison"><?php
								echo $detail['remarquelivraison'] ?></textarea>
							<button class="sendremarquelivraison btn btn-light">OK</button>
						</td>
						<td id="info-shipping-number-<?php echo $detailId; ?>"><?php echo $order->getWsShippingNumber(); ?></td>
						<td id="info-mail-<?php echo $detailId; ?>"><?php echo $customer->email; ?></td>
					</tr>
				<?php }
			} ?>
			</tbody>
		</table>

		<h2>Actions groupées</h2>
		<div id="form_ag">
			<select id="status_ag" name="status_ag">
				<option value="0">Non traité</option>
				<option value="1">Commande</option>
				<option value="2">Stock</option>
				<option value="4">Reliquat</option>
				<option value="5">Reçu</option>
				<option value="6">Marquage/prêt</option>
				<option value="8">Livré</option>
			</select>
			<input type="text" id="date_ag" name="date_ag">
			<input type="submit" value="Go" id="go_ag"/>
		</div>

		<p class="btn btn-info" id="factures_ag">Imprimer les factures</p>
		<a href="" id="lienfactures" target="_blank"></a>

		<nav>
			<ul class="pagination justify-content-center">
				<li class="page-item <?= ($currentPage == 1) ? "disabled" : "" ?>">
					<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $currentPage - 1); ?>" class="page-link">
						<i class="fa fa-angle-double-left"></i>
					</a>
				</li>
				<?php for ($page = max($currentPage - 5, 1); $page <= max(1, min($pages, $currentPage + 5)); $page++): ?>
					<li class="page-item <?= ($currentPage == $page) ? "active" : "" ?>">
						<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $page); ?>"
						   class="page-link"><?= $page ?></a>
					</li>
				<?php endfor ?>
				<li class="page-item <?= ($currentPage == $pages) ? "disabled" : "" ?>">
					<a href="<?php echo Dashboard::add_or_update_params($_SERVER['REQUEST_URI'], 'page', $currentPage + 1); ?>" class="page-link">
						<i class="fa fa-angle-double-right"></i>
					</a>
				</li>
			</ul>
		</nav>
	</div>

	<div id="init-alerts">
		<?php for ($i = 0; $i < 9; $i++) {
			$nbAlerts = (count($alerts[$i])) ? '(' . count($alerts[$i]) . ')' : '(0)'; ?>
			<button class="alerts btn <?php echo 'status-' . $i; ?>" data-status="<?php echo $i; ?>">
				<span class="fas fa-edit"></span><?php
				echo Dashboard::getStatusLabels()[$i] . ' ' . $nbAlerts; ?>
			</button>
		<?php } ?>
	</div>

	<script type="application/json" id="status-labels"><?php echo json_encode(Dashboard::getStatusLabels()); ?></script>
	<input type="hidden" name="employee_id" id="employee-id" value="<?php echo $employeeId; ?>">

	<div id="datepicker-stash" style="display: none;">
		<input type="text" id="status-date" name="status_date">
	</div>

<?php include 'modals/messages.php';
include 'modals/scanner.php';
include 'modals/alert_0.php';
include 'modals/alert_1.php';
include 'modals/alert_2.php';
include 'modals/alert_3.php';
include 'modals/alert_4.php';
include 'modals/alert_5.php';
include 'modals/alert_6.php';
include 'modals/alert_7.php';
include 'modals/alert_8.php';
include 'modals/summary.php';
if (!empty($_SESSION['pagination']) && $_SESSION['pagination'] != 10000) { ?>
	<script src="assets/js/datatables_notpaging.js?<?php echo uniqid(); ?>"></script>
<?php }else{ ?>
	<script src="assets/js/datatables.js?<?php echo uniqid(); ?>"></script>
<?php } ?>
<?php }
include 'modals/shops.php';
include 'modals/preferences.php'; ?>

<script src="assets/js/dashboard.js?<?php echo uniqid(); ?>"></script>

</body>
</html>
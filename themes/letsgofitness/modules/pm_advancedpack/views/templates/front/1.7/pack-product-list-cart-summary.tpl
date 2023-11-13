{*
Available fields :
$packProduct['id_pack'] 			-> id_product of the pack
$packProduct['id_product']			-> id_product of a product of the pack
$packProduct['product_name']		-> product name of a product of the pack
$packProduct['attributes']			-> list of product attributes for a product of the pack (group name + group values)
$packProduct['attributes_small']	-> list of product attributes for a product of the pack (group values)
$packProduct['quantity']			-> product quantity of a product of the pack
$packProduct['reduction_amount']	-> product reduction amount or percentage (depends of reduction_type) of a product of the pack
$packProduct['reduction_type']		-> product reduction type (amount or percentage) of a product of the pack
$packProduct['customization_infos']	-> product customization infos (list of id_customization_field => value)
*}
<ul class="ap5_pack_product_list ap5_pack_product_list_cart_summary">
{foreach from=$packProducts item='packProduct'}
	<li
			data-id_product_pack="{$packProduct.id_product_pack}"
			data-id_product="{$packProduct.id_product}"
			data-id_product_attribute="{$packProduct.id_product_attribute}"
			data-id_shop="{$packProduct.id_shop}"
			id="product-{$packProduct.id_product}"
	>
		<span class='label'>{$packProduct['quantity']}x {$packProduct['product_name']|escape:'htmlall':'UTF-8'}</span>
		{if isset($packProduct['attributes']) && !empty($packProduct['attributes'])}{$packProduct['attributes']|escape:'htmlall':'UTF-8'}{/if}
		{if isset($packProduct['customization_infos']) && is_array($packProduct['customization_infos']) && sizeof($packProduct['customization_infos'])}
			<br />
			{foreach from=$packProduct['customization_infos'] item='customizationValue' key='idCustomizationField'}
				{if isset($packProduct['customizationFieldsName'][$idCustomizationField])}
					<span class='labelcustomization'>{$packProduct['customizationFieldsName'][$idCustomizationField]|escape:'htmlall':'UTF-8'}</span>: <span class='valeurcustomization'>{$customizationValue|escape:'htmlall':'UTF-8'}</span><br />
				{else}
					<em>{l s='Customization:' mod='pm_advancedpack'} {$customizationValue|escape:'htmlall':'UTF-8'}</em><br />
				{/if}
			{/foreach}
		{/if}
	</li>
{/foreach}
</ul>
<script type="text/javascript">
	let data = [];
	let getDeliveryDatesUrl = '{$urls.shop_domain_url}/modules/deliverydate/ajaxGetDeliveryDates.php';
	let isCustomizationLine = false;
	$('.ap5_pack_product_list.ap5_pack_product_list_cart_summary li').each(function(index, element) {
		data = {
			'packId': $(element).attr('data-id_product_pack'),
			'productId': $(element).attr('data-id_product'),
			'productAttributeId': $(element).attr('data-id_product_attribute'),
			'shopId': $(element).attr('data-id_shop'),
			'wantedQuantity': 1,
			ajax: true
		};
		$.ajax({
			type: 'POST',
			url: getDeliveryDatesUrl,
			data: data,
			dataType: 'json',
			contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
			success: function(data) {
				isCustomizationLine = ($('#product-' + $(element).attr('data-id_product')).find('.labelcustomization').length === 1);
				if (typeof data.available_text_for_cart !== 'undefined' && !isCustomizationLine) {
					$('#product-' + data.productId).append('<span class="pack-deliverydate-info-line">' + data.available_text_for_cart + '</span>');
				}
			},
			error: function(data) {
				console.log("error data", data);
			}
		});
	});
</script>
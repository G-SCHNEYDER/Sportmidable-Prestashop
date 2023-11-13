<p class="advanceddateofdelivery_container no-print">
	<span id="advanceddateofdelivery_button" class="advanceddateofdelivery_link" href="#" onclick="return false;" rel="nofollow"  title="{l s='Delivery date' mod='advanceddateofdelivery'}">
		{if !$adod_product_page_txt}
			{assign var='delivery_info' value={l s='Delivery date' mod='advanceddateofdelivery'}}
		{else}
			{assign var='delivery_info' value={$adod_product_page_txt|escape:'htmlall':'UTF-8'}}
		{/if}
		<span class="adod_product_page_txt">{$delivery_info|unescape: "html" nofilter}</span>
	</span>
</p>
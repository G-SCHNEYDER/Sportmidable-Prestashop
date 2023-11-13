{**
 * 2007-2019 PrestaShop and Contributors
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to https://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2019 PrestaShop SA and Contributors
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}
<div class="container">
	<div class="row">
        {block name='hook_footer_before'}
            {hook h='displayFooterBefore'}
        {/block}
	</div>
</div>
<div class="footer-container">

    {block name='hook_footer'}
        {hook h='displayFooter'}
    {/block}


	<!-- Start of HubSpot Embed Code -->
	<script type="text/javascript" id="hs-script-loader" async defer src="//js.hs-scripts.com/7612480.js"></script> <!-- End of HubSpot Embed Code -->
</div>

<div class='lastfooter'>
	{assign var='environment' value=$urls.base_url|substr:8:10}
	{assign var='shopName' value=$shop.name}
	{if $shopName == 'Lausanne HC Boutique'}
		{assign var='touUrl' value=$urls.base_url|cat:'content/14-conditions-d-utilisation-lhc'}
		{if $environment == 'newpreprod'}
			{assign var='legalUrl' value=$urls.base_url|cat:'content/11-mentions'}
		{else}
			{assign var='legalUrl' value=$urls.base_url|cat:'content/2-mentions-legales-frch'}
		{/if}
	{else}
		{assign var='legalUrl' value=$urls.base_url|cat:'content/2-information-legales'}
		{if $environment == 'newpreprod'}
			{if $currency.iso_code == 'CHF'}
				{assign var='touUrl' value=$urls.base_url|cat:'content/13-conditions-d-utilisation-ch'}
			{else}
				{assign var='touUrl' value=$urls.base_url|cat:'content/3-conditions-utilisation'}
			{/if}
		{else}
			{if $currency.iso_code == 'CHF'}
				{assign var='touUrl' value=$urls.base_url|cat:'content/13-conditions-d-utilisation-ch'}
			{else}
				{assign var='touUrl' value=$urls.base_url|cat:'content/3-conditions-d-utilisation-fr'}
			{/if}
		{/if}
	{/if}
	<p>
		<a href="{$legalUrl}">Mentions légales</a> -
		<a href="{$touUrl}">Conditions d'utilisation</a>
	</p>
</div>

{foreach from=$toto key="place" item='couleur'}
    {if $place == 1}
        {assign var="maincoul" value=$couleur}
    {/if}
{/foreach}

{assign var='accountDeletionPageId' value=12}
<script>
	let accountDeletionPageUrl = '{url entity='cms' id=$accountDeletionPageId}';
	if (accountDeletionPageUrl.substring(0,'//boutique.sportmidable.com'.length) == '//boutique.sportmidable.com') {
		{assign var='accountDeletionPageId' value=15}
		accountDeletionPageUrl = '{url entity='cms' id=$accountDeletionPageId}';
	}
	accountDeletionPageUrl = 'https:' + accountDeletionPageUrl;
</script>
<style type="text/css">
	body {
		/*background:
	{$maincoul} ;*/
	}

	#wrapper .elementor-widget-button:not(.custom-color-button) .elementor-button, .items-articles-block .current-item-block .block-content a, .maincoul, .elementor-8 .elementor-element.elementor-element-1in7b4l .elementor-button, #topfiltres, .bouton-m, .switch span.actif, .gcsm-header, .btn-primary.focus, .btn-primary:focus, .btn-primary:hover, .btn-primary.disabled.focus, .btn-primary.disabled:focus, .btn-primary.disabled:hover, .btn-primary:disabled.focus, .btn-primary:disabled:focus, .btn-primary:disabled:hover, .btn-primary, .custom-radio input[type=radio]:checked + span, .bootstrap-touchspin .group-span-filestyle .btn-touchspin, .group-span-filestyle .bootstrap-touchspin .btn-touchspin, .group-span-filestyle .btn-default, .page-item.active .page-link, .page-item.active .page-link:focus, .page-item.active .page-link:hover, #main .items-articles-block .current-item-block .block-content .titreactu {
		background-color: {$maincoul}
	}

	#main .maincoul a {
		color: #fff;
	}

	.elementor-6 .elementor-element.elementor-element-wx42egn .slick-slider .slick-prev:before, .elementor-6 .elementor-element.elementor-element-wx42egn .slick-slider .slick-next:before, #blockblogposts_block_left_spm, h1.h2, #topfiltres, #products .product-price-and-shipping, .featured-products .product-price-and-shipping, .product-accessories .product-price-and-shipping, .product-miniature .product-price-and-shipping, .pagination .current a, #product #ariane li span, .sstitre2, .txtaccessoires, .elementor-8 .elementor-element.elementor-element-iml6be1 .slick-slider .slick-prev:before, .elementor-8 .elementor-element.elementor-element-iml6be1 .slick-slider .slick-next:before, .slick-slider .slick-next:before, .slick-slider .slick-prev:before, .post-page .top-post h1, .blog-posts .top-blog h3 a, .block-promo .promo-code-button.cancel-promo, .product-price, .btn-primary.focus, #blockcart-modal .product-name, .has-discount.product-price, .has-discount p {
		color: {$maincoul};
	}

	.page-item.active .page-link, .page-item.active .page-link:focus, .page-item.active .page-link:hover, body#checkout section.checkout-step .address-item.selected {
		border-color: {$maincoul};
	}

	.account-deletion-link {
		margin-top: 16px;
	}
	.account-deletion-link a {
		color: #fff;
	}
	.account-deletion-section p,
	.account-deletion-section label,
	.account-deletion-section textarea::placeholder,
	.account-deletion-section input::placeholder {
		color: #000 !important;
	}
</style>

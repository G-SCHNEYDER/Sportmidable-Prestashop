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
{extends file=$layout}

{block name='head_seo' prepend}
    <link rel="canonical" href="{$product.canonical_url}">
{/block}

{block name='head' append}
    <meta property="og:type" content="product">
    <meta property="og:url" content="{$urls.current_url}">
    <meta property="og:title" content="{$page.meta.title}">
    <meta property="og:site_name" content="{$shop.name}">
    <meta property="og:description" content="{$page.meta.description}">
    <meta property="og:image" content="{$product.cover.large.url}">
    {if $product.show_price}
        <meta property="product:pretax_price:amount" content="{$product.price_tax_exc}">
        <meta property="product:pretax_price:currency" content="{$currency.iso_code}">
        <meta property="product:price:amount" content="{$product.price_amount}">
        <meta property="product:price:currency" content="{$currency.iso_code}">
    {/if}
    {if isset($product.weight) && ($product.weight != 0)}
        <meta property="product:weight:value" content="{$product.weight}">
        <meta property="product:weight:units" content="{$product.weight_unit}">
    {/if}
{/block}


{block name='breadcrumb'}

{/block}


{block name='content'}
    <section id="main" itemscope itemtype="https://schema.org/Product">
        <meta itemprop="url" content="{$product.url}">
        <div class="container">
            <div id="ariane">
                {foreach from=$breadcrumb.links item=path name=breadcrumb}
                    {if $smarty.foreach.breadcrumb.last}{break}{/if}
                    {block name='breadcrumb_item'}
                        <li itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                            <a itemprop="item" href="{$path.url}">
                                <span itemprop="name">{$path.title}</span>
                            </a>
                            <meta itemprop="position" content="{$smarty.foreach.breadcrumb.iteration}">
                        </li>
                    {/block}
                {/foreach}
            </div>
            <div class="row">

                <div class="col-md-6">
                    {block name='page_content_container'}
                        <section class="page-content" id="content">
                            {block name='page_content'}
                                <!-- @todo: use include file='catalog/_partials/product-flags.tpl'} -->
                                {block name='product_flags'}
                                    <ul class="product-flags">
                                        {foreach from=$product.flags item=flag}
                                            <li class="product-flag {$flag.type}">{$flag.label}</li>
                                        {/foreach}
                                    </ul>
                                {/block}

                                {block name='product_cover_thumbnails'}
                                    {include file='catalog/_partials/product-cover-thumbnails.tpl'}
                                {/block}
                                <div class="scroll-box-arrows">
                                    <i class="material-icons left">&#xE314;</i>
                                    <i class="material-icons right">&#xE315;</i>
                                </div>
                            {/block}
                        </section>
                    {/block}
                </div>
                <div class="col-md-6">

                    {assign var="urlManufacturer" value="{_PS_ROOT_DIR_}{'/img/m/'}{$product_manufacturer->id}{'.jpg'}"}
                    {if file_exists($urlManufacturer)}
                        <div class="float-right">
                            <img src="/img/m/{$product_manufacturer->id}.jpg" style="max-width: 100px" />
                        </div>
                    {/if}

                    {block name='page_header_container'}
                        {block name='page_header'}
                            <h1 class="h1" itemprop="name">{block name='page_title'}{$product.name}{/block}</h1>
                        {/block}
                        Réf : {$product.reference_to_display}
                    {/block}


                    <div class="product-information">

                        {block name='product_description_short'}
                            <div id="product-description-short-{$product.id}"
                                 itemprop="description">{$product.description_short nofilter}</div>
                        {/block}

                        <div class="features">
                            {foreach from=$product.features item=feature}
                                {if $feature.name == 'Matière'}
                                    <div style="margin-top:15px;">
                                        <span>{$feature.name}: {$feature.value}</span>
                                    </div>
                                {/if}
                            {/foreach}
                        </div>

                        <div class="product-actions">
                            {block name='product_buy'}
                                <form action="{$urls.pages.cart}" method="post" id="add-to-cart-or-refresh">
                                    <input type="hidden" name="token" value="{$static_token}">
                                    <input type="hidden" name="id_product" value="{$product.id}"
                                           id="product_page_product_id">
                                    <input type="hidden" name="id_customization" value="{$product.id_customization}"
                                           id="product_customization_id">

                                    {block name='product_variants'}
                                        {include file='catalog/_partials/product-variants.tpl'}
                                    {/block}

                                    {block name='product_pack'}
                                        {if $packItems}
                                            <section class="product-pack">
                                                <p class="h4">{l s='This pack contains' d='Shop.Theme.Catalog'}</p>
                                                {foreach from=$packItems item="product_pack"}
                                                    {block name='product_miniature'}
                                                        {include file='catalog/_partials/miniatures/pack-product.tpl' product=$product_pack}
                                                    {/block}
                                                {/foreach}
                                            </section>
                                        {/if}
                                    {/block}

                                    {block name='product_discounts'}
                                        {include file='catalog/_partials/product-discounts.tpl'}
                                    {/block}

                                    <hr/>
                                    {if $product.is_customizable && count($product.customizations.fields)}
                                        <div class='customize'>
                                            <div class="bouton-m"><a data-fancybox="guideduflocage"
                                                                     data-src="#guideduflocage" href="javascript:;">Guide
                                                    du marquage</a></div>
                                        </div>
                                        <div id="guideduflocage" class="container">
                                            <div class="row headerf">
                                                <div class="col-md-6">
                                                    <p class="gras t40">Guide de personnalisation</p>
                                                </div>
                                                <div class="col-md-6 right">
                                                    <p class="gras t24">Emplacement logotage</p>
                                                    <p class="t10">Sportmidable se réserve le droit d’adapter la couleur
                                                        du marquage (noir ou blanc) et les emplacements selon la
                                                        spécificité de chaque produit. Pour les vêtements de pluie/hiver
                                                        (doudoune, parka, coupe vent) le logo peut être en monochrome au
                                                        lieu de quadri dans un but d'augmenter la qualité et la
                                                        durabilité du marquage. Images non contractuelles.
                                                        Contactez-nous pour plus d'informations. </p>
                                                </div>
                                            </div>

                                            <div class="row dflex">
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro</p>
                                                        <img src='/themes/publipresse_theme/assets/img/tshirtdevant.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/tshirtdevant.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>Texte + Numéro</p>
                                                        <p class="ptitexte">Possibilité texte seul ou numéro seul</p>
                                                        <img src='/themes/publipresse_theme/assets/img/tshirtderriere.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/tshirtderriere.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro</p>
                                                        <img src='/themes/publipresse_theme/assets/img/shortlogonumero.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/shortlogonumero.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro</p>
                                                        <img src='/themes/publipresse_theme/assets/img/pantalonlogonumero.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/pantalonlogonumero.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro + texte</p>
                                                        <img src='/themes/publipresse_theme/assets/img/tshirtdevanttexte.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/tshirtdevanttexte.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>Logo</p>
                                                        <img src='/themes/publipresse_theme/assets/img/sac.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/sac.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro + texte</p>
                                                        <img src='/themes/publipresse_theme/assets/img/shortlogonumerotexte.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/shortlogonumerotexte.svg"/>
                                                    </div>
                                                </div>
                                                <div class="col-lg-3 col-md-6 col-sm-12">
                                                    <div class="vignette">
                                                        <p>logo + Numéro + texte</p>
                                                        <img src='/themes/publipresse_theme/assets/img/pantalonnumerotexte.svg'
                                                             class="zoom"
                                                             data-magnify-src="/themes/publipresse_theme/assets/img/pantalonnumerotexte.svg"/>
                                                    </div>
                                                </div>


                                            </div>

                                        </div>
                                        {foreach from=$customizationFields item="csfield"}


                                            {if $csfield.name == "Logo" or $csfield.name == "Logo OUI/NON" or $csfield.name == "Logo NON/OUI"}
                                                <div class="typemarquage inline {if $csfield.required == 1}required{/if}"
                                                     data-field='{$csfield.id_customization_field}'>
                                                    <p class='sstitre2'>
                                                        Logo
                                                    </P>

                                                    <div class="switch switchlogo"
                                                         data-field='{$csfield.id_customization_field}'>
                                                        <span class='avec actif'>AVEC</span>
                                                    </div>
                                                </div>
                                            {elseif $csfield.name == "Logo NON/OUI"}
                                                <div class="typemarquage inline {if $csfield.required == 1}required{/if}">
                                                    <p class='sstitre2'>
                                                        Logo
                                                    </P>

                                                    <div class="switch switchlogo  data-field='{$csfield.id_customization_field}">
                                                        <span class='avec actif'>AVEC</span>
                                                    </div>
                                                </div>
                                            {elseif $csfield.name == "Texte"}
                                                {assign var=texte value="
                        
                          <div class='wrapinput {if $csfield.required == 1}required{/if}'>
                            <input type='text' placeholder='Taper votre texte' data-field='{$csfield.id_customization_field}' />
                            <div class='switch'>
                              <span class='avec actif'>AVEC</span><span class='sans'>SANS</span>
                            </div>
                          </div>
                        "}


                                            {elseif $csfield.name == "Numéro"}
                                                {assign var=numero value="
                              <div class='wrapinput {if $csfield.required == 1}required{/if}'>
                                <input type='text' placeholder='Taper votre numéro' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span><span class='sans'>SANS</span>
                                </div>
                              </div>
                            "}

                                            {elseif $csfield.name == "Nom dos"}
                                                {assign var=nomdos value="
                              <div class='wrapinput {if $csfield.required == 1}required{/if}'>
                                <input type='text' placeholder='Taper votre texte' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span><span class='sans'>SANS</span>
                                </div>
                              </div>
                            "}

                                            {elseif $csfield.name == "Numéro dos"}
                                                {assign var=numerodos value="
                              <div class='wrapinput {if $csfield.required == 1}required{/if}'>
                                <input type='text' placeholder='Taper votre numéro' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span><span class='sans'>SANS</span>
                                </div>
                              </div>
                            "}


                                            {else}
                                                {assign var=personnalisation value="{$personnalisation}
                              <div class='wrapinput {if $csfield.name == 'Marquage obligatoire'}required{/if}'>
                                <input type='text' placeholder='{$csfield.name}' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span>
                                  {if $csfield.name != 'Marquage obligatoire' and $csfield.required == 0}<span class='sans'>SANS</span>{/if}
                                </div>
                              </div>
                            "}


                                            {/if}





                                        {/foreach}

                                        <div id="personnalisation">
                                            {if isset($personnalisation)}
                                                {$personnalisation nofilter}
                                            {/if}
                                        </div>
                                        {block name='product_customization'}
                                            {include file="catalog/_partials/product-customization.tpl" customizations=$product.customizations}
                                        {/block}
                                    {/if}

                                    <div class="fulldescription_produit">
                                        <p>{$product.description nofilter}</p>
                                    </div>
                                    
                                    <div id="prixajout">
                                        {block name='product_prices'}
                                            {include file='catalog/_partials/product-prices.tpl'}
                                        {/block}

                                        {block name='product_add_to_cart'}
                                            {include file='catalog/_partials/product-add-to-cart.tpl'}
                                        {/block}

                                    </div>
                                    <div id="unavailable-product" class="hidden">
                                        <i class="material-icons product-unavailable">&#xE14B;</i>Produit indisponible
                                    </div>

                                    {block name='product_additional_info'}
                                        {include file='catalog/_partials/product-additional-info.tpl'}
                                    {/block}

                                    {* Input to refresh product HTML removed, block kept for compatibility with themes *}
                                    {block name='product_refresh'}{/block}
                                </form>
                            {/block}

                        </div>



                        {block name='hook_display_reassurance'}
                            {hook h='displayReassurance'}
                        {/block}

                        {block name='product_tabs'}
                            {block name='product_details'}
                                {include file='catalog/_partials/product-details.tpl'}
                            {/block}
                        {/block}
                    </div>
                </div>
            </div>
        </div>

        {block name='product_accessories'}
            {if $accessories}
                <section class="product-accessories clearfix">
                    <div class="container">
                        <div class='txtaccessoires'>
                            Ces articles pourraient vous plaire
                        </div>

                        <div class="products">
                            {foreach from=$accessories item="product_accessory"}
                                {block name='product_miniature'}
                                    {include file='catalog/_partials/miniatures/product.tpl' product=$product_accessory}
                                {/block}
                            {/foreach}
                        </div>
                    </div>
                </section>
            {/if}
        {/block}

        {block name='product_footer'}
            {hook h='displayFooterProduct' product=$product category=$category}
        {/block}

        {block name='product_images_modal'}
            {include file='catalog/_partials/product-images-modal.tpl'}
        {/block}

        {block name='page_footer_container'}
            <footer class="page-footer">
                {block name='page_footer'}
                    <!-- Footer content -->
                {/block}
            </footer>
        {/block}
    </section>
{/block}

{**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Open Software License (OSL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/osl-3.0.php
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   http://opensource.org/licenses/osl-3.0.php Open Software License (OSL 3.0)
 * International Registered Trademark & Property of PrestaShop SA
 *}

{if is_array($customizationFields) && $customizationFields|@count > 0}

<div id="customizationprices">
    <div class="card card-block">
      <h3 class="h4 card-title">{l s='Product customization' mod='customizationprices'}</h3>
      {l s='Don\'t forget to save your customization to be able to add to cart' mod='customizationprices'}
      <form id="customizationFormModule" method="post" action="{$link->getProductLink($id_product)|escape:'html':'UTF-8'}" enctype="multipart/form-data">
          <input type="hidden" name="saveCustomization" value="1" />
            <input type="hidden" name="id_product_attribute" id="customization_id_product_attribute" value="0" />
            <input type="hidden" name="product_quantity" id="product_quantity" value="1" />
        <ul class="clearfix">

          {foreach from=$customizationFields item="field"}
            <li class="product-customization-item">
                <label> {$field.name|escape:'html':'UTF-8'} {if $field.price > 0}(<strong>+{Tools::displayPrice($field.price)|escape:'html':'UTF-8'}</strong>){/if}</label>
              {if $field.type == 'text'}
                <textarea placeholder="{l s='Your message here' mod='customizationprices'}" class="product-message" maxlength="250" {if $field.required} required {/if} name="textField{$field.id_customization_field|intval}" data-tarif="{$field.price}"></textarea>
                <small class="pull-xs-right">{l s='250 char. max' mod='customizationprices'}</small>
              {elseif $field.type == 'image'}
                <span class="custom-file">
                  <span class="js-file-name">{l s='No selected file' mod='customizationprices'}</span>
                  <input class="file-input js-file-input" {if $field.required} required {/if} type="file" name="{$field.input_name|escape:'html':'UTF-8'}">
                  <button class="btn btn-primary">{l s='Choose file' mod='customizationprices'}</button>
                </span>
                <small class="pull-xs-right">{l s='.png .jpg .gif' mod='customizationprices'}</small>
              {/if}
            </li>
          {/foreach}
        </ul>
        <div class="clearfix">
            <button id="saveCustomization" href="#" class="btn btn-primary pull-xs-right"{if !$productLazy.add_to_cart_url} disabled{/if}>
                <i class="material-icons shopping-cart">&#xE547;</i>
                <span>{l s='Save and add to cart' mod='customizationprices'}</span>
            </button>
        </div>
      </form>
    </div>
  <input type="hidden" name="idCombination" id="idCombination" value="{$productLazy.id_product_attribute|intval}">
</div>

{/if}
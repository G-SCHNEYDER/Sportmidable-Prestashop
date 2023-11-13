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
{block name='order_products_table'}
  <div class="box hidden-sm-down">
    <table id="order-products" class="table table-bordered">
      <thead class="thead-default">
        <tr>
          <th>{l s='Product' d='Shop.Theme.Catalog'}</th>
          <th>{l s='Quantity' d='Shop.Theme.Catalog'}</th>
          <th>{l s='Unit price' d='Shop.Theme.Catalog'}</th>
          <th>{l s='Total price' d='Shop.Theme.Catalog'}</th>
        </tr>
      </thead>
      
      {foreach from=$order.products item=product}
        {assign var=remarquelivraison value=OrderDetailCore::getRemarqueLivraison($product['id_order_detail'])}
        {assign var=status value=OrderDetailCore::getOrderDetailStatus($product['id_order_detail'])}

        {foreach from=$status key=k item=v}
          {assign var=statusname value=$v.name}
          {assign var=statusid value=$v.id_status}
          {assign var=statusdate value=$v.date|date_format:"%d-%m-%Y"}
        {/foreach}

        <tr>
          <td>
            <strong>
              <a {if isset($product.download_link)}href="{$product.download_link}"{/if}>
                {$product.name}{if $product.customtext} <br><span style='color:red'>{$product.customtext}</span>{/if}
                {if $status|@count > 0 && $statusid == 1}
                  <br><span style='color:#e2cf88'>En cours de livraison depuis notre fournisseur</span>
                {/if}

                {if $status|@count > 0 && $statusid == 4}
                  <br><span style='color:red'>Disponible à partir du {"$statusdate + 15 Days"|date_format:"%d-%m-%Y"}</span>
                
                {/if}

                {if $status|@count > 0 && $statusid == 3}
                  <br><span style='color:red'>Actuellement indisponible chez le fournisseur</span>
                
                {/if}

                {if $status|@count > 0 && $statusid == 5}
                  <br><span style='color:#66ccff'>Réceptionné, marquage en cours</span>
                
                {/if}

                {if $status|@count > 0 && $statusid == 6}
                  <br><span style='color:#ff9933'>Prêt</span>
                
                {/if}

                {if $status|@count > 0 && $statusid == 8}
                  <br><span style='color:green'>Livré</span>
                {/if}

                {if $remarquelivraison != ""}
                  <div id="remarquelivraison">
                    <span style="color:#000">Remarques concernant la livraison : </b>{$remarquelivraison}</span>
                  </div>
                {/if}

                {if isset($product.id_order_detail)}
                    {assign var='id_order_detail' value={$product.id_order_detail}}
                    {if isset($availabilityInfos[{$id_order_detail}])}<p>{$availabilityInfos[{$id_order_detail}].available_text_for_cart}</p>{/if}
                {/if}

              </a>
            </strong><br/>
            {if $product.reference}
              {l s='Reference' d='Shop.Theme.Catalog'}: {$product.reference}<br/>
            {/if}
            {if $product.customizations}
              {foreach from=$product.customizations item="customization"}
                <div class="customization">
                  <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                </div>
                <div id="_desktop_product_customization_modal_wrapper_{$customization.id_customization}">
                  <div class="modal fade customization-modal" id="product-customizations-modal-{$customization.id_customization}" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                      <div class="modal-content">
                        <div class="modal-header">
                          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                          </button>
                          <h4 class="modal-title">{l s='Product customization' d='Shop.Theme.Catalog'}</h4>
                        </div>
                        <div class="modal-body">
                          {foreach from=$customization.fields item="field"}
                            <div class="product-customization-line row">
                              <div class="col-sm-3 col-xs-4 label">
                                {$field.label}
                              </div>
                              <div class="col-sm-9 col-xs-8 value">
                                {if $field.type == 'text'}
                                  {if (int)$field.id_module}
                                    {$field.text nofilter}
                                  {else}
                                    {$field.text}
                                  {/if}
                                {elseif $field.type == 'image'}
                                  <img src="{$field.image.small.url}">
                                {/if}
                              </div>
                            </div>
                          {/foreach}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              {/foreach}
            {/if}
          </td>
          <td>
            {if $product.customizations}
              {foreach $product.customizations as $customization}
                {$customization.quantity}
              {/foreach}
            {else}
              {$product.quantity}
            {/if}
          </td>
          <td class="text-xs-right">{$product.price}</td>
          <td class="text-xs-right">{$product.total}</td>
        </tr>
      {/foreach}
      <tfoot>
        {foreach $order.subtotals as $line}
          {if $line.value}
            <tr class="text-xs-right line-{$line.type}">
              <td colspan="3">{$line.label}</td>
              <td>{$line.value}</td>
            </tr>
          {/if}
        {/foreach}
        <tr class="text-xs-right line-{$order.totals.total.type}">
          <td colspan="3">{$order.totals.total.label}</td>
          <td>{$order.totals.total.value}</td>
        </tr>
      </tfoot>
    </table>
  </div>

  <div class="order-items hidden-md-up box">
    {foreach from=$order.products item=product}
      <div class="order-item">
        <div class="row">
          <div class="col-sm-5 desc">
            <div class="name">{$product.name}</div>
            {if $product.reference}
              <div class="ref">{l s='Reference' d='Shop.Theme.Catalog'}: {$product.reference}</div>
            {/if}
            {if $product.customizations}
              {foreach $product.customizations as $customization}
                <div class="customization">
                  <a href="#" data-toggle="modal" data-target="#product-customizations-modal-{$customization.id_customization}">{l s='Product customization' d='Shop.Theme.Catalog'}</a>
                </div>
                <div id="_mobile_product_customization_modal_wrapper_{$customization.id_customization}">
                </div>
              {/foreach}
            {/if}
          </div>
          <div class="col-sm-7 qty">
            <div class="row">
              <div class="col-xs-4 text-sm-left text-xs-left">
                {$product.price}
              </div>
              <div class="col-xs-4">
                {if $product.customizations}
                  {foreach $product.customizations as $customization}
                    {$customization.quantity}
                  {/foreach}
                {else}
                  {$product.quantity}
                {/if}
              </div>
              <div class="col-xs-4 text-xs-right">
                {$product.total}
              </div>
            </div>
          </div>
        </div>
      </div>
    {/foreach}
  </div>
  <div class="order-totals hidden-md-up box">
    {foreach $order.subtotals as $line}
      {if $line.value}
        <div class="order-total row">
          <div class="col-xs-8"><strong>{$line.label}</strong></div>
          <div class="col-xs-4 text-xs-right">{$line.value}</div>
        </div>
      {/if}
    {/foreach}
    <div class="order-total row">
      <div class="col-xs-8"><strong>{$order.totals.total.label}</strong></div>
      <div class="col-xs-4 text-xs-right">{$order.totals.total.value}</div>
    </div>
  </div>
{/block}

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



{block name="left_column"}
    <h1 class='h2'>{$category.name}</h1>
    <div id="topfiltres">
        <div id='tri'>
            {include file='catalog/_partials/sort-orders.tpl' sort_orders=$listing.sort_orders}
        </div>
    </div>
{/block}

{block name='breadcrumb'}
{/block}

{block name='content_wrapper'}
    {*
    <div id="ariane">
        {foreach from=$breadcrumb.links item=path name=breadcrumb}
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
    *}
    <section id="main" class="row mt-3">

        <div class="col-xs-12 col-sm-4 col-md-3">
            {hook h="displayLeftColumn"}
        </div>
        <div class="left-column col-xs-12 col-sm-8 col-md-9">
            <section id="products">
                {if $listing.products|count}
                    <div>
                        {block name='product_list_top'}
                            {include file='catalog/_partials/products-top.tpl' listing=$listing}
                        {/block}
                    </div>
                    <div>
                        {block name='product_list'}
                            {include file='catalog/_partials/products.tpl' listing=$listing}
                        {/block}
                    </div>
                    <div id="js-product-list-bottom">
                        {block name='product_list_bottom'}
                            {include file='catalog/_partials/products-bottom.tpl' listing=$listing}
                        {/block}
                    </div>
                {else}
                    <div id="js-product-list-top"></div>
                    <div id="js-product-list">
                        {include file='errors/not-found.tpl'}
                    </div>
                    <div id="js-product-list-bottom"></div>
                {/if}
            </section>
        </div>

    </section>
{/block}

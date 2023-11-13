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
<div id="_desktop_cart">
    <div class="blockcart cart-preview " data-refresh-url="{$refresh_url}">
        <div class="header">
            {if $cart.products_count > 0}
            <a rel="nofollow" href="{$cart_url}">
                {/if}
                <span class="hidden-sm-down">{l s='Mon panier' d='Shop.Theme.Checkout'}</span>
                <svg xmlns="http://www.w3.org/2000/svg" width="18.106" height="22.897" viewBox="0 0 18.106 22.897">
                    <g id="shop-bag_1_" data-name="shop-bag(1)" transform="translate(-51.683 0)">
                        <path id="Tracé_15" data-name="Tracé 15" d="M69.782,20.595,68.568,5.577a.8.8,0,0,0-.8-.734H65.387V4.65a4.651,4.651,0,0,0-9.3,0v.193H53.7a.8.8,0,0,0-.8.734L51.69,20.595a2.13,2.13,0,0,0,2.123,2.3H67.659a2.13,2.13,0,0,0,2.123-2.3ZM57.683,4.651a3.053,3.053,0,0,1,6.107,0v.193H57.683ZM68.051,21.128a.527.527,0,0,1-.392.172H53.813a.532.532,0,0,1-.531-.576L54.438,6.441h1.648V10.4a.8.8,0,0,0,1.6,0V6.441h6.107V10.4a.8.8,0,0,0,1.6,0V6.441h1.648L68.19,20.724a.527.527,0,0,1-.139.4Z"/>
                    </g>
                </svg>
                <span class="cart-products-count">{$cart.products_count}</span>
                {if $cart.products_count > 0}
            </a>
            {/if}
        </div>
    </div>
</div>

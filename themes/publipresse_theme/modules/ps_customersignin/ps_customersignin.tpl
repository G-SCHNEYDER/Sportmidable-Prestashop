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
<div id="_desktop_user_info">
  <div class="user-info">
    {if $logged}
      <a
        class="account"
        href="{$my_account_url}"
        title="{l s='View my customer account' d='Shop.Theme.Customeraccount'}"
        rel="nofollow"
      >
          <svg xmlns="http://www.w3.org/2000/svg" width="19.239" height="19.239" viewBox="0 0 19.239 19.239">
              <path id="account" d="M.93,19.365a.875.875,0,0,0,1.749,0,7.813,7.813,0,0,1,4.546-7.11,6.085,6.085,0,0,0,6.659-.007,7.98,7.98,0,0,1,2.23,1.553,7.82,7.82,0,0,1,2.306,5.564.875.875,0,0,0,1.749,0,9.557,9.557,0,0,0-2.818-6.8A9.684,9.684,0,0,0,15.278,11,6.122,6.122,0,1,0,5.813,11,9.562,9.562,0,0,0,.93,19.365ZM10.549,2.749A4.373,4.373,0,1,1,6.176,7.122,4.378,4.378,0,0,1,10.549,2.749Z" transform="translate(-0.93 -1)"/>
          </svg>
      </a>
    {else}
      <a
        href="{$my_account_url}"
        title="{l s='Log in to your customer account' d='Shop.Theme.Customeraccount'}"
        rel="nofollow"
      >
          <svg xmlns="http://www.w3.org/2000/svg" width="19.239" height="19.239" viewBox="0 0 19.239 19.239">
              <path id="account" d="M.93,19.365a.875.875,0,0,0,1.749,0,7.813,7.813,0,0,1,4.546-7.11,6.085,6.085,0,0,0,6.659-.007,7.98,7.98,0,0,1,2.23,1.553,7.82,7.82,0,0,1,2.306,5.564.875.875,0,0,0,1.749,0,9.557,9.557,0,0,0-2.818-6.8A9.684,9.684,0,0,0,15.278,11,6.122,6.122,0,1,0,5.813,11,9.562,9.562,0,0,0,.93,19.365ZM10.549,2.749A4.373,4.373,0,1,1,6.176,7.122,4.378,4.378,0,0,1,10.549,2.749Z" transform="translate(-0.93 -1)"/>
          </svg>
      </a>
    {/if}
  </div>
</div>

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

{if $configuration.topHeaderDisplay}
    {block name='header_top_custom'}
        <div class="header-top-custom">
            {hook h='displayTopHeader'}
        </div>
    {/block}
{/if}

{block name='header_banner'}
    <div class="header-banner">
        {hook h='displayBanner'}
    </div>
{/block}

{block name='header_nav'}
    <nav class="header-nav">
        <div class="container-fluid">
            <div class="row vcenter">

                {if $configuration.topHeaderDisplay}
                    <div class="mobile-logo"></div>
                    <div class="col-xs-8 col-sm-9">
                        {hook h = 'displayMegaMenu'}
                    </div>
                    <div class="col-xs-4 col-sm-3 left header-nav-utils-container">
                        {hook h='displayNav2'}
                        <div class="float-xs-right" id="_mobile_cart"></div>
                        <div class="float-xs-right" id="_mobile_user_info"></div>
                        <a id="lienrecherche" href="#search" class="icoHeader"><i class="fa fa-search" aria-hidden="true"></i></a>
                    </div>
                {else}
                    <div class="col-md-3 col-sm-3 col-xs-3">
                        {hook h='displayNav1'}
                    </div>
                    <div class="col-md-3 col-sm-9 col-xs-9 center">
                        {*<a id="home" href='{$urls.base_url}'><i class="fa fa-home"></i>Accueil</a>*}
                        <div id="logo"><a href="{$urls.base_url}"><img src="{$urls.img_url}/logo.svg" /></a></div>
                    </div>
                    <div class="col-md-6 right-nav">
                        <a id="lienhome" href="{$urls.base_url}" class="icoHeader"><i class="fa fa-home" aria-hidden="true"></i></a>
                        {hook h='displayNav2'}
                        <div class="float-xs-right" id="_mobile_cart"></div>
                        <div class="float-xs-right" id="_mobile_user_info"></div>
                        <a id="lienrecherche" href="#search" class="icoHeader"><i class="fa fa-search" aria-hidden="true"></i></a>
                        <a id="liencontact" href="{$urls.pages.contact}" class="icoHeader"><i class="fa fa-comment" aria-hidden="true"></i></a>
                        <a target="_blank" href="https://www.facebook.com/Sportmidable/" class="icoHeader"><i class="fa fa-facebook" aria-hidden="true"></i></a>
                        <a target="_blank" href="https://www.instagram.com/sportmidable/" class="icoHeader"><i class="fa fa-instagram" aria-hidden="true"></i></a>
                        <a target="_blank" href="https://fr.linkedin.com/company/sportmidable" class="icoHeader"><i class="fa fa-linkedin" aria-hidden="true"></i></a>
                        <div class="mobile"></div>
                    </div>
                    <div class="hidden-md-up text-sm-center mobile">
                        <div class="float-xs-left" id="menu-icon">
                            <i class="material-icons d-inline">&#xE5D2;</i>
                        </div>

                        <div class="top-logo" id="_mobile_logo"></div>
                        <div class="clearfix"></div>
                    </div>
                {/if}

            </div>
        </div>
    </nav>
    {hook h='displayTop'}
{/block}



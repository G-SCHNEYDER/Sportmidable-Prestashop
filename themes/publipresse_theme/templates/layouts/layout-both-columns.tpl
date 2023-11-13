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
<!doctype html>
<html lang="{$language.iso_code}">

    <head>

        {assign var='environment' value=$urls.base_url|substr:8:10}
        {if $environment == 'newpreprod'}
            {assign var='xamaxShopName' value='Neuchâtel Xamax by Sportmidable'}
        {else}
            {assign var='xamaxShopName' value='Boutique officielle de Neuchâtel Xamax – opérée par Sportmidable'}
        {/if}

        {if $shop.name !== $xamaxShopName}
        {literal}
            <!-- Google Tag Manager for all sites -->
            <script>(function(w, d, s, l, i) {
                    w[l] = w[l] || [];
                    w[l].push({'gtm.start': new Date().getTime(), event: 'gtm.js'});
                    var f = d.getElementsByTagName(s)[0],
                        j = d.createElement(s), dl = l != 'dataLayer' ? '&l=' + l : '';
                    j.async = true;
                    j.src = 'https://www.googletagmanager.com/gtm.js?id=' + i + dl;
                    f.parentNode.insertBefore(j, f);
                })(window, document, 'script', 'dataLayer', 'GTM-M8P3NPB');</script>
            <!-- End Google Tag Manager for all sites -->
        {/literal}
        {else}
        {literal}
            <!-- Google tag (gtag.js) for XAMAX -->
            <script async src="https://www.googletagmanager.com/gtag/js?id=G-FJK7DR8SXW"></script>
            <script>
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', 'G-FJK7DR8SXW');
            </script>
            <!-- End Google tag (gtag.js) for XAMAX -->
        {/literal}
        {/if}

        {block name='head'}
            {include file='_partials/head.tpl'}
        {/block}

        {block name='javascript_bottom'}
            {include file="_partials/javascript.tpl" javascript=$javascript.bottom}
        {/block}

        {*<script src="/themes/publipresse_theme/assets/js/intlTelInput.js"></script>
        <script src="/themes/publipresse_theme/assets/js/jquery.magnify.js"></script>*}

    </head>

    <body id="{$page.page_name}" class="{$page.body_classes|classnames}">

    {if $shop.name !== $xamaxShopName}
        <!-- Google Tag Manager (noscript) for all sites -->
        <noscript>
            <iframe src="https://www.googletagmanager.com/ns.html?id=GTM-M8P3NPB"
                    height="0" width="0" style="display:none;visibility:hidden"></iframe>
        </noscript>
        <!-- End Google Tag Manager (noscript) for all sites -->
    {/if}

        {block name='hook_after_body_opening_tag'}
            {hook h='displayAfterBodyOpeningTag'}
        {/block}

        <main>
            {block name='product_activation'}
                {include file='catalog/_partials/product-activation.tpl'}
            {/block}

            <header id="header">
                {block name='header'}
                    {include file='_partials/header.tpl'}
                {/block}
            </header>

            {block name='notifications'}
                {include file='_partials/notifications.tpl'}
            {/block}

            <section id="wrapper">
                {hook h="displayWrapperTop"}
                {if $page.page_name != 'index' && $page.page_name != 'product'}
                <div class="container">
                    {/if}
                    {block name='breadcrumb'}
                        {include file='_partials/breadcrumb.tpl'}
                    {/block}

                    {block name="left_column"}
                        <div id="left-column" class="col-xs-12 col-sm-4 col-md-3">
                            {if $page.page_name == 'product'}
                                {hook h='displayLeftColumnProduct'}
                            {else}
                                {hook h="displayLeftColumn"}
                            {/if}
                        </div>
                    {/block}

                    {block name="content_wrapper"}
                        <div id="content-wrapper" class="left-column right-column col-sm-4 col-md-6">
                            {hook h="displayContentWrapperTop"}
                            {block name="content"}
                                <p>Hello world! This is HTML5 Boilerplate.</p>
                            {/block}
                            {hook h="displayContentWrapperBottom"}
                        </div>
                    {/block}

                    {block name="right_column"}
                        <div id="right-column" class="col-xs-12 col-sm-4 col-md-3">
                            {if $page.page_name == 'product'}
                                {hook h='displayRightColumnProduct'}
                            {else}
                                {hook h="displayRightColumn"}
                            {/if}
                        </div>
                    {/block}
                    {if $page.page_name != 'index'}
                </div>
                {/if}
                {hook h="displayWrapperBottom"}
            </section>

            <footer id="footer">
                {block name="footer"}
                    {include file="_partials/footer.tpl"}
                {/block}
            </footer>

        </main>

        {block name='hook_before_body_closing_tag'}
            {hook h='displayBeforeBodyClosingTag'}
        {/block}

    </body>

</html>

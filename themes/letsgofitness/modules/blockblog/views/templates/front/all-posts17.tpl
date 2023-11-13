{*
/**
 * StorePrestaModules SPM LLC.
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the EULA
 * that is bundled with this package in the file LICENSE.txt.
 *
 /*
 *
 * @author    StorePrestaModules SPM
 * @category content_management
 * @package blockblog
 * @copyright Copyright StorePrestaModules SPM
 * @license   StorePrestaModules SPM
 */
*}

{extends file='page.tpl'}






{block name="content_wrapper"}



<div id="content-wrapper" class="card card-block {if isset($blockblogsidebar_posblog_alias) && $blockblogsidebar_posblog_alias == 1}left-column col-xs-12 col-sm-8 col-md-9{elseif isset($blockblogsidebar_posblog_alias) && $blockblogsidebar_posblog_alias == 2}right-column col-xs-12 col-sm-8 col-md-9{/if}">
    {block name="content"}


       

    {if $blockblogis16 == 0}
        <h2 class="background-none">{$meta_title|escape:'htmlall':'UTF-8'}</h2>
    {else}
        <h1 class="h2">{$meta_title|escape:'htmlall':'UTF-8'}</h1>
    {/if}





    


    <div class="blog-header-toolbar">
        {if $count_all > 0}

            <div class="toolbar-top">

                <div class="{if $blockblogis16==1}sortTools sortTools16{else}sortTools{/if}">
                    

                   

                </div>

            </div>



            <ul class="blog-posts {if $blockblogblog_layout_typeblog_alias == 2}blockblog-grid-view{elseif $blockblogblog_layout_typeblog_alias == 3}blockblog-grid-view-second{else}blockblog-list-view{/if}" id="blog-items">
                {assign var=is_all_posts_page value=1}

                {include file="module:blockblog/views/templates/front/list_posts.tpl"}



            </ul>





            <div class="toolbar-paging">
                <div class="text-align-center" id="page_nav">
                    {$paging nofilter}
                </div>
            </div>







        {else}
            <div class="block-no-items">
                {l s='There are not posts yet' mod='blockblog'}
            </div>
        {/if}

    </div>
{/block}

</div>

    {block name="right_column"}
        {if isset($blockblogsidebar_posblog_alias) && $blockblogsidebar_posblog_alias == 2}
            <div id="right-column" class="col-xs-12 col-sm-4 col-md-3">
                {hook h="displayRightColumn"}
            </div>
        {/if}

    {/block}


{/block}

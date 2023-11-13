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

<div id="blockblogposts_block_left_spm" class="block {if $blockblogis17 == 1}block-categories{/if} {if $blockblogis16 == 1}blockmanufacturer16{else}blockmanufacturer{/if} blockblog-block" >

		<div class="block_content">

            {if count($blockblogposts) > 0}
            <h2>Actualités</h2>

            <div class="items-articles-block">

                {foreach from=$blockblogposts item=items name=myLoop1}
                {foreach from=$items.data item=blog name=myLoop}
                <div class="current-item-block">

                    {if $blockblogblock_display_img == 1}
                        {if strlen($blog.img)>0}
                            <div class="block-side">
                                  <img src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$blog.img|escape:'htmlall':'UTF-8'}"
                                       title="{$blog.title|escape:'htmlall':'UTF-8'}" alt="{$blog.title|escape:'htmlall':'UTF-8'}"  />
                            </div>
                        {/if}
                    {/if}

                    <div class="block-content">
                        <div class="titreactu">
                            <a class="item-article" title="{$blog.title|escape:'htmlall':'UTF-8'}"
                           href="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$blog.seo_url|escape:'htmlall':'UTF-8'}{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$blog.id|escape:'htmlall':'UTF-8'}{/if}"
                                >{$blog.title|escape:'htmlall':'UTF-8'}</a>
                        </div>

                        <div class='textactu'>{$blog.content nofilter}</div>
                        
                      

                        <div class="clr"></div>
                    </div>
                </div>

                {/foreach}
                {/foreach}
                

            </div>
            <p class="block-view-all">
                        <a href="{$blockblogposts_url|escape:'htmlall':'UTF-8'}" title="{l s='View all posts' mod='blockblog'}" class="{if $blockblogis17 == 1}btn btn-default button button-small-blockblog{/if} button"
                                >Voir toutes les actualités</a>
                </p>
            {else}
                
            {/if}

		</div>
	</div>




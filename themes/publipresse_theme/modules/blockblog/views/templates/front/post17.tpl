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

{block name="left_column"}
    {if isset($blockblogsidebar_posblog_post_alias) && $blockblogsidebar_posblog_post_alias == 1}
        <div id="left-column" class="col-xs-12 col-sm-4 col-md-3">
            {hook h="displayLeftColumn"}
        </div>
    {/if}
{/block}



<div id="content-wrapper" class="card card-block {if isset($blockblogsidebar_posblog_post_alias) && $blockblogsidebar_posblog_post_alias == 1}left-column col-xs-12 col-sm-8 col-md-9{elseif isset($blockblogsidebar_posblog_post_alias) && $blockblogsidebar_posblog_post_alias == 2}right-column col-xs-12 col-sm-8 col-md-9{/if}">
    {block name="content"}



    {capture name=path}
        <a href="{$blockblogposts_url|escape:'htmlall':'UTF-8'}">
            <span>Actualités</span>
        </a>
        <span class="navigation-pipe">&gt;</span>
        {$meta_title|escape:'htmlall':'UTF-8'}

    {/capture}

    <div class="blog-post-item">

        {foreach from=$posts item=post name=myLoop}
            <div class="post-page" itemscope itemtype="http://schema.org/Article">

                <meta itemscope itemprop="mainEntityOfPage"  itemType="https://schema.org/WebPage" itemid="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}{/if}"/>

                <meta itemprop="datePublished" content="{$post.time_add_rss|escape:'htmlall':'UTF-8'}"/>
                <meta itemprop="dateModified" content="{$post.time_add_rss|escape:'htmlall':'UTF-8'}"/>
                <meta itemprop="headline" content="{$post.title|escape:'htmlall':'UTF-8'}"/>
                <meta itemprop="alternativeHeadline" content="{$post.title|escape:'htmlall':'UTF-8'}"/>

        <span itemprop="author" itemscope itemtype="https://schema.org/Person">
             <meta itemprop="name" content="{$post.author|escape:'htmlall':'UTF-8'}"/>
        </span>


        <span itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
            <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
                <meta itemprop="url" content="{$base_dir_ssl|escape:'htmlall':'UTF-8'}img/logo.jpg">
                <meta itemprop="width" content="600">
                <meta itemprop="height" content="60">
            </span>
            <meta itemprop="name" content="{$blockblogsnip_publisher|escape:'htmlall':'UTF-8'}">
        </span>

                <div itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
                    {if strlen($post.img)>0}
                        <meta itemprop="url" content="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$post.img|escape:'htmlall':'UTF-8'}">
                        <meta itemprop="width" content="{$blockblogsnip_width|escape:'htmlall':'UTF-8'}">
                        <meta itemprop="height" content="{$blockblogsnip_height|escape:'htmlall':'UTF-8'}">

                    {else}
                        <meta itemprop="image" content="{$base_dir_ssl|escape:'htmlall':'UTF-8'}img/logo.jpg"/>
                        <meta itemprop="width" content="600">
                        <meta itemprop="height" content="60">
                    {/if}
                </div>

                <meta itemprop="description" content="{$post.content|strip_tags|mb_substr:0:140 nofilter}"/>

                {if strlen($post.img)>0}
                    <div class="image">
                        <img src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$post.img|escape:'htmlall':'UTF-8'}"
                             alt="{$post.title|escape:'htmlall':'UTF-8'}" class="img-responsive1" />
                    </div>
                {/if}


                <div class="top-post">


                    <h1 class="h2">{$post.title nofilter}</h1>
                    <div class="clear"></div>

                        <p class="float-left">

                            {if $blockblogpost_display_date == 1}
                            <time datetime="{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}" pubdate="pubdate"
                                    >{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}</time>
                            {/if}


                            

                        </p>


                    
                    <div class="clear"></div>

                    {if $blockblogis_cat_bp == 1}
                    {if $is_active == 1}

                        <p class="float-left">

                            <i class="fa fa-folder-open-o"></i>&nbsp;
                            {foreach from=$category_data item=category_item name=catItemLoop}
                                {if isset($category_item.title)}
                                    <a href="{if $blockblogurlrewrite_on == 1}
                                                {$blockblogcategory_url|escape:'htmlall':'UTF-8'}{$category_item.seo_url|escape:'htmlall':'UTF-8'}
                                             {else}
                                                {$blockblogcategory_url|escape:'htmlall':'UTF-8'}{$category_item.id|escape:'htmlall':'UTF-8'}
                                             {/if}"
                                       title="{$category_item.title|escape:'htmlall':'UTF-8'}"
                                       class="posted_in">{$category_item.title|escape:'htmlall':'UTF-8'}</a>
                                    {if isset($post.category_ids) && count($post.category_ids)>1}
                                        {if $smarty.foreach.catItemLoop.first},&nbsp;{elseif $smarty.foreach.catItemLoop.last}&nbsp;{else},&nbsp;{/if}
                                    {/if}

                                {/if}
                            {/foreach}

                        </p>
                        <div class="clear"></div>
                    {/if}
                    {/if}

                </div>





                <div class="body-post">
                    {$post.content nofilter}
                </div>

                <div class="social-sharing">
                    <ul>
                        <li class="facebook icon-gray"><a href="http://www.facebook.com/sharer.php?u={$urls.current_url}" class="text-hide" title="Partager" target="_blank">Partager</a></li>
                    </ul>
                </div>


                <div class="top-post">

                    {if $blockblogis_tags_bp == 1}

                    {if isset($post.tags)}
                        <div class="float-left"><span class="tags-blockblog-txt">{l s='Tags' mod='blockblog'}:</span>{foreach from=$post.tags item=tag_item}<a href="{$blockblogtag_url|escape:'htmlall':'UTF-8'}{$tag_item|escape:'htmlall':'UTF-8'}" class="tag-blockblog">{$tag_item|escape:'htmlall':'UTF-8'}</a>{/foreach}<div class="clear"></div> </div>
                    {/if}

                    {/if}

                    <p class="float-right comment">

                        {if $blockblograting_postp == 1}
                            {if $post.avg_rating != 0}
                                <span class="rating-input margin-right-10">

                            {for $foo=0 to 4}
                                {if $foo < $post.avg_rating}
                                    <i class="fa fa-star" data-value="{$foo|escape:'htmlall':'UTF-8'}"></i>

                                {else}
                                    <i class="fa fa-star-o" data-value="{$foo|escape:'htmlall':'UTF-8'}"></i>
                                {/if}

                            {/for}


                        </span>
                            {/if}
                        {/if}


                       

                    </p>
                    <div class="clear"></div>
                </div>





            </div>
        {/foreach}






        {if count($related_products)>0}
            <div class="rel-products-block {if $blockblogrelpr_slider == 1}owl_blog_related_products_type_carousel{/if}">
                <h4 class="related-products-title"><i class="fa fa-book fa-lg"></i>&nbsp;{l s='Related Products' mod='blockblog'}</h4>


                <ul {if $blockblogrelpr_slider == 1}class="owl-carousel owl-theme"{/if}>
                    {foreach from=$related_products item=product name=myLoop}
                        <li {if $blockblogrelpr_slider == 0}class="no-slider"{/if}>
                            {if $product.picture}
                                <a title="{$product.title|escape:'htmlall':'UTF-8'}" href="{$product.product_url|escape:'htmlall':'UTF-8'}" class="products-block-image">
                                    <img alt="{$product.title|escape:'htmlall':'UTF-8'}" src="{$product.picture|escape:'htmlall':'UTF-8'}"
                                         {if $blockblogrelpr_slider == 1}class="img-responsive"{/if}/>
                                </a>
                            {/if}
                            <div class="clear"></div>
                            <div class="product-content">
                                <h5>
                                    <a title="{$product.title|escape:'htmlall':'UTF-8'}" href="{$product.product_url|escape:'htmlall':'UTF-8'}"
                                       class="product-name">
                                        {$product.title nofilter}
                                    </a>
                                </h5>
                                <p class="product-description">{$product.description|strip_tags|mb_substr:0:$blockblogblog_rp_tr nofilter}{if strlen($product.description)>$blockblogblog_rp_tr}...{/if}</p>
                            </div>
                        </li>
                    {/foreach}

                </ul>

                <div class="clear"></div>
            </div>
        {/if}





        {if count($related_posts)>0}





            <div class="rel-posts-block {if $blockblogrelp_slider == 1}owl_blog_related_posts_type_carousel{/if}">

                <h4 class="related-posts-title"><i class="fa fa-list-alt fa-lg"></i>&nbsp;{l s='Related Posts' mod='blockblog'}</h4>

                <div class="other-posts">



                    <ul class="{if $blockblogrelp_slider == 1}owl-carousel owl-theme{else}row-custom{/if}">
                        {foreach from=$related_posts item=relpost name=myLoop}
                            <li {if $blockblogrelp_slider == 0}class="col-sm-4-custom"{/if}>
                                {if strlen($relpost.img)>0}
                                    <div class="block-top">
                                        <a title="{$relpost.title|escape:'htmlall':'UTF-8'}"
                                           href="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.seo_url|escape:'htmlall':'UTF-8'}{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.id|escape:'htmlall':'UTF-8'}{/if}">
                                            <img alt="{$relpost.title|escape:'htmlall':'UTF-8'}"
                                                 src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$relpost.img|escape:'htmlall':'UTF-8'}"
                                                 {if $blockblogrelp_slider == 1}class="img-responsive"{/if}>
                                        </a>
                                    </div>
                                {/if}


                                <div class="block-content"><h4 class="block-heading">
                                        <a title="{$relpost.title|escape:'htmlall':'UTF-8'}"
                                           href="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.seo_url|escape:'htmlall':'UTF-8'}{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.id|escape:'htmlall':'UTF-8'}{/if}"
                                                >{$relpost.title|escape:'htmlall':'UTF-8'}</a></h4>

                                    {if $blockblograting_postrp == 1}
                                        {if $relpost.avg_rating != 0}
                                            <span class="rating-input margin-right-10">
                            {for $foo=0 to 4}
                                {if $foo < $relpost.avg_rating}
                                    <i class="fa fa-star" data-value="{$foo|escape:'htmlall':'UTF-8'}"></i>

                                {else}
                                    <i class="fa fa-star-o" data-value="{$foo|escape:'htmlall':'UTF-8'}"></i>
                                {/if}

                            {/for}


                            </span>
                                        {/if}
                                    {/if}
                                </div>
                                <div class="block-footer">
                                    <p class="float-left">
                                        <time pubdate="pubdate" datetime="{$relpost.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}"
                                                ><i class="fa fa-clock-o fa-lg"></i>&nbsp;&nbsp;{$relpost.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}
                                        </time>
                                    </p>
                                    <p class="float-right comment">

                                        {if $blockblogpostrel_views}
                                            <i class="fa fa-eye fa-lg"></i>&nbsp;<span class="blockblog-views">({$relpost.count_views|escape:'htmlall':'UTF-8'})</span>&nbsp;&nbsp;
                                        {/if}

                                        {if $relpost.is_liked_post}
                                            <i class="fa fa-thumbs-up fa-lg"></i>&nbsp;(<span class="the-number">{$relpost.count_like|escape:'htmlall':'UTF-8'}</span>)
                                        {else}
                                            <span class="post-like-{$relpost.id|escape:'htmlall':'UTF-8'}">
                            <a onclick="blockblog_like_post({$relpost.id|escape:'htmlall':'UTF-8'},1)"
                               href="javascript:void(0)"><i class="fa fa-thumbs-o-up fa-lg"></i>&nbsp;(<span class="the-number">{$relpost.count_like|escape:'htmlall':'UTF-8'}</span>)</a>
                        </span>
                                        {/if}

                                        {if $relpost.is_comments || $relpost.count_comments > 0}
                                            &nbsp;
                                            <a href="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.seo_url|escape:'htmlall':'UTF-8'}#blogcomments{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$relpost.id|escape:'htmlall':'UTF-8'}#blogcomments{/if}"
                                               title="{$relpost.title|escape:'htmlall':'UTF-8'}"
                                                    ><i class="fa fa-comments-o fa-lg"></i>&nbsp;{$relpost.count_comments|escape:'htmlall':'UTF-8'}</a>
                                        {/if}


                                    </p>

                                    <div class="clear"></div>
                                </div>
                            </li>
                        {/foreach}

                    </ul>

                </div>
                <div class="clear"></div>


            </div>
        {/if}


        {if $blockblogis16==1}<div class="clear"></div>{/if}
        {if $count_all>0}
            <div class="blog-block-comments" id="blogcomments">

                <div class="toolbar-top">

                    <div class="{if $blockblogis16==1}sortTools sortTools16{else}sortTools{/if}">
                        <ul class="actions">
                            <li class="frst">
                                <strong><i class="fa fa-comments-o fa-lg"></i>&nbsp;{l s='Comments' mod='blockblog'}  ( {$count_all|escape:'htmlall':'UTF-8'} )</strong>
                            </li>
                        </ul>
                    </div>

                </div>
                <div class="clear"></div>


                <div class="post-comments-items" id="blog-items">



                    {include file="module:blockblog/views/templates/front/list_postcomments.tpl"}



                </div>
                <div class="clear"></div>


                <div class="toolbar-paging">
                    <div class="text-align-center" id="page_nav">
                        {$paging nofilter}
                    </div>
                </div>

                <div class="clear"></div>


            </div>
        {else}
            <div id="blogcomments"></div>

        {/if}



        {if $post.is_comments == 0}
        {if count($comments)>0}
            <br/>
            <div class="block-no-items no-registered-blockblog" id="blogcomments">
                {l s='Comments are Closed for this post' mod='blockblog'}
            </div>
        {/if}
        {else}

            <div id="succes-comment">
                {l s='Your comment  has been sent successfully. Thanks for comment!' mod='blockblog'}
            </div>



            <div class="leaveComment-title"><i class="fa fa-comment-o fa-lg"></i> {l s='Leave a Comment' mod='blockblog'}</div>


        {if $blockblogid_customer == 0 && $blockblogwhocanaddc == 2}
            <div class="no-registered-blockblog">
                <div class="text-no-reg">
                    {l s='You cannot post a comment because you are not logged as a customer' mod='blockblog'}
                </div>
                <br/>

                <div class="no-reg-button">
                    <a href="{$blockblogmy_account nofilter}"
                       class="btn-custom btn-primary-custom" >{l s='Log in / sign up' mod='blockblog'}</a>
                </div>

            </div>
        {else}

            <div id="leaveComment">


                <div class="alert alert-danger display-none" id="alert-comment"></div>
                <div class="alert alert-success display-none" id="alertsuccess-comment"></div>
                <form action="#" method="post" class="form-horizontal add-comment-form" id="commentform">

                    <div class="form-group {if $blockblogid_customer != 0}display-none{/if}">
                        <label class="control-label col-xs-3-custom" for="name-blockblog">{l s='Name' mod='blockblog'}:<span class="req">*</span></label>
                        <div class="col-xs-9-custom">
                            <input type="text" class="form-control" id="name-blockblog" {if $blockblogid_customer != 0}value="{$blockblogname_c|escape:'htmlall':'UTF-8'}"{else}placeholder="{l s='Name' mod='blockblog'}"{/if} onkeyup="check_inpName_blockblog();" onblur="check_inpName_blockblog();" />
                            <div id="error_name-blockblog" class="errorTxtAdd"></div>
                        </div>
                        <div class="clear"></div>

                    </div>
                    <div class="form-group {if $blockblogid_customer != 0}display-none{/if}">
                        <label class="control-label col-xs-3-custom" for="email-blockblog">{l s='Email' mod='blockblog'}:<span class="req">*</span></label>
                        <div class="col-xs-9-custom">
                            <input type="email" class="form-control" id="email-blockblog" {if $blockblogid_customer != 0}value="{$blockblogemail_c|escape:'htmlall':'UTF-8'}"{else}placeholder="{l s='Email' mod='blockblog'}"{/if} onkeyup="check_inpEmail_blockblog();" onblur="check_inpEmail_blockblog();"/>
                            <div id="error_email-blockblog" class="errorTxtAdd"></div>
                        </div>
                        <div class="clear"></div>

                    </div>
                    {if $blockblogava_on == 1 && $blockblogava_list_displ_cpost == 1}
                    <div class="form-group">
                        <label class="control-label col-xs-3-custom">{l s='Avatar' mod='blockblog'}</label>
                        <div class="col-xs-9-custom">
                        {if $blockblogid_customer != 0}
                            {if strlen($blockblogc_avatar)>0}
                                <div class="avatar-blockblog-post-form">
                                    <img src="{$blockblogc_avatar|escape:'htmlall':'UTF-8'}" alt="{$blockblogname_c|escape:'htmlall':'UTF-8'}" />
                                </div>
                            {/if}
                        {else}
                                <div class="avatar-blockblog-post-form">
                                        <img src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}modules/blockblog/views/img/logo_comments.png">
                                </div>
                        {/if}
                        </div>
                        <div class="clear"></div>
                    </div>
                    {/if}

                    <div class="form-group">
                        <label class="control-label col-xs-3-custom" for="comment-blockblog">{l s='Comment' mod='blockblog'}:<span class="req">*</span></label>
                        <div class="col-xs-9-custom">
                            <textarea rows="3" class="form-control" id="comment-blockblog" placeholder="{l s='Comment' mod='blockblog'}" onkeyup="check_inpText_blockblog();" onblur="check_inpText_blockblog();"></textarea>
                            <div id="error_comment-blockblog" class="errorTxtAdd"></div>
                        </div>
                        <div class="clear"></div>

                    </div>
                    <div class="form-group">
                        <label class="control-label col-xs-3-custom" for="rating-blockblog">{l s='Rating' mod='blockblog'}:<span class="req">*</span></label>
                        <div class="col-xs-9-custom">

                            <input type="number" name="rating-blockblog" id="rating-blockblog" class="ratingblockblog"/>

                            <div id="error_rating-blockblog" class="errorTxtAdd"></div>
                        </div>
                        <div class="clear"></div>

                    </div>



                   {* gdpr *}
                        {hook h='displayGDPRConsent' mod='psgdpr' id_module=$id_module}
                   {* gdpr *}


                    {if $blockblogis_captcha_com == 1}
                    <div class="form-group">
                        <label class="control-label col-xs-3-custom" for="captcha-blockblog">{l s='Captcha' mod='blockblog'}:<span class="req">*</span></label>
                        <div class="col-xs-9-custom">

                            {if $blockblogbcaptcha_type == 1}
                            <img width="100" height="26" alt="{l s='Captcha' mod='blockblog'}" class="float-left secureCodReview" id="secureCodReview"
                                 src="{$blockblogcaptcha_url|escape:'htmlall':'UTF-8'}"/>

                            <input type="text" class="form-control inpCaptcha" id="captcha-blockblog" onkeyup="check_inpCaptcha_blockblog();" onblur="check_inpCaptcha_blockblog();" />
                            {else}
                            <div class="g-recaptcha" id="g-recaptcha-blockblog" data-sitekey="{$blockblogbcaptcha_site_key|escape:'htmlall':'UTF-8'}"></div>
                            {/if}

                            <div class="clear"></div>
                            <div id="error_captcha-blockblog" class="errorTxtAdd"></div>
                        </div>
                        <div class="clear"></div>

                    </div>
                    {/if}

                    <div class="form-group">
                        <div class="col-xs-offset-3-custom col-xs-9-custom">
                            <input type="button" onclick="add_comment({$post.id|escape:'htmlall':'UTF-8'})" class="btn-custom btn-primary-custom" value="{l s='Comment' mod='blockblog'}"/>
                        </div>
                        <div class="clear"></div>

                    </div>

                    <div class="clear"></div>
                </form>




            </div>


        {literal}
            <script type="text/javascript">

                var blockblog_msg_name = '{/literal}{$blockblog_msg_name|escape:'htmlall':'UTF-8'}{literal}';
                var blockblog_msg_em = '{/literal}{$blockblog_msg_em|escape:'htmlall':'UTF-8'}{literal}';
                var blockblog_msg_comm = '{/literal}{$blockblog_msg_comm|escape:'htmlall':'UTF-8'}{literal}';
                var blockblog_msg_cap = '{/literal}{$blockblog_msg_cap|escape:'htmlall':'UTF-8'}{literal}';
                var blockblog_msg_rate = '{/literal}{$blockblog_msg_rate|escape:'htmlall':'UTF-8'}{literal}';
                var blockblogcaptcha_url = '{/literal}{$blockblogcaptcha_url|escape:'htmlall':'UTF-8'}{literal}';

                var blockblogis_captcha_com = {/literal}{$blockblogis_captcha_com|escape:'htmlall':'UTF-8'}{literal};
                var blockblogbcaptcha_type = {/literal}{$blockblogbcaptcha_type|escape:'htmlall':'UTF-8'}{literal};

                var blockblogid_module = {/literal}{$id_module|escape:'htmlall':'UTF-8'}{literal};




                document.addEventListener("DOMContentLoaded", function(event) {
                    $(document).ready(function(){
                        blockblog_post_page_init();
                    });
                });

            </script>
        {/literal}


            {/if}


        {/if}




        {if $post.is_fbcomments == 1}
            <div class="fcomment-title"><i class="fa fa-facebook fa-lg"></i> {l s='Facebook comments' mod='blockblog'}</div>

            <div class="fcomment-content">
                <div id="fb-root"></div>
                {literal}
                  <script type="text/javascript">
                    (function(d, s, id) {
                        var js, fjs = d.getElementsByTagName(s)[0];
                        if (d.getElementById(id)) return;
                        js = d.createElement(s); js.id = id;
                        js.src = "//connect.facebook.net/{/literal}{$blockbloglng_iso|escape:'htmlall':'UTF-8'}{literal}/all.js#xfbml=1&appid={/literal}{$blockblogappid|escape:'htmlall':'UTF-8'}{literal}";
                        fjs.parentNode.insertBefore(js, fjs);
                    }(document, 'script', 'facebook-jssdk'));</script>
                {/literal}

                <div class="fb-comments" data-href="{if $blockblogurlrewrite_on == 1}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}{else}{$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}{/if}"
                     data-numposts="{$blockblognumber_fc|escape:'htmlall':'UTF-8'}" data-width="100%" data-mobile="false"></div>


            </div>

        {/if}


    </div>




{literal}
    <script type="text/javascript">

        {/literal}{if $blockblogrelpr_slider == 1}{literal}
        var blockblog_number_product_related_slider = {/literal}{$blockblognpr_slider|escape:'htmlall':'UTF-8'}{literal};
        {/literal}{/if}{literal}

        {/literal}{if $blockblogrelp_slider == 1}{literal}
        var blockblog_number_posts_slider = {/literal}{$blockblognp_slider|escape:'htmlall':'UTF-8'}{literal};
        {/literal}{/if}{literal}

    </script>
{/literal}







        </div>
    {/block}



    {block name="right_column"}
        {if isset($blockblogsidebar_posblog_post_alias) && $blockblogsidebar_posblog_post_alias == 2}
            <div id="right-column" class="col-xs-12 col-sm-4 col-md-3">
                {hook h="displayRightColumn"}
            </div>
        {/if}

    {/block}




{/block}

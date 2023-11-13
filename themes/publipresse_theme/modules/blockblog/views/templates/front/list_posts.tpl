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

{foreach from=$posts item=post name=myLoop}
    <li class="pl-animate {$blockblogblog_post_effect|escape:'htmlall':'UTF-8'}">

        {if (isset($blockblogblog_layout_typeblog_alias) && $blockblogblog_layout_typeblog_alias == 3 && isset($is_all_posts_page) && $is_all_posts_page == 1) ||
            (isset($blockblogblog_layout_typeblog_cat_item_alias) && $blockblogblog_layout_typeblog_cat_item_alias == 3 && isset($is_category_page) && $is_category_page == 1) ||
            (isset($blockblogblog_layout_typeblog_tag_alias) && $blockblogblog_layout_typeblog_tag_alias == 3 && isset($is_tag_page) && $is_tag_page == 1) ||
            (isset($blockblogblog_layout_typeblog_author_alias) && $blockblogblog_layout_typeblog_author_alias == 3 && isset($is_author_page) && $is_author_page == 1)}

            {if strlen($post.img)>0}
                <div class="post_image">
                    <a title="{$post.title|escape:'htmlall':'UTF-8'}"
                       href="{if $blockblogurlrewrite_on == 1}
                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}
                      {else}
                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}
                      {/if}">
                        <img class="img-responsive" alt="{$post.title|escape:'htmlall':'UTF-8'}"
                             src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$post.img|escape:'htmlall':'UTF-8'}">
                    </a>
                    {if $blockblogp_list_displ_date == 1}
                        <div class="date_added">
                            <span class="d">{$post.time_add|date_format:"%d"}</span>
                            <span class="m">{l s={$post.time_add|date_format:"%b"} d='Shop.Theme.Untranslatables'}</span>
                        </div>
                    {/if}
                </div>
            {/if}
            <br/>
            <div class="block-content post_content">
                <div class="sdsarticleHeader">
                    <h5><a title="{$post.title|escape:'htmlall':'UTF-8'}"
                           href="{if $blockblogurlrewrite_on == 1}
                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}
                      {else}
                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}
                      {/if}">{$post.title|escape:'htmlall':'UTF-8'}</a></h5>
                </div>
                <div class="sdsarticle-info">
                    <p class="float-left">
                        {*if $blockblogp_list_displ_date == 1}
                        <time datetime="{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}" pubdate="pubdate"
                                ><i class="fa fa-clock-o fa-lg"></i>&nbsp;{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}</time>
                        {/if*}

                        {if $post.is_show_ava == 0 || $post.status_author == 0 || ($blockblogava_on == 0 || $blockblogava_list_displ == 0)}&nbsp;<i class="fa fa-user"></i>{/if}&nbsp;{if $post.is_show_ava == 1 && $post.status_author == 1 && ($blockblogava_on == 1 && $blockblogava_list_displ == 1)}<span class="avatar-block-rev">
                            <img alt="{$post.author|escape:'htmlall':'UTF-8'}" src="{$post.avatar|escape:'htmlall':'UTF-8'}" />
                        </span>&nbsp;<a href="{$blockblogauthor_url|escape:'htmlall':'UTF-8'}{$post.author_id|escape:'htmlall':'UTF-8'}-{$post.author|escape:'htmlall':'UTF-8'}"
                                        title="{$post.author|escape:'htmlall':'UTF-8'}"
                                        class="blog_post_author" rel="nofollow">{/if}{$post.author|escape:'htmlall':'UTF-8'}{if $post.is_show_ava == 1 && $post.status_author == 1 && ($blockblogava_on == 1 && $blockblogava_list_displ == 1)}</a>{/if}


                    </p>

                    <p class="float-right comment">
                        {if $blockblograting_postl == 1}
                            {if $post.avg_rating != 0}
                                <span class="rating-input float-left margin-right-10">

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

                        {if $blockblogpostl_views}
                            <i class="fa fa-eye fa-lg"></i>&nbsp;<span class="blockblog-views">({$post.count_views|escape:'htmlall':'UTF-8'})</span>&nbsp;&nbsp;
                        {/if}

                        {if $post.is_liked_post}
                            <i class="fa fa-thumbs-up fa-lg"></i>&nbsp;(<span class="the-number">{$post.count_like|escape:'htmlall':'UTF-8'}</span>)
                        {else}
                            <span class="post-like-{$post.id|escape:'htmlall':'UTF-8'}">
                                <a onclick="blockblog_like_post({$post.id|escape:'htmlall':'UTF-8'},1)"
                                   href="javascript:void(0)"><i class="fa fa-thumbs-o-up fa-lg"></i>&nbsp;(<span class="the-number">{$post.count_like|escape:'htmlall':'UTF-8'}</span>)</a>
                            </span>
                        {/if}

                        {if $post.is_comments || $post.count_comments > 0}
                            &nbsp;
                            <i class="fa fa-comments-o fa-lg"></i>&nbsp; <a href="{if $blockblogurlrewrite_on == 1}
                                                                                    {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}#blogcomments
                                                                                  {else}
                                                                                    {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}#blogcomments
                                                                                  {/if}"
                                                                            title="{$post.title|escape:'htmlall':'UTF-8'}"
                                >{$post.count_comments|escape:'htmlall':'UTF-8'} {l s='comments' mod='blockblog'}</a>
                        {/if}
                    </p>
                    <div class="clear"></div>
                    <p class="m-a-0">{$post.content|truncate:170 nofilter}</p>
                    <div class="clear"></div>
                </div>
                <h6 class=readmore>
                    <a href="{if $blockblogurlrewrite_on == 1}
                    {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}
                  {else}
                    {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}
                  {/if}">
                        <i class="fa fa-caret-right"></i>
                        {$blockblogtext_readmore nofilter}
                    </a>
                </h6>
            </div>




        {else}

        <div class="top-blog">

            <h2 class='h1'>
                <a title="{$post.title|escape:'htmlall':'UTF-8'}"
                   href="{if $blockblogurlrewrite_on == 1}
                            {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}
                          {else}
                            {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}
                          {/if}
                        "
                        >{$post.title|escape:'htmlall':'UTF-8'}</a>

            </h2>




            {if isset($post.category_ids[0].title)}
                <p class="float-left">
                    <i class="fa fa-folder-open-o"></i>&nbsp;
                    {foreach from=$post.category_ids item=category_item name=catItemLoop}
                        <a href="{if $blockblogurlrewrite_on == 1}
                                                {$blockblogcategory_url|escape:'htmlall':'UTF-8'}{$category_item.seo_url|escape:'htmlall':'UTF-8'}
                                             {else}
                                                {$blockblogcategory_url|escape:'htmlall':'UTF-8'}{$category_item.id|escape:'htmlall':'UTF-8'}
                                             {/if}"
                           title="{$category_item.title|escape:'htmlall':'UTF-8'}" class="posted_in">{$category_item.title|escape:'htmlall':'UTF-8'}</a>
                        {if count($post.category_ids)>1}
                            {if $smarty.foreach.catItemLoop.first},&nbsp;{elseif $smarty.foreach.catItemLoop.last}&nbsp;{else},&nbsp;{/if}
                        {else}
                        {/if}

                    {/foreach}
                </p>
            {/if}


            <div class="clear"></div>
        </div>

        <div class="row-custom">
            {if strlen($post.img)>0}
                <div class="col-sm-4-custom">
                    <div class="photo-blog">
                        <img class="img-responsive" alt="{$post.title|escape:'htmlall':'UTF-8'}"
                             src="{$base_dir_ssl|escape:'htmlall':'UTF-8'}{$blockblogpic|escape:'htmlall':'UTF-8'}{$post.img|escape:'htmlall':'UTF-8'}">
                    </div>
                </div>
            {/if}
            <div class="col-sm-{if strlen($post.img)>0}8{else}12{/if}-custom">
                <div class="body-blog">
                    {$post.content|mb_substr:0:$blockblogblog_pl_tr nofilter}{if strlen($post.content)>$blockblogblog_pl_tr}...{/if}
                    {if strlen($blockblogtext_readmore)>0}
                    <br>
                    <a title="{$post.title|escape:'htmlall':'UTF-8'}" class="btn readmore"
                       href="{if $blockblogurlrewrite_on == 1}
                                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}
                                     {else}
                                        {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}
                                     {/if}">{$blockblogtext_readmore nofilter}</a>
                    {/if}
                </div>
            </div>
        </div>

        <div class="clear"></div>

        <div class="top-blog">

                <p class="float-left">
                    {if $blockblogp_list_displ_date == 1}
                    <time datetime="{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}" pubdate="pubdate"
                            ><i class="fa fa-clock-o fa-lg"></i>&nbsp;{$post.time_add|date_format:$blockblogblog_date|escape:'htmlall':'UTF-8'}</time>
                    {/if}

                    {if $post.is_show_ava == 0 || $post.status_author == 0 || ($blockblogava_on == 0 || $blockblogava_list_displ == 0)}&nbsp;<i class="fa fa-user"></i>{/if}&nbsp;{if $post.is_show_ava == 1 && $post.status_author == 1 && ($blockblogava_on == 1 && $blockblogava_list_displ == 1)}<span class="avatar-block-rev">
                        <img alt="{$post.author|escape:'htmlall':'UTF-8'}" src="{$post.avatar|escape:'htmlall':'UTF-8'}" />
                    </span>&nbsp;<a href="{$blockblogauthor_url|escape:'htmlall':'UTF-8'}{$post.author_id|escape:'htmlall':'UTF-8'}-{$post.author|escape:'htmlall':'UTF-8'}"
                                    title="{$post.author|escape:'htmlall':'UTF-8'}"
                                    class="blog_post_author">{/if}{$post.author|escape:'htmlall':'UTF-8'}{if $post.is_show_ava == 1 && $post.status_author == 1 && ($blockblogava_on == 1 && $blockblogava_list_displ == 1)}</a>{/if}


                </p>

            <p class="float-right comment">

                {if $blockblograting_postl == 1}
                    {if $post.avg_rating != 0}
                <span class="rating-input float-left margin-right-10">

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

                {if $blockblogpostl_views}
                    <i class="fa fa-eye fa-lg"></i>&nbsp;<span class="blockblog-views">({$post.count_views|escape:'htmlall':'UTF-8'})</span>&nbsp;&nbsp;
                {/if}

                {if $post.is_liked_post}
                    <i class="fa fa-thumbs-up fa-lg"></i>&nbsp;(<span class="the-number">{$post.count_like|escape:'htmlall':'UTF-8'}</span>)
                {else}
                    <span class="post-like-{$post.id|escape:'htmlall':'UTF-8'}">
                            <a onclick="blockblog_like_post({$post.id|escape:'htmlall':'UTF-8'},1)"
                               href="javascript:void(0)"><i class="fa fa-thumbs-o-up fa-lg"></i>&nbsp;(<span class="the-number">{$post.count_like|escape:'htmlall':'UTF-8'}</span>)</a>
                        </span>
                {/if}

                {if $post.is_comments || $post.count_comments > 0}
                &nbsp;
                <i class="fa fa-comments-o fa-lg"></i>&nbsp; <a href="{if $blockblogurlrewrite_on == 1}
                                                                                {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.seo_url|escape:'htmlall':'UTF-8'}#blogcomments
                                                                              {else}
                                                                                {$blockblogpost_url|escape:'htmlall':'UTF-8'}{$post.id|escape:'htmlall':'UTF-8'}#blogcomments
                                                                              {/if}"
                                                                title="{$post.title|escape:'htmlall':'UTF-8'}"
                        >{$post.count_comments|escape:'htmlall':'UTF-8'} {l s='comments' mod='blockblog'}</a>
                {/if}

            </p>
            <div class="clear"></div>
        </div>

        {/if}

    </li>
{/foreach}



{if $blockblogblog_post_effect != "disable_all_effects"}
{literal}
    <script type="text/javascript">
        document.addEventListener("DOMContentLoaded", function(event) {
            $(document).ready(function(){
                blockblog_init_effects();
            });
        });
    </script>
{/literal}
{/if}
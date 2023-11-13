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
<div class="product-variants">
    {foreach from=$groups key=id_attribute_group item=group}
        {if !empty($group.attributes)}
            <div class="clearfix product-variants-item variante{$id_attribute_group} {if $group.attributes|count == 1}one-variants{/if}">
                <span class="control-label">{$group.name}</span>
                {if $group.group_type == 'select'}
                    <select
                            class="form-control form-control-select"
                            id="group_{$id_attribute_group}"
                            data-product-attribute="{$id_attribute_group}"
                            name="group[{$id_attribute_group}]">
                        {foreach from=$group.attributes key=id_attribute item=group_attribute}
                            <option value="{$id_attribute}"
                                    title="{$group_attribute.name}"{if $group_attribute.selected} selected="selected"{/if}>{$group_attribute.name}</option>
                        {/foreach}
                    </select>
                {elseif $group.group_type == 'color'}
                    {assign var="autrescouleurs" value=""}
                    <ul id="group_{$id_attribute_group}">
                        {foreach from=$group.attributes key=id_attribute item=group_attribute name="bouclecouleur"}
                            <li class="float-xs-left input-container" title="{$group_attribute.name}">
                                <label>
                                    <input class="input-color" type="radio"
                                           data-product-attribute="{$id_attribute_group}"
                                           name="group[{$id_attribute_group}]"
                                           value="{$id_attribute}"{if $group_attribute.selected} checked="checked"{/if}>
                                    <span
                                            {if $group_attribute.html_color_code && !$group_attribute.texture}class="color"
                                            style="background-color: {$group_attribute.html_color_code}" {/if}
                                            {if $group_attribute.texture}class="color texture" style="background-image: url({$group_attribute.texture})" {/if}
                ><span class="sr-only">{$group_attribute.name}</span></span>
                                </label>
                            </li>
                            {if $group_attribute.selected}
                                {assign var="couleurselected" value="<li class='couleurselected float-xs-left input-container' title='{$group_attribute.name}'>
              <label>
                <input class='input-color' type='radio' data-product-attribute='{$id_attribute_group}' name='group[{$id_attribute_group}]' value='{$id_attribute}'{if $group_attribute.selected} checked='checked'{/if}>
                <span
                  {if $group_attribute.html_color_code && !$group_attribute.texture}class='color' style='background-color: {$group_attribute.html_color_code}' {/if}
                  {if $group_attribute.texture}class='color texture' style='background-image: url({$group_attribute.texture})' {/if}
                ><span class='sr-only'>{$group_attribute.name}</span></span>
              </label>
            </li>"}
                            {else}
                                {assign var="autrescouleurs" value="{$autrescouleurs} <li class='autrescouleurs float-xs-left input-container' title='{$group_attribute.name}'>
              <label>
                <input class='input-color' type='radio' data-product-attribute='{$id_attribute_group}' name='group[{$id_attribute_group}]' value='{$id_attribute}'{if $group_attribute.selected} checked='checked'{/if}>
                <span
                  {if $group_attribute.html_color_code && !$group_attribute.texture}class='color' style='background-color: {$group_attribute.html_color_code}' {/if}
                  {if $group_attribute.texture}class='color texture' style='background-image: url({$group_attribute.texture})' {/if}
                ><span class='sr-only'>{$group_attribute.name}</span></span>
              </label>
            </li>"}
                            {/if}
                        {/foreach}
                    </ul>
                    {if $id_attribute_group == 7}
                        {assign var="couleur1" value="
          <div class='couleursattribute {if $smarty.foreach.bouclecouleur.total > 1}fleche{/if}'>
            <div class='wrapcouleurselected'>{$couleurselected nofilter}</div>
            <div class='wrapautrescouleurs'>{$autrescouleurs nofilter}</div>
          </div>
        "}
                    {/if}

                    {if $id_attribute_group == 8}
                        {assign var="couleur2" value="
          <div class='couleursattribute {if $smarty.foreach.bouclecouleur.total > 1}fleche{/if}'>
            <div class='wrapcouleurselected'>{$couleurselected nofilter}</div>
            <div class='wrapautrescouleurs'>{$autrescouleurs nofilter}</div>
          </div>
        "}
                    {/if}
                {elseif $group.group_type == 'radio'}
                    <ul id="group_{$id_attribute_group}">
                        {foreach from=$group.attributes key=id_attribute item=group_attribute}
                            <li class="input-container float-xs-left">
                                <label>
                                    <input class="input-radio" type="radio"
                                           data-product-attribute="{$id_attribute_group}"
                                           name="group[{$id_attribute_group}]"
                                           value="{$id_attribute}"{if $group_attribute.selected} checked="checked"{/if}>
                                    <span class="radio-label">{$group_attribute.name}</span>
                                </label>
                            </li>
                        {/foreach}
                    </ul>
                {/if}
            </div>
        {/if}
    {/foreach}

    {if isset($couleur1)}
        <div class="clearfix product-variants-item">
            <span class="control-label">Couleur</span>
            {$couleur1 nofilter} {$couleur2 nofilter}
        </div>
    {/if}

    {assign var="urlGuidedestailles" value="{_PS_ROOT_DIR_}{'/upload/guidedestailles/'}{$product_manufacturer->id}{'.jpg'}"}
    {if file_exists($urlGuidedestailles)}
        <div style="width:100%"></div>
        <div class="bouton-m"> 
            <a data-fancybox="" href="/upload/guidedestailles/{$product_manufacturer->id}.jpg">{l s='Size guide' d='Shop.Theme.Catalog'}</a>
        </div>
    {/if}

</div>

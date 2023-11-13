<!-- pack product list-->
<div id="ap5-product-list"
	 class="card ap5-product-list {if empty($from_quickview)}col-12 {else}col-xs-12 col-12{/if}{if $packAvailableQuantity <= 0} ap5-pack-oos{/if}{if $packDeviceIsTablet || $packDeviceIsMobile} ap5-is-mobile{/if}">
    {assign var=nbPackProducts value=count($productsPack)}
    {foreach from=$productsPack item=productPack}
        {assign var=imageIds value="`$productPack.id_product`-`$productPack.image.id_image`"}
        {assign var=imageRewrite value=$productPack.presentation.link_rewrite}
        {if empty($imageRewrite)}
            {assign var=imageRewrite value=$productPack.id_product}
        {/if}
        {if !empty($productPack.image.legend)}
            {assign var=imageTitle value=$productPack.image.legend}
        {else}
            {assign var=imageTitle value=$productPack.presentation.name}
        {/if}
		<div class='row'>

			<div id="ap5-pack-product-{$productPack.id_product_pack}"
				 class="ap5-pack-product {if isset($productsPackErrors[$productPack.id_product_pack])} ap5-product-pack-row-has-errors{/if}{if isset($productsPackFatalErrors[$productPack.id_product_pack])} ap5-product-pack-row-has-fatal-errors{/if}{if empty($productPack.attributes.groups)} ap5-no-attributes{/if}{if in_array($productPack.id_product_pack, $packExcludeList)} ap5-is-excluded-product{/if}">

				<div class="ap5-pack-product-content">

                    {block name='ap5_product_quantity_ribbon'}
						<!-- quantity -->
                        {if $productPack.quantity > 1}
							<div class="ribbon-wrapper">
								<div class="ap5-pack-product-quantity ribbon">
									x {$productPack.quantity|intval}
								</div>
							</div>
                        {/if}
                    {/block}

					<div class='col-lg-3'>
						<div class="ap5-pack-images-container">
                            {block name='ap5_product_images'}
                                {if !$mobile_device}
									<div class="ap5-pack-product-image">
                                        {*<a class="no-print" href="{$pmlink->getImageLink($imageRewrite, $imageIds)}" title="{$imageTitle}"
										   data-fancybox>
											<img class="img-fluid d-block mx-auto"
												 id="thumb_{$productPack.image.id_image|intval}"
												 src="{$pmlink->getImageLink($imageRewrite, $imageIds, $imageFormatProductCover)}"
												 alt="{$imageTitle}" title="{$imageTitle}"
												 height="{$imageFormatProductCoverHeight}"
												 width="{$imageFormatProductCoverWidth}" itemprop="image"/>

										</a>*}
										<img src="{$pmlink->getImageLink($imageRewrite, $imageIds, 'large_default')}"
											 class="img-fluid d-block mx-auto elevateZoom"/>
									</div>
                                    {if $packShowProductsThumbnails && (count($productPack.images) > 1 || $packMaxImagesPerProduct > 1)}
										<div class="ap5-pack-product-slideshow pm-ap-owl-carousel clearfix">
                                            {foreach from=$productPack.images item=productPackImage}
                                                {assign var=productPackImageTitle value=$productPack.presentation.name}
                                                {assign var=productPackImageIds value="`$productPack.id_product`-`$productPackImage.id_image`"}
												<div id="ap5-pack-product-thumbnail-{$productPackImage.id_image|intval}"
													 class="ap5-pack-product-thumbnail">
													<a title="{$productPackImageTitle}"
													   href="{$pmlink->getImageLink($imageRewrite, $productPackImageIds)}" data-fancybox>
														<img class="img-fluid d-block mx-auto"
															 id="thumb_{$productPackImage.id_image|intval}"
															 src="{$pmlink->getImageLink($imageRewrite, $productPackImageIds, $imageFormatProductSlideshow)}"
															 alt="{$productPackImageTitle}"
															 title="{$productPackImageTitle}"
															 height="{$imageFormatProductSlideshowHeight}"
															 width="{$imageFormatProductSlideshowWidth}"
															 itemprop="image"/>
													</a>
												</div>
                                            {/foreach}
										</div>
                                    {/if}
                                {else}
									<hr class="ap5-pack-product-icon-plus"/>
                                    {if $packShowProductsThumbnails && count($productPack.images) > 1}
										<div class="ap5-pack-product-mobile-slideshow pm-ap-owl-carousel clearfix">
                                            {foreach from=$productPack.imagesMobile item=productPackImage}
                                                {assign var=productPackImageTitle value=$productPack.presentation.name}
                                                {assign var=productPackImageIds value="`$productPack.id_product`-`$productPackImage.id_image`"}
												<div id="ap5-pack-product-thumbnail-{$productPackImage.id_image|intval}"
													 class="ap5-pack-product-thumbnail">
													<img class="img-fluid d-block mx-auto"
														 id="thumb_{$productPackImage.id_image|intval}"
														 src="{$pmlink->getImageLink($imageRewrite, $productPackImageIds, $imageFormatProductCoverMobile)}"
														 alt="{$productPackImageTitle}" title="{$productPackImageTitle}"
														 height="{$imageFormatProductCoverMobileHeight}"
														 width="{$imageFormatProductCoverMobileWidth}"
														 itemprop="image"/>
												</div>
                                            {/foreach}
										</div>
                                    {elseif (!$packShowProductsThumbnails && count($productPack.images) > 0) || ($packShowProductsThumbnails && count($productPack.images) == 1)}
										<div class="ap5-pack-product-image">
											<a class="no-print" {if empty($from_quickview)}data-toggle="modal"
											   data-target="#ap5-pack-product-{$productPack.id_product_pack}-modal #product-modal"{/if}
											   title="{$imageTitle}">
												<img class="img-fluid d-block mx-auto"
													 id="thumb_{$productPack.image.id_image|intval}"
													 src="{$pmlink->getImageLink($imageRewrite, $imageIds, $imageFormatProductCover)}"
													 alt="{$imageTitle}" title="{$imageTitle}"
													 height="{$imageFormatProductCoverHeight}"
													 width="{$imageFormatProductCoverWidth}" itemprop="image"/>
											</a>
										</div>
                                    {/if}
                                {/if}
                            {/block}
						</div>

					</div>

					<div class='col-lg-8'>

                        {block name='ap5_product_name'}
                            {assign var="urlManufacturer" value="{_PS_ROOT_DIR_}{'/img/m/'}{$productPack.productObj->id_manufacturer}{'.jpg'}"}
                            {if file_exists($urlManufacturer)}
								<div class="float-right">
									<img src="/img/m/{$productPack.productObj->id_manufacturer}.jpg" style="max-width: 100px"/>
								</div>
                            {/if}
							<h1 class="ap5-pack-product-name h1">
								<a href="javascript:void(0);" title="{$productPack.presentation.name}" itemprop="url">
                                    {$productPack.presentation.name}
								</a>
							</h1>
							<p>Réf : {$productPack.presentation.reference_to_display}</p>
                        {/block}

						<div class='description_produit'>
                            {$productPack.presentation.description_short nofilter}
						</div>

                        {if $productPack.features.0.name == 'Matière'}
							<div class="features">
								<p>
                                    {$productPack.features.0.name} : {$productPack.features.0.value}
								</p>
							</div>
                        {/if}


						<div class="product-actions">

                            {if $packAllowRemoveProduct && $packShowProductsQuantityWanted}
								<!-- quantity wanted -->
								<fieldset id="ap5-quantity-wanted-{$productPack.id_product_pack|intval}"
										  class="attribute_fieldset ap5-attribute-fieldset ap5-quantity-fieldset">
									<label class="attribute_label"
										   for="quantity_wanted_{$productPack.id_product_pack|intval}">{l s='Quantity' d='Shop.Theme.Catalog'}</label>
									<div class="attribute_list ap5-attribute-list ap5-quantity-input-container">
										<input type="text" name="qty_{$productPack.id_product_pack|intval}"
											   id="quantity_wanted_{$productPack.id_product_pack|intval}"
											   value="{$productPack.quantity|intval}"
											   class="ap5-quantity-wanted input-group form-control"
											   data-id-product-pack="{$productPack.id_product_pack|intval}"{if in_array($productPack.id_product_pack, $packExcludeList)} disabled="disabled"{/if} />
									</div>
								</fieldset>
                            {/if}
                            {if !empty($productPack.attributes.groups)}
								<!-- attributes -->
								<div class="product-variants ap5-attributes"
									 data-id-product-pack="{$productPack.id_product_pack|intval}">
                                    {foreach from=$productPack.attributes.groups key=id_attribute_group item=group}

                                        {if $group.attributes|@count}
                                            {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                {* Force the user-selected attribute to be the default one *}
                                                {if isset($packCompleteAttributesList[$productPack.id_product_pack]) && in_array($id_attribute, $packCompleteAttributesList[$productPack.id_product_pack])}
                                                    {$group['default'] = $id_attribute}
                                                {/if}
                                            {/foreach}
											<div id="ap5-product-variants-item-{$id_attribute_group|intval}"
												 class="clearfix product-variants-item ap5-attribute-fieldset">
												<span class="control-label">{$group.name}</span>
                                                {assign var="groupName" value="group_`$productPack.id_product_pack`_$id_attribute_group"}
												<div class="attribute_list ap5-attribute-list">
                                                    {if ($group.group_type == 'select')}
														<select name="{$groupName}"
																id="group_{$id_attribute_group|intval}"
																class="ap5-attribute-select no-print form-control form-control-select"{if in_array($productPack.id_product_pack, $packExcludeList)} disabled="disabled"{/if}>
                                                            {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                {assign var=ap5_isCurrentSelectedIdAttribute value=((isset($productsPackErrors[$productPack.id_product_pack]) && isset($packCompleteAttributesList[$productPack.id_product_pack]) && in_array($id_attribute, $packCompleteAttributesList[$productPack.id_product_pack])) || $group.default == $id_attribute)}
																<option value="{$id_attribute|intval}"{if $ap5_isCurrentSelectedIdAttribute} selected="selected"{/if}
																		title="{$group_attribute}">{$group_attribute}</option>
                                                            {/foreach}
														</select>
                                                    {elseif ($group.group_type == 'color')}
                                                        {assign var="autrescouleurs" value=""}
														<ul class="ap5-color-to-pick-list ap5-color-to-pick-list-{$productPack.id_product_pack|intval}-{$id_attribute_group|intval}">
                                                            {assign var="default_colorpicker" value=""}
                                                            {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                {assign var=ap5_isCurrentSelectedIdAttribute value=((isset($productsPackErrors[$productPack.id_product_pack]) && isset($packCompleteAttributesList[$productPack.id_product_pack]) && in_array($id_attribute, $packCompleteAttributesList[$productPack.id_product_pack])) || $group.default == $id_attribute)}
																<li class="float-left float-xs-left pull-xs-left input-container{if $ap5_isCurrentSelectedIdAttribute} selected{/if}">
																	<a href="{$productPack.presentation.url}"
																	   data-id-product-pack="{$productPack.id_product_pack|intval}"
																	   data-id-attribute-group="{$id_attribute_group|intval}"
																	   data-id-attribute="{$id_attribute|intval}"
																	   id="color_{$id_attribute|intval}"
																	   name="{$productPack.attributes.colors.$id_attribute.name}"
																	   class="ap5-color color color_pick{if $ap5_isCurrentSelectedIdAttribute} selected{/if}{if in_array($productPack.id_product_pack, $packExcludeList)} disabled{/if}"
																	   style="background: {$productPack.attributes.colors.$id_attribute.value};"
																	   title="{$group_attribute}">
                                                                        {if $productPack.attributes.colors.$id_attribute.image_exists}
																			<img src="{$urls.img_col_url}{$id_attribute|intval}.jpg"
																				 alt="{$productPack.attributes.colors.$id_attribute.name}"/>
                                                                        {/if}
																	</a>
																</li>
                                                                {if $ap5_isCurrentSelectedIdAttribute}
                                                                    {$default_colorpicker = $id_attribute}
                                                                {/if}

                                                                {if $ap5_isCurrentSelectedIdAttribute}
                                                                    {assign var="couleurselected" value="<li  class='float-left float-xs-left pull-xs-left couleurselected input-container{if $ap5_isCurrentSelectedIdAttribute} selected{/if}'>
																<a href='#'  class='color{if $ap5_isCurrentSelectedIdAttribute} selected{/if}{if in_array($productPack.id_product_pack, $packExcludeList)} disabled{/if}' style='background: {$productPack.attributes.colors.$id_attribute.value};' title='{$group_attribute}'>
																	{if $productPack.attributes.colors.$id_attribute.image_exists}
																		<img src='{$urls.img_col_url}{$id_attribute|intval}.jpg' alt='{$productPack.attributes.colors.$id_attribute.name}' />
																	{/if}
																</a>
															</li>"}
                                                                {else}
                                                                    {assign var="autrescouleurs" value="{$autrescouleurs} <li  class='float-left float-xs-left pull-xs-left autrescouleurs input-container{if $ap5_isCurrentSelectedIdAttribute} selected{/if}'>
																<a href='{$productPack.presentation.url}' data-id-product-pack='{$productPack.id_product_pack|intval}' data-id-attribute-group='{$id_attribute_group|intval}' data-id-attribute='{$id_attribute|intval}' id='color_{$id_attribute|intval}' name='{$productPack.attributes.colors.$id_attribute.name}' class='ap5-color color color_pick{if $ap5_isCurrentSelectedIdAttribute} selected{/if}{if in_array($productPack.id_product_pack, $packExcludeList)} disabled{/if}' style='background: {$productPack.attributes.colors.$id_attribute.value};' title='{$group_attribute}'>
																	{if $productPack.attributes.colors.$id_attribute.image_exists}
																		<img src='{$urls.img_col_url}{$id_attribute|intval}.jpg' alt='{$productPack.attributes.colors.$id_attribute.name}' />
																	{/if}
																</a>
															</li>"}
                                                                {/if}
                                                            {/foreach}
														</ul>
														<input type="hidden"
															   class="color_pick_hidden_{$productPack.id_product_pack|intval}_{$id_attribute_group|intval}"
															   name="{$groupName}"
															   value="{$default_colorpicker|intval}"/>
                                                        {if $id_attribute_group == 7}
                                                            {assign var="couleur1" value="
          <div class='couleursattribute'>
            <div class='wrapcouleurselected'>{$couleurselected nofilter}</div>
            <div class='wrapautrescouleurs'>{$autrescouleurs nofilter}</div>
          </div>
        "}
                                                        {/if}

                                                        {if $id_attribute_group == 8}
                                                            {assign var="couleur2" value="
          <div class='couleursattribute'>
            <div class='wrapcouleurselected'>{$couleurselected nofilter}</div>
            <div class='wrapautrescouleurs'>{$autrescouleurs nofilter}</div>
          </div>
        "}
                                                        {/if}

                                                    {elseif ($group.group_type == 'radio')}
														<ul>
                                                            {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                {assign var=ap5_isCurrentSelectedIdAttribute value=((isset($productsPackErrors[$productPack.id_product_pack]) && isset($packCompleteAttributesList[$productPack.id_product_pack]) && in_array($id_attribute, $packCompleteAttributesList[$productPack.id_product_pack])) || $group.default == $id_attribute)}
																<li class="input-container float-left float-xs-left pull-xs-left">
																	<input type="radio"
																		   class="input-radio ap5-attribute-radio"
																		   name="{$groupName}"
																		   value="{$id_attribute}" {if $ap5_isCurrentSelectedIdAttribute} checked="checked"{/if}{if in_array($productPack.id_product_pack, $packExcludeList)} disabled="disabled"{/if} />
																	<span class="radio-label">{$group_attribute}</span>
																</li>
                                                            {/foreach}
														</ul>
                                                    {/if}
												</div> <!-- end attribute_list -->
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
										<div style="width:100%; margin-bottom:15px;">
                                            <span class="bouton-m">
                                                <a data-fancybox=""
												   href="/upload/guidedestailles/{$product_manufacturer->id}.jpg">{l s='Size guide' d='Shop.Theme.Catalog'}</a>
                                            </span>
										</div>
                                    {/if}

                                    {*assign var="test" value="{Manufacturer::getNameById((int) $productPack
                                    .productObj->id_manufacturer)}"}
                                    {assign var="urltaille" value="{'/var/www/vhosts/sportshop.publipresse.ovh/httpdocs/upload/tailles/'}{$test}{'.jpg'}"}

                                    {if file_exists($urltaille)}
                                        <div class="bouton-m">

                                            <a data-fancybox="" data-type="iframe"
                                               href="/upload/tailles/{Manufacturer::getNameById((int) $productPack.productObj->id_manufacturer)}.jpg">{l s='Size guide' d='Shop.Theme.Catalog'}</a>
                                        </div>
                                    {/if*}


								</div>
                            {/if}
						</div>


                        {if $productPack.presentation.customizable && sizeof($productPack.customization.customizationFields)}
                            {assign var=personnalisation value=""}
                            {foreach from=$productPack.customization.customizationFields item='csfield' name='customizationFields'}

                                {if $csfield.name == "Logo" or $csfield.name == "Logo OUI/NON" or $csfield.name == "Logo NON/OUI"}
									<div class="typemarquage inline {if $csfield.required == 1}required{/if}"
										 data-field='{$csfield.id_customization_field}'>
										<p class='sstitre2'>
											Logo
										</P>

										<div class="switch switchlogo" data-field='{$csfield.id_customization_field}'>
											<span class='avec actif'>AVEC</span>
										</div>
									</div>
                                {else}
                                    {*
                                    {assign var=personnalisation value="
                              <div class='wrapinput {if $csfield.required == 1}required{/if}'>
                                <input type='text' placeholder='{$csfield.name}' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span><span class='sans'>SANS</span>
                                </div>
                              </div>
                            "}
                            *}
                                    {assign var=personnalisation value="
                              <div class='wrapinput {if $csfield.name == 'Marquage obligatoire'}required{/if}'>
                                <input type='text' placeholder='{$csfield.name}' data-field='{$csfield.id_customization_field}' />
                                <div class='switch'>
                                  <span class='avec actif'>AVEC</span>
                                  {if $csfield.name != 'Marquage obligatoire'}<span class='sans'>SANS</span>{/if}
                                </div>
                              </div>
                            "}


                                {/if}

                            {/foreach}
                            {*
                            <div class='inlinebloc'>
                                <div class='blocavant'>
                                    {if isset($texte) || isset($numero)}
                                        <div class='typemarquage'>
                                            <p class='sstitre2'>
                                                Marquage avant
                                            </p>
                                        </div>
                                        {if isset($texte)}
                                            {$texte nofilter}
                                        {/if}

                                        {if isset($numero)}
                                            {$numero nofilter}
                                        {/if}
                                    {/if}
                                </div>

                                <div class='blocarriere'>
                                    {if isset($nomdos) || isset($numerodos)}
                                        <div class='typemarquage'>
                                            <p class='sstitre2'>
                                                Marquage arrière
                                            </p>
                                        </div>
                                        {if isset($nomdos)}
                                            {$nomdos nofilter}
                                        {/if}
                                        {if isset($numerodos)}
                                            {$numerodos nofilter}
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        *}
							<div id="personnalisation">

                                {if isset($personnalisation)}
                                    {$personnalisation nofilter}
                                {/if}
							</div>
							<div class='wrapflocage'>
								<div class="bouton-m"><a data-fancybox="guideduflocage" data-src="#guideduflocage"
														 href="javascript:;">Guide du marquage</a></div>


								<div id="guideduflocage" class="container" style="display: none;">
									<div class="row headerf">
										<div class="col-md-6">
											<p class="gras t40">{l s='Customization Guide' d='Shop.Theme.Catalog'}</p>
										</div>
										<div class="col-md-6 right">
											<p class="gras t24">Emplacement logotage</p>
											<p class="t10">Sportmidable se réserve le droit d’adapter la couleur du
												marquage (noir ou blanc) et les emplacements selon la spécificité de
												chaque produit. Pour les vêtements de pluie/hiver (doudoune, parka,
												coupe vent) le logo peut être en monochrome au lieu de quadri dans un
												but d'augmenter la qualité et la durabilité du marquage. Images non
												contractuelles. Contactez-nous pour plus d'informations. </p>
										</div>
									</div>

									<div class="row dflex">
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/tshirtdevant.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/tshirtdevant.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/tshirtdevant.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>Texte + Numéro</p>
												<p class="ptitexte">Possibilité texte seul ou numéro seul</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/tshirtderriere.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/tshirtderriere.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/tshirtderriere.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/shortlogonumero.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/shortlogonumero.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/shortlogonumero.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/pantalonlogonumero.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/pantalonlogonumero.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/pantalonlogonumero.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro + texte</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/tshirtdevanttexte.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/tshirtdevanttexte.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/tshirtdevanttexte.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>Logo</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/sac.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/sac.svg" class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/sac.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro + texte</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/shortlogonumerotexte.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/shortlogonumerotexte.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/shortlogonumerotexte.svg"
														 style="display: block;"></div>
											</div>
										</div>
										<div class="col-lg-3 col-md-6 col-sm-12">
											<div class="vignette">
												<p>logo + Numéro + texte</p>
												<div class="magnify">
													<div class="magnify-lens"
														 style="background: url(&quot;/themes/publipresse_theme/assets/img/pantalonnumerotexte.svg&quot;) 0px 0px / 800px 800px no-repeat;"></div>
													<img src="/themes/publipresse_theme/assets/img/pantalonnumerotexte.svg"
														 class="zoom"
														 data-magnify-src="/themes/publipresse_theme/assets/img/pantalonnumerotexte.svg"
														 style="display: block;"></div>
											</div>
										</div>


									</div>

								</div>
							</div>
						{else}

							<div class="product-additional-info">
								{hook h='displayPackProductAdditionalInfo' id_product=$productPack.id_product is_pack=1 quantity=$productPack.quantity|intval}
							</div>

                        {/if}


						<div class="fulldescription_produit">
							<p>{$productPack.presentation.description nofilter}</p>
						</div>
                        {if $productPack.presentation.show_price && $packShowProductsPrice && !$configuration.is_catalog}
                            {if $packShowProductsThumbnails && $packMaxImagesPerProduct > 1}
								<hr/>
                            {/if}
							<div class="ap5-pack-product-price-table-container product-prices {if $productPack.reduction_amount <= 0} ap5-no-reduction{/if}">
                                {if empty($productsPackForceHideInfoList[$productPack.id_product_pack])}
									<div class="ap5-pack-product-price-table-cell {if $productPack.reduction_amount > 0} has-discount{/if}">
                                        {block name='ap5_product_price'}
											<div class="current-price ap5-pack-product-price text-center">
                                                {if $productPack.reduction_amount > 0}
													<div class="product-discount ap5-pack-product-original-price text-center">
														<span class="regular-price ap5-pack-product-original-price-value">
														{if !$priceDisplay || $priceDisplay == 2}
                                                            {$productPack.presentation.productClassicPriceTotal}
                                                        {elseif $priceDisplay == 1}
                                                            {$productPack.presentation.productClassicPriceTaxExclTotal}
                                                        {/if}
														</span>
													</div>
                                                {/if}
												<div class="product-price h5 has-discount">
                                                    {if $productPack.presentation.show_price}
                                                        {if $productPack.productPackPrice == 0}
                                                            {l s='Gift' d='Shop.Theme.Checkout'}
                                                        {else}
                                                            {if !$priceDisplay || $priceDisplay == 2}
																<span>{$productPack.presentation.productPackPriceTotal}</span>
                                                            {elseif $priceDisplay == 1}
																<span>{$productPack.presentation.productPackPriceTaxExclTotal}</span>
                                                            {/if}
                                                        {/if}
                                                    {/if}
                                                    {if $productPack.reduction_amount > 0}
                                                        {if $productPack.productPackPrice > 0}
                                                            {if $productPack.reduction_type == 'amount'}
																<span class="discount discount-amount ap5-pack-product-reduction-value">
																	{l s='Save %amount%' d='Shop.Theme.Catalog' sprintf=['%amount%' => $productPack.presentation.productReductionAmountTotal]}
																</span>
                                                            {else}
																<span class="discount discount-percentage ap5-pack-product-reduction-value">{l s='Save %percentage%' d='Shop.Theme.Catalog' sprintf=['%percentage%' => $productPack.reduction_amount * 100]}%</span>
                                                            {/if}
                                                        {/if}
                                                    {/if}
												</div>
											</div>
                                        {/block}
                                        {block name='ap5_product_availability'}
                                            {if $packShowProductsAvailability}
												<!-- availability -->
												<div class="ap5-availability-statut">
												<span id="product-availability">
												{if $packShowProductsAvailability}
                                                    {if $productPack.presentation.availability == 'available'}
														<i class="material-icons product-available">&#xE5CA;</i>








{elseif $productPack.presentation.availability == 'last_remaining_items'}








														<i class="material-icons product-last-items">&#xE002;</i>








{else}








														<i class="material-icons product-unavailable">&#xE14B;</i>
                                                    {/if}
                                                    {$productPack.presentation.availability_message}
                                                {/if}
												</span>
												</div>
                                            {/if}
                                        {/block}
									</div>
                                {/if}
							</div>
                        {/if}


					</div>


                    {* Let's display error list *}
                    {if isset($productsPackErrors[$productPack.id_product_pack]) || isset($productsPackFatalErrors[$productPack.id_product_pack])}
                        {if isset($productsPackFatalErrors[$productPack.id_product_pack])}
							<div class="ap5-overlay"></div>
                        {/if}
						<div class="alert animated shake {if isset($productsPackFatalErrors[$productPack.id_product_pack])}alert-danger{else}alert-warning{/if}">
							<ol>
                                {if isset($productsPackErrors[$productPack.id_product_pack])}
                                    {foreach from=$productsPackErrors[$productPack.id_product_pack] item=errorRow}
										<li>{$errorRow}</li>
                                    {/foreach}
                                {/if}
                                {if isset($productsPackFatalErrors[$productPack.id_product_pack])}
                                    {foreach from=$productsPackFatalErrors[$productPack.id_product_pack] item=errorRow}
										<li>{$errorRow}</li>
                                    {/foreach}
                                {/if}
							</ol>
						</div>
                    {/if}

				</div>
                {if $packAllowRemoveProduct}
                    {if !in_array($productPack.id_product_pack, $packExcludeList)}
						<span class="ap5-pack-product-icon-remove"
							  data-id-product-pack="{$productPack.id_product_pack|intval}"></span>
                    {else}
						<span class="ap5-pack-product-icon-check"
							  data-id-product-pack="{$productPack.id_product_pack|intval}"></span>
                    {/if}
                {/if}
			</div>
		</div>
		<hr/>
    {/foreach}
</div>
<!-- end pack product list -->

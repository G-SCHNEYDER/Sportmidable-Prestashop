/*
 * Custom code goes here.
 * A template should always ship with an empty custom.js
 */

$(document).ready(function () {

	$(".elevateZoom").elevateZoom({tint: true, tintColour: '#000', tintOpacity: 0.5});

	$('.items-articles-block').slick({
		dots: false,
		infinite: false,
		speed: 300,
		slidesToShow: 2,
		slidesToScroll: 1,
		arrows: true,
		responsive: [

			{
				breakpoint: 480,
				settings: {
					slidesToShow: 1,
					slidesToScroll: 1,
					dots: false,
				},
			},
			// You can unslick at a given breakpoint now by adding:
			// settings: "unslick"
			// instead of a settings object
		],
	});

	$('#menu-icon').click(function () {
		$('#header .category-top-menu > li:first-child').mouseenter();
	});

	//menu
	$('#header .category-top-menu > li:first-child').mouseenter(function () {
		$(this).toggleClass('open');
	}).mouseleave(function () {
		$(this).toggleClass('open');
	});

	$('#header .category-top-menu > li:first-child').click(function (e) {
		e.preventDefault();
		$('#header .category-top-menu > li:nth-child(2), #header .category-top-menu li[data-depth=0]').toggle();
		$('#header .category-top-menu > li:first-child').toggleClass('actif');
	});

	$('a[href="#search"]').on('click', function (event) {
		event.preventDefault();
		$('#search_newwidget').addClass('open');
		$('#search_newwidget > form > input[type="search"]').focus();
	});

	$('#search_newwidget, #search_newwidget button.close').on('click keyup', function (event) {
		if (event.target === this || event.target.className === 'close' || event.keyCode === 27) {
			$(this).removeClass('open');
		}
	});

	$.fn.slick && $('.items-articles-block').slick({
		slidesToShow: 2,
		slidesToScroll: 2,
	});
	/*
	$('[data-fancybox="gallery"]').fancybox({
		// Options will go here
	});
	*/


	$('#wrapper').on('click', '.switch span', function () {
		if (!$(this).hasClass('actif')) {
			$(this).parent().find('span').removeClass('actif');
			$(this).addClass('actif');
			if ($(this).hasClass('sans')) {
				$(this).parents('.wrapinput').find('input').val('');
			}
		}

		majprix();

	});

	//j'initialise à requis
	$('.wrapinput.required .switch .sans').removeClass('actif');
	$('.wrapinput.required .switch .avec').addClass('actif');

	$(document).on('keyup', '.wrapinput:not(\'.required\') input', function (event) { 
		if ($(this).val() != '') {
			active($(this).next());
		} else {
			desactive($(this).next());
		}
		majprix();
	});

	refreshcustomizations();
	// $(document).on('change', '.product-variants [data-product-attribute]', function (event) {
	// 	 	var query = $(event.target.form).serialize() + '&ajax=1&action=productrefresh';
	//        var actionURL = $(event.target.form).attr('action');
	//        $.post(actionURL, query, null, 'json').then(function (resp) {
	//            var productUrl = resp.productUrl;
	//            $.post(productUrl, {ajax: '1',action: 'refresh' }, null, 'json').then(function (resp) {
	//                var idProductAttribute = resp.id_product_attribute;

	//                // your own code to perform some action on combination change
	//                //
	//                //
	//                console.log("je refresh");
	//                refreshcustomizations();

	//            });
	//        });
	// });

	prestashop.on('updatedProduct', function (event) {
		//console.log('product updated inside custom.js');
		refreshcustomizations();
		//customUpdateDeliveryDates();
	});

	$(document).on('ap5-After-UpdatePackContent', function (event) {
		console.log('pack updated');
		refreshcustomizations();
	});

	$('.zoom').magnify({
		magnifiedWidth: 800,
		magnifiedHeight: 800,
	});

	$(document).on('click', '.wrapcouleurselected', function (event) {
		console.log('stop');
		event.stopPropagation();
		event.preventDefault();
		$(this).next().toggleClass('show');
	});

	// Social sharing element has to be placed below delivery information
	if ($('.product-additional-info').length == 1 && $('.dd_available  .dd-info-container').length > 0 && $('.social-sharing').length > 0) {
		$('.product-additional-info').append($('.product-additional-info .social-sharing'));
	}

	$('footer#footer .elementor.elementor-8 .elementor-icon-box-content .elementor-icon-box-title a').each(function(index, element) {
		if ($(element).html() == 'Service client')
		{
			let footerDiv = $(element).parent().parent();
			$(footerDiv).append('<div class="account-deletion-link"><a href="' + accountDeletionPageUrl + '">Supprimer mon compte</a></div>');
		}
	});

	if ($('select').attr('data-product-attribute', '1').length > 0) {
		disableProductSelectorsWithUniqueOption();
	}

	// When a thumbnail is clicked, the zoom must be applied on its large image version
	$('img.thumb').on('click', function() {
		let imageUrl = $(this).attr('src');
		imageUrl = imageUrl.replace('-home_default/', '-large_default/');
		$('.zoomLens img').attr('src', imageUrl);
		$('.zoomWindowContainer > div').css('background-image', 'url(' + imageUrl + ')');
	});

	/* Temporary fix on menu item label issue */
	if ($('ul.ets_mm_categories li a.ets_mm_url').length > 0) {
		$('ul.ets_mm_categories li a.ets_mm_url').each(function() {
			if ($(this).html() == 'Beby Léo') {
				$(this).html('Baby Léo');
			}
		});
	}

	$(document).on('keypress', '#personnalisation .wrapinput input', function (event) {
		//console.log('keypress');
		allowedInput(event);
		 
	});
});

function allowedInput(e) {  // Accept only alpha numerics, no special characters 
	console.log('allowedInput');
	var regex = new RegExp("^[a-zA-Z0-9 ]+$");
	var str = String.fromCharCode(!e.charCode ? e.which : e.charCode);
	if (regex.test(str)) {
		return true;
	}

	e.preventDefault();
	return false;
} 

function disableProductSelectorsWithUniqueOption() {
	$('select').attr('data-product-attribute', '1').each(function() {
		let optionElements = $(this).find('option');
		if (optionElements.length == 1) {
			$(this).prop('disabled', true);
		}
	});
}

function telify() {

	if (document.querySelector('[name=phone]')) {
		let input = document.querySelector('[name=phone]');
		window.intlTelInput(input, {
			onlyCountries: ['fr', 'ch'],
			initialCountry: 'fr',
			separateDialCode: true,
			utilsScript: 'utils.js',

		});
	}

	if (document.querySelector('[name=phone_mobile]')) {
		let input = document.querySelector('[name=phone_mobile]');
		window.intlTelInput(input, {
			onlyCountries: ['fr', 'ch'],
			initialCountry: 'fr',
			separateDialCode: true,
			utilsScript: 'utils.js',

		});
	}

}

function refreshcustomizations() {
	//j'initialise à requis
	$('.wrapinput.required .switch .sans').removeClass('actif');
	$('.wrapinput.required .switch .avec').addClass('actif');

	if ($('form#customizationFormModule').length || $('.ap5-customization-form').length) {
		console.log('je passe dans le refresh!');
	 
		//je commence par mettre actif les éléments required
		$('.product-actions .required').each(function () {
			active($(this).find('.switch'));
		});

		//problème lorsque que la perosnnalisation est requise, le module custom price ne le prend pas en compte
		$('.add .add-to-cart').removeAttr('disabled');

		$('.product-actions .add-to-cart, .ap5-add-to-cart-container .add-to-cart').click(function (e) {
			e.preventDefault();
			var error = false;
			$('.wrapinput.red').removeClass('red');
			//je check que tous les champs actifs sont remplis
			$('span.avec.actif').each(function () {
				if ($(this).parents('.wrapinput').find('input').val() == '') {
					$(this).parents('.wrapinput').addClass('red');
					error = true;
				}
			});

			if (error) {
				return;
			}

			//je remplis le vrai formulaire
			$('.wrapinput input').each(function () {
				var field = $(this).attr('data-field');
				var contenu = $(this).val();

				$('.product-customization-item [name=textField' + field + ']').val(contenu);
			});

			//je remplis aussi dans le cas des logos
			$('.switchlogo').each(function () {
				var field = $(this).attr('data-field');
				if ($(this).find('.avec').hasClass('actif')) {
					$('.product-customization-item [name=textField' + field + ']').val('OUI');
				} else {
					//$(".product-customization-item [name=textField"+field+"]").val("NON");
				}

			});

			//j'envoie le vrai formulaire
			if ($('.ap5-customization-form').length) { //je suis dans un pack
				$('form.ap5-buy-block').submit();
			} else	// je suis sur une fiche produit
			{
				//je remplis le bon id attribute... :(
				$('[name=\'id_product_attribute\']').val($('[name=\'idCombination\']').val());
				$('form#customizationFormModule').submit();
			}

		});
		majprix();
	}
}

function active(el) {
	//alert($(el));
	if (!$(el).find('.avec').hasClass('actif')) {
		$(el).find('.avec').addClass('actif');
		$(el).find('.sans').removeClass('actif');
	}
}

function desactive(el) {
	//alert($(el));
	if (!$(el).find('.sans').hasClass('actif')) {
		$(el).find('.sans').addClass('actif');
		$(el).find('.avec').removeClass('actif');
	}
}

function majprix() {
	var prixbase = parseFloat($('.current-price span').attr('content'));
	//var ajout = 0;
	$('span.avec.actif').each(function () {
		var field = $(this).parents('.wrapinput').find('input').attr('data-field');
		if (field == undefined) {
			field = $(this).parent().attr('data-field');
		}
		var tarif = parseFloat($('.product-customization-item [name=textField' + field + ']').attr('data-tarif'));
		//console.log(tarif);
		if (tarif > 0) {
			prixbase += tarif;
		}

	});
	prixbase = prixbase.toFixed(2);
	prixbase = prixbase.toString(); 

	$currencyCode = $('[itemprop=priceCurrency]').attr('content');
	//console.log($('[itemprop=priceCurrency]').attr('content'));
	if($currencyCode === 'CHF') $('.current-price span').text($currencyCode + ' ' + prixbase);
	else $('.current-price span').text(prixbase + ' ' + $currencyCode);
}
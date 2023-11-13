function updateDeliveryDates(e) {

    var elem = $('#dd_carriers_list');
    if (!elem.length) {
        console.error('DeliveryDate: #dd_carriers_list not found. Make sure that the DisplayProductExtraContent hook is available in your theme.')
        return;
    }
    var qties = JSON.parse(elem.attr('data-qties'));
    var id_product_attribute = e && e.id_product_attribute || elem.attr('data-id-product-attribute');
    var isOutOfStock = qties[id_product_attribute] <= 0;
    var id = $('.deliverydate-content').attr('id');

    if (isOutOfStock && !+elem.attr('data-allow-oosp')) {
        $('[href="#'+id+'"]').parent().addClass('hidden');
        $('.dd_available, .dd_oot').addClass('hidden');
    } else {
        $('[href="#'+id+'"]').parent().toggleClass('hidden', false);
        $('.dd_available').toggleClass('hidden', isOutOfStock);
        $('.dd_oot').toggleClass('hidden', !isOutOfStock);
    }

    // Calculation of delivery date
    let currentEstimdateDate = $('.dd_available  .dd-info-container .dd-estimated-date');
    let estimatedDeliveryDate = 'One day maybe';

    $('[href="#'+id+'"]').parent().toggleClass('hidden', false);
    $('.dd_available').toggleClass('hidden', isOutOfStock);
    $('.dd_oot').toggleClass('hidden', !isOutOfStock);
}

function customUpdateDeliveryDates(e) {
    let isPack  = $('.product-additional-info').length > 1;
    let currentDeliveryDateObject = $('.dd_available .dd-info-container .dd-estimated-date');
    let productDetails = $.parseJSON($('#product-details').attr('data-product'));

    if (isPack) {
        // In case of a pack the date is already displayed correctly so let's get out of here
        return;
    }

    $.ajax({
        type: 'POST',
        url: getDeliveryDatesUrl,
        data: {
            'productId': productDetails.id_product,
            'productAttributeId': productDetails.id_product_attribute,
            'shopId': shopId,
            'wantedQuantity': productDetails.quantity_wanted,
            ajax: true
        },
        dataType: 'json',
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        success: function(data) {
            let productUnavailable = false;
            if (typeof data.product_unavailable !== 'undefined') {
                productUnavailable = data.product_unavailable;
            }
            if (typeof data.available_text !== 'undefined') {
                currentDeliveryDateObject.html(data.available_text);
            }
            setProductAsUnorderable(productUnavailable);

            $('.product-additional-info').append($('.product-additional-info .social-sharing'));
        },
        error: function(data) {
            console.log("error data", data);
        }
    });
}

function setProductAsUnorderable(productUnavailable = true)
{
    $('button.add-to-cart').prop('disabled', false);
    $('.dd_available').removeClass('hidden');
    $('#unavailable-product').addClass('hidden');
    if (productUnavailable) {
        $('button.add-to-cart').prop('disabled', true);
        $('.dd_available').addClass('hidden');
        $('#unavailable-product').removeClass('hidden');
    }
}

prestashop.on('updatedProduct', customUpdateDeliveryDates);
$(document).ready(customUpdateDeliveryDates);
<script type="text/javascript">
    let getDeliveryDatesUrl = '{$getDeliveryDatesUrl|escape:'htmlall':'UTF-8'}';
    let shopId = '{$shopId}';
    let packItemsDates = [];

    function customUpdatePackDeliveryDates(packAttributesList, packId) {
        if (packId > 0) {
            // Reset the dates of each pack item
            $('.dd_available .dd-info-container .dd-estimated-date').each(function(index) {
                $(this).html(packItemsDates[index]);
            });
            let packAttributesArray = jQuery.parseJSON(packAttributesList[0]);
            let productAttributeId = packAttributesArray[packId];
            let data = {
                'packId': packId,
                'productId': 0,
                'productAttributeId': productAttributeId,
                'shopId': shopId,
                'wantedQuantity': 1,
                ajax: true
            };
            $.ajax({
                type: 'POST',
                url: getDeliveryDatesUrl,
                data: data,
                dataType: 'json',
                contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
                success: function(data) {
                    console.log("success data", data);
                    if (typeof data.available_text !== 'undefined') {
                        $('#ap5-pack-product-' + data.packId + ' .dd_available .dd-info-container .dd-estimated-date').html(data.available_text);
                    }
                    if (data.product_unavailable) {
                        $('#ap5-pack-product-' + packId + ' .product-additional-info .dd_available').addClass('hidden');
                        $('button.add-to-cart').prop('disabled', true);
                    }
                    else {
                        $('#ap5-pack-product-' + packId + ' .product-additional-info .dd_available').removeClass('hidden');
                        $('button.add-to-cart').prop('disabled', false);
                    }
                },
                error: function(data) {
                    console.log("error data", data);
                }
            });
        }
    }
</script>
<style>
    #product-availability {
        display: none;
    }
</style>
{if isset($available_text)}
    <div class="dd_available">
        <div class="dd-info-container">
            <div class="dd-text">Date de livraison estimée:</div>
            <div class="dd-estimated-date">{$available_text|escape:'quotes':'UTF-8'}</div>
        </div>
    </div>
{/if}

<script type="text/javascript">
    let getDeliveryDatesUrl = '{$getDeliveryDatesUrl|escape:'htmlall':'UTF-8'}';
    let shopId = '{$shopId}';
    let productUnavailable = false;
    {if isset($product_unavailable) && $product_unavailable}
        productUnavailable = true;
    {/if}
    setProductAsUnorderable(productUnavailable);

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
</script>
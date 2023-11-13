{*
*  Module made by Nukium
*
*  @author    Nukium
*  @copyright 2021 Nukium SAS
*  @license   All rights reserved
*
* ███    ██ ██    ██ ██   ██ ██ ██    ██ ███    ███
* ████   ██ ██    ██ ██  ██  ██ ██    ██ ████  ████
* ██ ██  ██ ██    ██ █████   ██ ██    ██ ██ ████ ██
* ██  ██ ██ ██    ██ ██  ██  ██ ██    ██ ██  ██  ██
* ██   ████  ██████  ██   ██ ██  ██████  ██      ██
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*}
<div class="clearfix"></div>
<div class="estimated_delivery_date" style="display: {if $force_hide}none{else}block{/if};">
    <div class="estimated_delivery_date_wrapper">
        <div id="estimated_delivery_date_content" class="estimated_delivery_date_content">
            <p>
                {l s='Expected delivery date :' mod='nkmdeliverydate'}<br />
                <span class="estimated_delivery_date_value">{$delivery_date|escape:'htmlall':'UTF-8'}</span>
            </p>
            {if isset($products)}
                <ul class="estimated_delivery_date_extra_content mb-0 text-muted">
                    {foreach from=$products item=item key=key}
                        <li>{$item['product_name']} : {$item['delivery_date']}</li>
                    {/foreach}
                </ul>
            {/if}
        </div>
    </div>
</div>
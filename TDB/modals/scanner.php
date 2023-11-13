<!-- Scanner Modal -->
<div tabindex="0" class="modal fade" id="scannerModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Scanner</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form>

                <select name="status" id="status">
                    <option value="0">NON TRAITÉ</option>
                    <option value="1">COMMANDE</option>
                    <option value="2">STOCK</option>
                    <option value="3">RUPTURE OK</option>
                    <option value="4">RELIQUAT OK</option>
                    <option value="5">RUPTURE ATTENTE</option>
                    <option value="6">RELIQUAT ATTENTE</option>
                    <option value="7">RECU</option>
                    <option value="8">FLEX SORTIE</option>
                    <option value="9">MARQUAGE / PRET</option>
                    <option value="10">EXPEDITION</option>
                    <option value="11">LIVRÉ</option>
                </select>
            </form>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
    <!-- Image loader -->
    <div id='scanner-loader' class="loader" style='display: none;'>
        <img src='assets/images/loading.gif' width='200px' height='200px'>
    </div>
</div>



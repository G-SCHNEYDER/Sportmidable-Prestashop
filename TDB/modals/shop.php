<!-- Message Modal -->
<div class="modal fade" id="messageModal" role="dialog">
    <div class="modal-dialog modal-lg">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Messages</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">

                <div class="message-modal-body">
                    <!-- load messages here -->
                </div>

                <form>
                    <div class="form-group">
                        <select name="message_name" id="message-name" class="form-control">
                            <option value="">Sélectionner un type de message</option>
                            <?php foreach ($orderMessages as $orderMessage) : ?>
                                <option value="<?php echo $orderMessage['id_order_message']; ?>"><?php echo $orderMessage['name']; ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="form-group">
                        <textarea name="message" class="new-message form-control" id="new-message" rows="5"
                                  cols="50"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="visibility">Privé</label>
                        <select name="visibility" id="visibility" class="form-control">
                            <option value="1">Oui</option>
                            <option value="0" selected>Non</option>
                        </select>
                    </div>

                    <input type="hidden" name="id_order" id="id-order" value="">
                    <input type="hidden" name="id_employee" id="id-employee" value="">
                </form>
            </div>
            <script type="application/json" id="message-bodies"><?php echo json_encode($orderMessages); ?></script>
            <div class="modal-footer">
                <button type="button" class="btn btn-success" id="save-message">Sauvegarder</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
    <!-- Image loader -->
    <div id='loader' class="message-loader" style='display: none;'>
        <img src='assets/images/loading.gif' width='200px' height='200px'>
    </div>
</div>


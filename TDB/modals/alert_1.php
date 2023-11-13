<!-- Alerts Modal -->
<div class="modal fade" id="alert-1-Modal" role="dialog">
    <div class="modal-dialog modal-xl">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Alertes Commande</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="alerts-modal-body">
                <?php if (count($alerts[1])) : ?>
                    <table class="table alert-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Boutique</th>
                            <th>Ref produit</th>
                            <th>Nom produit</th>
                            <th>Date status</th>
                            <th>Jours retard</th>
                        </tr>
                        </thead>
                        <tbody>
                        <?php foreach ($alerts[1] as $alert) : ?>
                            <tr>
                                <td><?php echo $alert['id_order']; ?></td>
                                <td><?php echo $alert['shop_name']; ?></td>
                                <td><?php echo $alert['product_reference']; ?></td>
                                <td><?php echo $alert['product_name']; ?></td>
                                <td><?php echo convert_date($alert['status_date']); ?></td>
                                <td><?php echo $alert['days_late']; ?></td>
                            </tr>
                        <?php endforeach; ?>
                        </tbody>
                    </table>
                <?php endif; ?>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id='print-alert-1'>Imprimer</button>
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Fermer</button>
            </div>
        </div>
    </div>
    <!-- Image loader -->
    <div id='alert-1-loader' class="loader" style='display: none;'>
        <img src='assets/images/loading.gif' width='200px' height='200px'>
    </div>
</div>

<div class="modal fade" id="shopsModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Commandes par club</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="parclubShop">Choix du club</label>
					<select id="parclubShop" class="select2" name="parclubShop" required>
						<option value="">----------</option>
						<?php if (!empty($shops)) {
							foreach ($shops as $shop) { ?>
								<option value="<?php echo $shop['id_shop']; ?>"><?php echo $shop['name']; ?></option>
							<?php }
						} ?>
					</select>
				</div>
				<div class="form-group">
					<label for="parclubStatut">Choix du statut</label>
					<select id="parclubStatut" class="form-control" name="parclubStatut" required>
						<option value="encours">En cours</option>
						<option value="livre">En cours + Livré</option>
						<option value="all">Toutes</option>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<a href="#" id="parclub" class="btn btn-primary btn-lg">Visualiser</a>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Fermer</button>
			</div>
		</div>
	</div>
</div>

<script>
	$("#parclub").on("click", function (e) {
		e.preventDefault();
		window.location.href = '/TDB/?commandes=shop&shop=' + $('#parclubShop').val() +
			'&statut=' + $('#parclubStatut').val();
	});
</script>


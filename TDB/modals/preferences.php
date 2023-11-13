<div class="modal fade" id="preferencesModal" role="dialog">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">Préférences</h4>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="form-group">
					<label for="preferencesPagination">Nombre de résultats à afficher par page</label>
					<select id="preferencesPagination" class="form-control" name="preferencesPagination" required>
						<option value="25"<?php echo empty($_SESSION['pagination']) || (!empty($_SESSION['pagination']) && $_SESSION['pagination'] == 25) ? ' selected' : ''; ?>>
							25
						</option>
						<option value="50"<?php echo !empty($_SESSION['pagination']) && $_SESSION['pagination'] == 50 ? ' selected' : ''; ?>>50
						</option>
						<option value="100"<?php echo !empty($_SESSION['pagination']) && $_SESSION['pagination'] == 100 ? ' selected' : ''; ?>>100
						</option>
						<option value="200"<?php echo !empty($_SESSION['pagination']) && $_SESSION['pagination'] == 200 ? ' selected' : ''; ?>>200
						</option>
						<option value="all"<?php echo !empty($_SESSION['pagination']) && $_SESSION['pagination'] == 10000 ? ' selected' : ''; ?>>Tout
							afficher
						</option>
					</select>
				</div>
			</div>
			<div class="modal-footer">
				<a href="#" id="enregistrer" class="btn btn-primary btn-lg">Enregistrer</a>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">Fermer</button>
			</div>
		</div>
	</div>
</div>

<script>

	function insertParam(key, value) {
		key = encodeURIComponent(key);
		value = encodeURIComponent(value);

		var kvp = document.location.search.substr(1).split('&');
		let i = 0;

		for (; i < kvp.length; i++) {
			if (kvp[i].startsWith(key + '=')) {
				let pair = kvp[i].split('=');
				pair[1] = value;
				kvp[i] = pair.join('=');
				break;
			}
		}

		if (i >= kvp.length) {
			kvp[kvp.length] = [key, value].join('=');
		}

		let params = kvp.join('&');

		document.location.search = params;
	}

	$("#enregistrer").on("click", function (e) {
		e.preventDefault();
		insertParam('pagination', $('#preferencesPagination').val());
	});
</script>


<?php if (!empty($_POST['id'])) {
	if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
		$allowed = ['jpg' => 'image/jpeg'];
		$filename = $_FILES['image']['name'];
		$filetype = $_FILES['image']['type'];
		$filesize = $_FILES['image']['size'];
		$ext = pathinfo($filename, PATHINFO_EXTENSION);
		if (!array_key_exists($ext, $allowed)) {
			echo "<script>Swal.fire('ERREUR', 'Veuillez sélectionner un format de fichier valide.', 'error');</script>";
		}
		$maxsize = 5 * 1024 * 1024;
		if ($filesize > $maxsize) {
			echo "<script>Swal.fire('ERREUR', 'La taille du fichier est supérieure à la limite autorisée.', 'error');</script>";
		}
		if (in_array($filetype, $allowed)) {
			move_uploaded_file(
				$_FILES['image']['tmp_name'],
				_PS_ROOT_DIR_ . '/upload/guidedestailles/' .
				$_POST['id'] . '.' . $ext
			);
			echo "<script>Swal.fire('BRAVO', 'Votre fichier a été téléchargé avec succès.', 'success');</script>";
		} else {
			echo "<script>Swal.fire('ERREUR', 'Veuillez sélectionner un format de fichier valide.', 'error');</script>";
		}
	} else {
		echo "<script>Swal.fire('ERREUR', '" . $_FILES['image']['error'] . "', 'error');</script>";
	}
} ?>

<div class="content">

	<div class="table-responsive">
		<table class="table table-striped table-bordered table-hover">
			<thead class="thead-dark">
			<tr>
				<th>N°</th>
				<th>Nom</th>
				<th>Image JPG</th>
				<th>Editer</th>
			</tr>
			</thead>
			<tbody>
			<?php $datas = Dashboard::getManufacturers();
			if (!empty($datas)) {
				foreach ($datas as $data) { ?>

					<tr>
						<td><?php echo $data[0]; ?></td>
						<td><?php echo $data[1]; ?></td>
						<td>
							<?php if (file_exists(_PS_ROOT_DIR_ . '/upload/guidedestailles/' . $data[0] . '.jpg')) { ?>
								<a href="/upload/guidedestailles/<?php echo $data[0]; ?>.jpg?<?php echo uniqid(); ?>"
								   target="_blank">
									<img src="/upload/guidedestailles/<?php echo $data[0]; ?>.jpg?<?php echo uniqid(); ?>"
										 alt="<?php echo
										 $data[1]; ?>"
										 style="max-height: 60px"/>
								</a>
							<?php } ?>
						</td>
						<td>
							<form enctype="multipart/form-data" class="form-inline" method="post">
								<input type="hidden" name="id" value="<?php echo $data[0]; ?>"/>
								<input type="file" class="form-control" name="image">
								<button type="submit" class="btn btn-primary ml-2">Ok</button>
							</form>
						</td>
					</tr>

				<?php }
			} ?>
			</tbody>
		</table>
	</div>

</div>
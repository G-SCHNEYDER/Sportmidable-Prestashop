// Variables declared as global in order to get them farther in the code.
var table = null;
var buildSelect = null;

$(document).ready(function () {
	let today = new Date();
	var filename = today.getFullYear() + '-' + ('0' + (today.getMonth() + 1)).slice(-2) + '-' + ('0' + (today.getDate())).slice(-2) + '-export';

	table = $('#dashboard').DataTable({

		fixedHeader: {
			header: true,
			footer: false
		},

		/*fixedColumns: {
			leftColumns: 1
		},*/
		paging: false,
		language: {
			url: 'https://cdn.datatables.net/plug-ins/1.10.21/i18n/French.json',
			buttons: {
				copyHtml5: 'Copier',
				copyTitle: 'Ajouté au presse-papiers',
				copyKeys: 'Appuyez sur <i>ctrl</i> ou <i>\u2318</i> + <i>C</i> pour copier les données du tableau à votre presse-papiers. <br><br>Pour annuler, cliquez sur ce message ou appuyez sur Echap.',
				copySuccess: {
					_: '%d lignes copiées',
					1: '1 ligne copiée'
				}
			}
		},
		lengthMenu: [[10, 25, 50, 100, -1], [10, 25, 50, 100, "Tout voir"]],
		iDisplayLength: 100,
		dom: 'Blfrtip',
		//deferRender: true,
		//order: [], // Disable ordering
		columnDefs: [
			{targets: 0, orderable: false},
			{targets: 1, className: 'noVis'},
			{targets: 5, type: 'html'},
		],
		buttons: [
			{
				extend: 'colvis',
				columns: ':not(.noVis)',
				text: function (dt, button, config) {
					return dt.i18n('buttons.colvis', 'Visibilité Colonne');
				}
			},
			{
				extend: 'copyHtml5',
				exportOptions: {
					columns: ':visible'
				},
				text: function (dt, button, config) {
					return dt.i18n('buttons.copyHtml5', 'Copier');
				}
			},
			{
				extend: 'csvHtml5',
				exportOptions: {
					columns: ':visible.exportable',
				},
				filename: function () {
					return filename;
				}
			},
			{
				extend: 'excelHtml5',
				exportOptions: {
					columns: ':visible.exportable'
				},
				filename: function () {
					return filename;
				}
			},
			{
				extend: 'pdfHtml5',
				exportOptions: {
					columns: ':visible.exportable'
				},
				filename: function () {
					return filename;
				}
			},
			{
				extend: 'print',
				exportOptions: {
					columns: ':visible'
				},
				text: function (dt, button, config) {
					return dt.i18n('buttons.print', 'Imprimer');
				}
			}
		],
		orderCellsTop: true,
		initComplete: function () {
			this.api().columns([4, 5, 6, 7, 9, 10, 11, 12, 13, 18, 22, 24, 26, 27, 28, 29]).every(function () {
				var column = this;

				var width = '';
				if (column.index() == 12) {
					width = ' style="width: 300px;"';
				}

				var select = $('<select' + width + '><option value=""></option></select>')
					.appendTo($('thead tr:eq(1) td').eq(column.index()))
					.on('change', function () {
						var val = $.fn.dataTable.util.escapeRegex(
							$(this).val()
						);
						if (val === "\\(Vide\\)") {
							column.search('^$', true, false).draw();
						} else {
							column.search(val ? '^' + val + '$' : '', true, false).draw();
						}
					});

				if (column.index() == 1) {

					column.data().unique().each(function (d, j) {
						select.append('<option value="' + d + '">' + d + '</option>')
					});

				} else if (column.index() == 5) {

					var dataUnique = column.data();
					var dataSansHtml = [];

					dataUnique.each(function (d, j) {
						dataSansHtml.push($(d).text());
					});

					var unique = dataSansHtml.filter(function (elem, pos) {
						return dataSansHtml.indexOf(elem) == pos;
					});

					unique.sort().forEach(function (item, index, array) {
						select.append('<option value="' + item + '">' + item + '</option>')
					});

				} else {

					column.data().unique().sort().each(function (d, j) {
						if (d === '') {
							d = '(Vide)';
						}
						select.append('<option value="' + d + '">' + d + '</option>')
					});
				}
			});
		}
	});

	// Rebuilds a given filter drop down list.
	buildSelect = function (table, columnIds) {
		table.columns(columnIds).every(function () {
			var column = this;
			var select = $('<select><option value=""></option></select>')
				.appendTo($('thead tr:eq(1) td').eq(column.index()).empty())
				.on('change', function () {
					var val = $.fn.dataTable.util.escapeRegex(
						$(this).val()
					);
					column
						.search(val ? '^' + val + '$' : '', false, false)
						.draw();
				});

			column.data().unique().sort().each(function (d, j) {
				select.append('<option value="' + d + '">' + d + '</option>')
			});
		});
	}

	// Event listeners to the two range filtering inputs to redraw on input
	$('#search-date-range').click(function () {
		table.draw();
	});

	$('#reset-search-date-range').click(function () {
		$('#start-date').val('');
		$('#end-date').val('');
		table.draw();
	});

	// Event listeners to the order id filtering input to redraw on input
	$('#btn-search-order-id').click(function () {
		table.draw();
	});

	$('#btn-reset-order-id').click(function () {
		$('#order-id').val('');
		table.draw();
	});

	// Event listeners to the keyword filtering input to redraw on input
	$('#btn-search-keyword').click(function () {
		table.draw();
	});

	$('#btn-reset-keyword').click(function () {
		$('#keyword').val('');
		table.draw();
	});

	$('#btn-reset-all').click(function () {
		$('#keyword').val('');
		$('#order-id').val('');
		$('#start-date').val('');
		$('#end-date').val('');
		table.draw();
	});
});


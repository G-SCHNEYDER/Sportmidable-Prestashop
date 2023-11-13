(function ($) {

	// Run a function when the page is fully loaded including graphics.
	$(window).on('load', function () {
		$('.select2').select2();
		$("#date_ag").datepicker({dateFormat: 'dd/mm/yy'});
		$("#go_ag").click(function () {
			var status = $("#status_ag").val();
			var date = $('#date_ag').datepicker('getDate');

			$("input[name='ag']:checked").each(function (index) {

				var detailId = $(this).parents("tr").attr("data-order-detail-id");
				var orderId = $(this).parents("tr").attr("data-order-id");
				var rowId = table.row($(this).parents("tr")).index()
				$.fn.saveStatusDateAG(status, detailId, date, rowId, orderId);
			});
		});

		$("#dashboard").on("click", "#togglecheck", function () {
			if ($(this).attr("data-etat") == "on") {
				$("input[name='ag']").prop("checked", true);
				$(this).attr("data-etat", "off");
			} else {
				$("input[name='ag']").prop("checked", false);
				$(this).attr("data-etat", "on");
			}

		});

		//factures AG
		$("#factures_ag").click(function () {
			var tabIdsOrders = [];
			$("input[name='ag']:checked").each(function () {
				var idorder = $(this).parents("tr").find("[id^=info-order-id]").text();
				if ($.inArray(idorder, tabIdsOrders) == -1) {
					tabIdsOrders.push(idorder);
				}
			});

			if (tabIdsOrders.length > 0) {
				$("#lienfactures").attr("href", "/admin968bkzk7v/index.php?controller=AdminPdf&submitAction=generateInvoicePDF&ids_orders=" + tabIdsOrders.join())[0].click();
				//console.log(tabIdsOrders.join());
			}


		});


		$('#dashboard').on('click', '.edit-message', function () {
			$.fn.loadMessages(this);
		});

		$('#dashboard').on('click', '.summary', function () {
			$.fn.loadSummary(this);
		});

		$('#dashboard').on('click', '.sendcommentaire', function () {
			$.ajax({
				method: "POST",
				url: "/TDB/ajax/default.php",
				data: {
					idOrderDetail: $(this).parents("tr").attr("data-order-detail-id"),
					message: $(this).prev().val(),
					action: "savecommentaire"
				}
			})
				.done(function (msg) {
					//alert("Commentaire enregistré");
				});

		});

		$('#dashboard').on('click', '.sendremarquelivraison', function () {
			$.ajax({
				method: "POST",
				url: "/TDB/ajax/default.php",
				data: {
					idOrderDetail: $(this).parents("tr").attr("data-order-detail-id"),
					message: $(this).prev().val(),
					action: "saveremarquelivraison"
				}
			})
				.done(function (msg) {
					//alert("Commentaire enregistré");
				});

		});


		$('#save-message').click(function () {
			if ($('#new-message').val() == '') {
				alert('Champ "Message" invalide !');
				return;
			}

			$.fn.saveMessage(this);
		});

		//
		$('#dashboard').on('click', 'td[id^="status-date-label-"]', function () {
			//$('#status-date').datepicker('destroy');
			$('#status-date').datepicker({
				dateFormat: 'dd/mm/yy',
				showButtonPanel: true,
				onClose: function (dateText, inst) {
					// Hides the datepicker.
					$('#datepicker-stash').append($('#status-date'));
				},
				onSelect: function (dateText) {
					// Gets the <td> parent element and the row index.
					let td = $('#' + this.id).parent();
					let rowId = table.row(td).index();

					$.fn.saveStatusDate(td, rowId);

					// Hides the datepicker.
					$('#datepicker-stash').append($('#status-date'));
				},
			});

			$.fn.changeStatusDate($(this));
		});

		$('#dashboard').on('click', 'input[id^="status-"]', function () {
			// Gets the parent element (cell).
			let td = $('#' + this.id).parent();
			let rowId = table.row(td).index();

			$.fn.saveStatus(this, rowId);
		});

		$('#dashboard').on('click', 'button[id^="status-reset-"]', function () {
			// Gets the parent element (cell).
			let td = $('#' + this.id).parent();
			let rowId = table.row(td).index();

			$.fn.resetStatus($(this), rowId);
		});

		$('.alerts').on('click', function () {
			$.fn.loadAlerts(this);
		});
		$('.scanner').on('click', function () {
			$.fn.loadScanner(this);
		});

		$('#dashboard-buttons').append($('#init-alerts>button'));

		$('#start-date').datepicker({dateFormat: 'dd/mm/yy'});
		$('#end-date').datepicker({dateFormat: 'dd/mm/yy'});

		$('button[id^="print-alert-"]').click(function () {
			window.print();
		});

		$('#message-name').change(function () {
			$.fn.setMessageBody($(this));
		});
	});

	$(document).on('keyup', '#scannerModal', function (e) {
		var code = e.keyCode || e.which;

		if (code === 9) {
			e.preventDefault();
			let statusId = $('#scanner-status').val();
			//alert('it works! ' + statusId);
		}
	});

	/*
	 * Date range filter plugin.
	 * https://datatables.net/plug-ins/filtering/row-based/range_dates
	 */
	$.fn.dataTableExt.afnFiltering.push(
		function (oSettings, aData, iDataIndex) {
			var iFini = document.getElementById('start-date').value;
			var iFfin = document.getElementById('end-date').value;
			// Gets the column number to search.
			var columnToSearch = $('#status-column').val();
			var iStartDateCol = columnToSearch;
			var iEndDateCol = columnToSearch;

			iFini = iFini.substring(6, 10) + iFini.substring(3, 5) + iFini.substring(0, 2);
			iFfin = iFfin.substring(6, 10) + iFfin.substring(3, 5) + iFfin.substring(0, 2);

			var datofini = aData[iStartDateCol].substring(6, 10) + aData[iStartDateCol].substring(3, 5) + aData[iStartDateCol].substring(0, 2);
			var datoffin = aData[iEndDateCol].substring(6, 10) + aData[iEndDateCol].substring(3, 5) + aData[iEndDateCol].substring(0, 2);

			if (iFini === "" && iFfin === "") {
				return true;
			} else if (iFini <= datofini && iFfin === "") {
				return true;
			} else if (iFfin >= datoffin && iFini === "") {
				return true;
			} else if (iFini <= datofini && iFfin >= datoffin) {
				return true;
			}
			return false;
		});


	/*
	 * Order id filter plugin.
	 * Example: https://datatables.net/examples/plug-ins/range_filtering.html
	 */
	$.fn.dataTable.ext.search.push(
		function (settings, data, dataIndex) {
			var orderId = document.getElementById('order-id').value;
			var keyword = document.getElementById('keyword').value;
			orderId = orderId.trim();
			keyword = keyword.trim();
			// Checks for a valid value.
			if ((orderId == '' || isNaN(orderId)) && keyword == '') {
				return true;
			}

			let searchOrderId = false;
			if (orderId != '' && !isNaN(orderId)) {
				searchOrderId = true;
			}

			let isMatch = false;
			if (keyword != '') {
				let searchColumnIds = [3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 30, 31];
				let pattern = new RegExp('^' + keyword, 'i');
				for (let i = 0; i < searchColumnIds.length; i++) {
					if (pattern.test(data[searchColumnIds[i]])) {
						isMatch = true;
						break;
					}
				}
			}


			// Gets the value of the column number to search.
			var columnValue = data[1];

			if (searchOrderId && orderId != columnValue) {
				return false;
			}

			if (keyword != '' && !isMatch) {
				return false;
			}

			return true;
		});


	$.fn.loadSummary = function (elem) {
		let detailId = elem.dataset.detail;
		let orderId = elem.dataset.order;
		let productId = elem.dataset.product;

		let fields = ['order-id', 'country', 'shop', 'date', 'last-name', 'first-name', 'phone', 'category', 'reference', 'designation', 'brand', 'quantity', 'color-1', 'color-2', 'size', 'labeling', 'delivering-mode', 'shipping-number', 'status-label', 'status-date-label-1', 'status-date-label-2', 'status-date-label-3', 'status-date-label-5', 'status-date-label-6', 'status-date-label-7', 'status-date-label-8', 'nb-messages'];

		fields.forEach(function (field) {

			let prefix = 'info-';
			// N.B: Ids starting with "status-" cannot be modified.
			if (field.startsWith('status-')) {
				prefix = '';
			}

			// N.B: Id starting with "nb-messages-" cannot be modified.
			if (field.startsWith('nb-messages')) {
				var value = $('#' + field + '-' + orderId + '-' + productId).html();
			} else {
				var value = $('#' + prefix + field + '-' + detailId).html();
			}

			$('#summary-' + field).html(value);
		});
	}

	$.fn.loadMessages = function (elem) {
		// Gets the json data in the javascript tag.
		let dataId = 'message-data-' + elem.dataset.order + '-' + elem.dataset.product;
		let dataJson = $('#' + dataId).html();
		let messages = JSON.parse(dataJson);
		// Cleans fields.
		$('.message-modal-body').empty();
		$('#new-message').val('');
		$('#message-name').val('');
		$('#visibility').val(0);

		// Builds the messages in the modal window.
		for (let i in messages) {
			var container = $('<div id="message-container-' + i + '" class="mb-3 pb-3 border-bottom"></div>');
			$('.message-modal-body').append(container);
			console.log(messages[i].employe);
			var employee = $("<div class='font-italic'></div>").text(messages[i].employe);
			var date = $("<div class='font-weight-bold'></div>").text(messages[i].date);
			var message = $("<div></div>").text(messages[i].message);
			$('#message-container-' + i).append(employee, date, message);
		}

		// Assigns both order and employee ids to the hidden tags.
		$('#id-order').val(elem.dataset.order);
		$('#id-employee').val(elem.dataset.employee);

		$('#messageModal').modal('show');
	}

	$.fn.saveMessage = function (elem) {
		// Gets all the needed arguments.
		let message = $('#new-message').val();
		let visibility = $('#visibility').val();
		let idOrder = $('#id-order').val();
		let employeeId = $('#employee-id').val();

		// Runs the ajax call.
		$.ajax({
			type: 'GET',
			url: 'ajax/savemessage.php',
			dataType: 'json',
			data: {'message': message, 'visibility': visibility, 'id_order': idOrder, 'employee_id': employeeId},
			beforeSend: function () {
				// Show image container
				$("#loader").show();
			},
			//Get result as a json object.
			success: function (result, textStatus, jqXHR) {
				// Sets the result message.
				let message = 'Le message a été sauvegardé avec succès.';
				if (result.status != 200) {
					message = result.error;
				}

				$.fn.refreshMessageData(idOrder);

				$("#loader").hide('slow', function () {
					//alert(message);
				});

				$('#messageModal').modal('hide');
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				$("#loader").hide('slow', function () {
					alert(textStatus + ': ' + errorThrown);
				});
			}
		});
	}

	$.fn.refreshMessageData = function (idOrder) {
		$.ajax({
			type: 'GET',
			url: 'ajax/refreshmessages.php',
			dataType: 'text',
			data: {'id_order': idOrder},
			//Get result as a json in raw text.
			success: function (result, textStatus, jqXHR) {
				$('[id^="message-data-' + idOrder + '-"]').each(function (i) {
					$(this).empty();
					$(this).append(result);
				});

				let messages = JSON.parse(result);
				$('[id^="nb-messages-' + idOrder + '-"]').each(function (i) {
					$(this).html(messages.length);
				});
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				alert(textStatus + ': ' + errorThrown);
			}
		});
	}

	$.fn.setMessageBody = function (elem) {
		let messageId = elem.val();

		if (messageId == '') {
			return;
		}

		let dataJson = $('#message-bodies').html();
		let messages = JSON.parse(dataJson);

		$.each(messages, function (index, value) {
			if (value.id_order_message == messageId) {
				$('#new-message').val(value.message);
			}
		});
	}

	// Only used for status id 3 and 4.
	$.fn.saveStatus = function (elem, rowId) {
		let statusId = elem.value;
		let detailId = elem.dataset.detail;
		let date = $('#status-date-label-3-' + detailId).attr('data-date');

		$.ajax({
			type: 'GET',
			url: 'ajax/savestatus.php',
			dataType: 'json',
			data: {'status_id': statusId, 'detail_id': detailId, 'date': date},
			//Get result as a json object.
			success: function (result, textStatus, jqXHR) {
				// Sets the result message.
				let message = 'Le status a été sauvegardé avec succès.';
				if (result.status != 200) {
					message = result.error;
				}

				let dataJson = $('#status-labels').html();
				let labels = JSON.parse(dataJson);

				//Refresh the status label and color.
				$('#status-label-' + detailId).attr('data-currentstatus', statusId);
				$('#product-row-' + detailId).removeClass();
				$('#product-row-' + detailId).addClass('status-' + statusId);
				// Updates the data of the current status column cell then redraw the table.
				table.cell({row: rowId, column: 22}).data(labels[statusId]);
				buildSelect(table, [22]);

				//alert(message);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				alert(textStatus + ': ' + errorThrown);
			}
		});
	}

	$.fn.resetStatus = function (elem, rowId) {
		let detailId = elem.attr('data-detail');

		$.ajax({
			type: 'GET',
			url: 'ajax/resetstatus.php',
			dataType: 'json',
			data: {'detail_id': detailId},
			//Get result as a json object.
			success: function (result, textStatus, jqXHR) {
				// Sets the result message.
				let message = 'Le status a été réinitialisé avec succès.';
				if (result.status != 200) {
					message = result.error;
				}

				$.fn.uncheckShortageRemainder(detailId);
				let dataJson = $('#status-labels').html();
				let labels = JSON.parse(dataJson);

				// Refresh the status label and color.
				$('#status-label-' + detailId).attr('data-currentstatus', 0);
				$('#product-row-' + detailId).removeClass();
				$('#product-row-' + detailId).addClass('status-0');
				// Updates the data of the current status column cell then redraw the table.
				table.cell({row: rowId, column: 22}).data(labels[0]);
				buildSelect(table, [22]);

				// Refresh the status date label and data.
				for (let i = 1; i < 9; i++) {
					if (i == 4) {
						// Status id 4 is embbeded in the same cell than status id 3.
						continue;
					}
					$('#status-date-label-' + i + '-' + detailId).attr('data-date', '');
					$('#status-date-label-' + i + '-' + detailId).html('Saisir date');
				}

				//alert(message);
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				alert(textStatus + ': ' + errorThrown);
			}
		});
	}

	$.fn.changeStatusDate = function (elem) {
		// Checks date in the datasettings.
		if (elem.attr('data-date') != '' && elem.attr('data-date') != '0000-00-00') {
			let date = elem.attr('data-date');
			$('#status-date').datepicker('setDate', $.datepicker.parseDate('yy-mm-dd', date));
		} else {
			// Reset the date field.
			$('#status-date').datepicker('setDate', null);
		}

		$('#' + elem.attr('id')).append($('#status-date'));

		$('#status-date').datepicker('show');
	}

	$.fn.saveStatusDateAG = function (statusId, detailId, date = '', rowId, orderId) {
		let jsDate = '';
		if (date == '') {
			jsDate = $('#status-date').datepicker('getDate');
		} else {
			jsDate = date;
		}

		if (statusId == 4) {
			// Gets the "real" status (ie: 3 or 4).
			//statusId = $.fn.getShortageRemainderId(detailId);
			$('#status-' + statusId + '-' + detailId).prop('checked', true);
			console.log('#status-' + statusId + '-' + detailId);
		} else {
			$.fn.uncheckShortageRemainder(detailId);
		}

		if (jsDate !== null) {
			jsDate instanceof Date; // -> true
			var day = ('0' + (jsDate.getDate())).slice(-2);
			var month = ('0' + (jsDate.getMonth() + 1)).slice(-2);
			var year = jsDate.getFullYear();
			date = year + '-' + month + '-' + day;
		}

		$.ajax({
			type: 'GET',
			url: 'ajax/savestatusdate.php',
			dataType: 'json',
			data: {'status_id': statusId, 'date': date, 'detail_id': detailId, 'order_id': orderId},
			//Get result as a json object.
			success: function (result, textStatus, jqXHR) {
				// Sets the result message.
				let message = 'La date de status a été sauvegardée avec succès.';
				if (result.status != 200) {
					message = result.error;
				}

				//alert(message);

				let dataJson = $('#status-labels').html();
				let labels = JSON.parse(dataJson);
				//Refresh the status label and color.
				$('#status-label-' + detailId).attr('data-currentstatus', statusId);
				$('#product-row-' + detailId).removeClass();
				$('#product-row-' + detailId).addClass('status-' + statusId);

				// Updates the data of the current status column cell then redraw the table.
				table.cell({row: rowId, column: 22}).data(labels[statusId]);
				buildSelect(table, [22]);

				// The cell is set to 3 by default as the date is for both 3 and 4 statuses. (Stupid !!!!)
				if (statusId == 4) {
					statusId = 3;
				}

				// Refresh both date data and label.
				$('#status-date-label-' + statusId + '-' + detailId).attr('data-date', date);

				if (date != '') {
					$('#status-date-label-' + statusId + '-' + detailId).html(day + '/' + month + '/' + year);
				} else {
					$('#status-date-label-' + statusId + '-' + detailId).html('');
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				$("#status-date-loader").hide('slow', function () {
					alert(textStatus + ': ' + errorThrown);
				});
			}
		});
	}

	$.fn.saveStatusDate = function (elem, rowId, date = '') {
		let jsDate = '';
		if (date == '') {
			jsDate = $('#status-date').datepicker('getDate');
		} else {
			jsDate = date;
		}

		let statusId = elem.attr('data-status');
		let detailId = elem.attr('data-detail');
		let orderId = elem.attr('data-order');
		let employeeId = elem.attr('data-employee');

		if (statusId == 4) {
			// Gets the "real" status (ie: 3 or 4).
			//statusId = $.fn.getShortageRemainderId(detailId);
			$('#status-' + statusId + '-' + detailId).prop('checked', true);
			console.log('#status-' + statusId + '-' + detailId);
		} else {
			$.fn.uncheckShortageRemainder(detailId);
		}

		if (jsDate !== null) {
			jsDate instanceof Date; // -> true
			var day = ('0' + (jsDate.getDate())).slice(-2);
			var month = ('0' + (jsDate.getMonth() + 1)).slice(-2);
			var year = jsDate.getFullYear();
			date = year + '-' + month + '-' + day;
		}

		$.ajax({
			type: 'GET',
			url: 'ajax/savestatusdate.php',
			dataType: 'json',
			data: {'status_id': statusId, 'date': date, 'detail_id': detailId, 'order_id': orderId, 'employee_id': employeeId},
			//Get result as a json object.
			success: function (result, textStatus, jqXHR) {
				// Sets the result message.
				let message = 'La date de status a été sauvegardée avec succès.';
				if (result.status != 200) {
					message = result.error;
				}

				//alert(message);

				let dataJson = $('#status-labels').html();
				let labels = JSON.parse(dataJson);
				//Refresh the status label and color.
				$('#status-label-' + detailId).attr('data-currentstatus', statusId);
				$('#product-row-' + detailId).removeClass();
				$('#product-row-' + detailId).addClass('status-' + statusId);

				// Updates the data of the current status column cell then redraw the table.
				table.cell({row: rowId, column: 22}).data(labels[statusId]);
				buildSelect(table, [22]);

				// The cell is set to 3 by default as the date is for both 3 and 4 statuses. (Stupid !!!!)
				if (statusId == 4) {
					statusId = 3;
				}

				// Refresh both date data and label.
				$('#status-date-label-' + statusId + '-' + detailId).attr('data-date', date);

				if (date != '') {
					$('#status-date-label-' + statusId + '-' + detailId).html(day + '/' + month + '/' + year);
				} else {
					$('#status-date-label-' + statusId + '-' + detailId).html('');
				}
			},
			error: function (jqXHR, textStatus, errorThrown) {
				//Display the error.
				$("#status-date-loader").hide('slow', function () {
					alert(textStatus + ': ' + errorThrown);
				});
			}
		});
	}

	$.fn.getShortageRemainderId = function (detailId) {
		if ($('#status-3-' + detailId).is(':checked')) {
			return 3;
		}

		if ($('#status-4-' + detailId).is(':checked')) {
			return 4;
		}

		// Default
		return 3;
	}

	$.fn.uncheckShortageRemainder = function (detailId) {
		$('#status-3-' + detailId).prop('checked', false);
		$('#status-4-' + detailId).prop('checked', false);
	}

	$.fn.loadAlerts = function (elem) {
		$('#alert-' + elem.dataset.status + '-Modal').modal('show');
	}

	$.fn.loadScanner = function (elem) {
		$('#scannerModal').modal('show');

	}
})(jQuery);

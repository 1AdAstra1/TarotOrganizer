/*
 * The whole editor
 */

/**
 * Editor object prototype constructor
 */
var Editor = function(containerId, savedStructure) {
	var parent = $(containerId);
	parent.css({
		'position' : 'relative'
	});
	this.container = $('<div id="editor-wrapper"></div>').appendTo(parent);
	this.settings = EditorSettings;
	this.createWidgets();
	this.defaultPositionSize = this.buttons.positionSize.val();
	this.defaultGrid = this.buttons.grid.val();
	this.addEvents();
	if(savedStructure) {
		this.savedStructure = JSON.parse(savedStructure);
		this.field.css({
			width : this.savedStructure.width,
			height : this.savedStructure.height
		});
		this.activeDeck = this.savedStructure.deck;
		this.buttons.deck.val(this.activeDeck);
		this.defaultPositionSize = this.savedStructure.size;
		this.buttons.positionSize.val(this.defaultPositionSize);
	}
	this.loadDeck(this.activeDeck);
};
/**
 * Adds the editor-specific (spread-independent) event handlers
 */
Editor.prototype.addEvents = function() {
	//Make the field resizable
	this.field.resizable();

	this.buttons.newSpread.click($.proxy(function(e) {
		e.preventDefault();
		if(this.spread.hasPositions()) {
			this.confirm('Очистка уничтожит все ранее введённые данные. Вы уверены?', this.createSpread, this);
		} else {
			this.createSpread();
		}
	}, this));

	this.positionDialog.bind('dialogreload', $.proxy(function() {
		this.reloadDialog();
	}, this));

	this.positionDialog.keyup($.proxy(function(e) {
		if(e.keyCode == $.ui.keyCode.ENTER) {
			this.saveDialog();
		}
	}, this));
};
/**
 * Adds the spread-specific event handlers
 */
Editor.prototype.addSpreadEvents = function() {
	this.buttons.addPosition.unbind('click');
	this.buttons.addPosition.click($.proxy(function(e) {
		e.preventDefault();
		this.spread.addPosition();
	}, this));

	this.buttons.removeCards.unbind('click');
	this.buttons.removeCards.click($.proxy(function(e) {
		e.preventDefault();
		this.removeCards();
	}, this));

	this.buttons.randomCard.unbind('click');
	this.buttons.randomCard.click($.proxy(function(e) {
		e.preventDefault();
		this.spread.addPosition().addRandomCard();
	}, this));

	this.buttons.positionSize.change($.proxy(function(e) {
		e.preventDefault();
		this.setPositionSize(this.buttons.positionSize.val());
	}, this));

	this.buttons.deck.change($.proxy(function() {
		this.loadDeck(this.buttons.deck.val());
	}, this));

	this.buttons.grid.change($.proxy(function() {
		this.setGrid(this.buttons.grid.val());
	}, this));
};
/**
 * Runs the specified function in a specified context, if confirmed by user
 */
Editor.prototype.confirm = function(message, callback, context) {
	this.confirmDialog.find('span.confirm-message').text(message);
	this.confirmDialog.dialog({
		autoOpen : false,
		modal : true,
		title : 'Подтверждение',
		show : 'fade',
		hide : 'fade',
		buttons : {
			'OK' : function() {
				callback.call(context);
				$(this).dialog("close");
			},
			"Отмена" : function() {
				$(this).dialog("close");
			}
		}
	});
	this.confirmDialog.dialog("open");
};
/**
 * Template for the confirmation dialog
 */
Editor.prototype.createConfirm = function() {
	this.confirmDialog = $('<div id="confirm-area"></div>').css({
		'display' : 'none'
	});
	this.confirmDialog.append($('<p><span class="ui-icon ui-icon-alert" style="float:left; margin:0 7px 20px 0;"></span><span class="confirm-message"></span></p>'));
	this.confirmDialog.appendTo(this.container);
};
/**
 * Dialog window with the position parameters
 */
Editor.prototype.createDialog = function() {
	var editorInstance = this;
	this.positionDialog = $('<div class="properties-area"></div>');
	this.positionDialog.append($('<label for="description">Значение позиции в раскладе</label>'));
	this.positionDialog.nameField = $('<input type="text" name="description" class="text description ui-widget-content ui-corner-all" />').appendTo(this.positionDialog);
	this.positionDialog.append($('<label for="card-id">Выпавшая карта</label>'));
	this.positionDialog.cardSelect = $('<select name="card-id" class="card-id"></select>').appendTo(this.positionDialog);
	this.positionDialog.upsideDown = $('<input type="checkbox" name="upside-down" class="upside-down" value="1" />').appendTo(this.positionDialog);
	this.positionDialog.append($('<label for="upside-down">перевёрнутая</label>'));
	this.positionDialog.append($('<label for="card-description">Значение выпавшей карты</label>'));
	this.positionDialog.valueField = $('<textarea name="card-description" class="text card-description ui-widget-content ui-corner-all"></textarea>').appendTo(this.positionDialog);
	this.positionDialog.appendTo(this.container);
	this.positionDialog.dialog({
		autoOpen : false,
		height : 410,
		width : 280,
		modal : false,
		show : 'fade',
		hide : 'fade',
		title : 'Параметры',
		buttons : {
			"Сохранить" : function() {
				editorInstance.saveDialog();
			},
			"Отмена" : function() {
				$(this).dialog("close");
			}
		},
		close : function() {
			var position = $(this).data('position');
			position.unselect();
		}
	});
};
/**
 * Toolbar with all its controls
 */
Editor.prototype.createToolbar = function() {
	this.toolbar = $('<div id="buttons"></div>');
	this.buttons = {};

	this.buttons.addPosition = $('<button id="add_position">Добавить карту</button>').button().appendTo(this.toolbar);
	this.buttons.removeCards = $('<button id="add_position">Убрать значения</button>').button().appendTo(this.toolbar);
	this.buttons.newSpread = $('<button id="new_spread">Удалить всё</button>').button().appendTo(this.toolbar);
	this.buttons.randomCard = $('<button id="random_card">Случайная карта</button>').button().appendTo(this.toolbar);
	this.toolbar.append($('<hr />'));

	this.toolbar.append($('<label for="position_size">Карты:</label>'));
	this.buttons.positionSize = $('<select id="position_size"></select>').appendTo(this.toolbar);
	$.each(this.settings.sizes, $.proxy(function(name, description) {
		$('<option value="' + name + '">' + description + '</option>').appendTo(this.buttons.positionSize);
	}, this));
	this.buttons.positionSize.val('medium');

	this.toolbar.append($('<label for="deck">Колода:</label>'));
	this.buttons.deck = $('<select id="deck"></select>').appendTo(this.toolbar);
	$.each(this.settings.decks, $.proxy(function(id, params) {
		$('<option value="' + id + '">' + params.name + '</option>').appendTo(this.buttons.deck);
	}, this));
	this.activeDeck = this.buttons.deck.val();
	this.toolbar.append($('<br />'));
	this.toolbar.append($('<label for="grid">Сетка:</label>'));
	this.buttons.grid = $('<select id="grid"></select>').appendTo(this.toolbar);
	$('<option value="">Нет</option>').appendTo(this.buttons.grid);
	$.each(this.settings.gridSizes, $.proxy(function(id, params) {
		$('<option value="' + id + '">' + params.name + ' (' + params.width + 'x' + params.height + ')' + '</option>').appendTo(this.buttons.grid);
	}, this));

	this.toolbar.appendTo(this.container);
};
/**
 * Creates the editor's GUI
 */
Editor.prototype.createWidgets = function() {
	this.createToolbar();
	//DOM element that contains the resizable editor field
	this.field = $('<div id="editor-area"></div>').appendTo(this.container);
	//DOM element that contains the list of positions with their descriptions
	var descriptionsContainer = $('<div id="descriptions-area"></div>');
	this.descriptionsList = $('<ol></ol>').appendTo(descriptionsContainer);
	descriptionsContainer.appendTo(this.container);

	this.exportContainer = $('<div id="export-area"><textarea id="export"></textarea></div>').appendTo(this.container);

	this.createDialog();
	this.createConfirm();
};
/**
 * Removes the old spread from the editor and adds a new one,
 * also assigning the buttons to work with the new spread
 */
Editor.prototype.createSpread = function(savedStructure) {
	if(this.spread) {
		this.exportContainer.css({
			'display' : 'none'
		});
		this.spread.remove();
	}

	this.spread = new Spread(this, savedStructure);

	this.addSpreadEvents();
};
/**
 * Getter for the activeDeck property
 */
Editor.prototype.getActiveDeck = function() {
	return this.activeDeck;
};
/**
 * Getter for the descriptions list
 */
Editor.prototype.getDescriptionsList = function() {
	return this.descriptionsList;
};
/**
 * Getter for the element property
 */
Editor.prototype.getElement = function() {
	return this.field;
};
/**
 * Getter for the defaultPositionSize property
 */
Editor.prototype.getPositionSize = function() {
	return this.defaultPositionSize;
};
/**
 * Getter for the propertiesElement property
 */
Editor.prototype.getPropertiesDialog = function() {
	return this.positionDialog;
};
/**
 * Exports the active spread into HTML code
 */
Editor.prototype.exportHTML = function() {
	var wrapper = $('<div></div>'), innerWrapper = $('<div></div>').appendTo(wrapper), spreadExport = this.spread.exportNode(), descriptionsExport = this.descriptionsList.clone(), copyrightExport = $('<div style="font-size: small; text-align: right;"><a href="http://ad-astra.name/SpreadEditor/" target="_blank">Редактор раскладов от Ad_Astra</div></a>');

	spreadExport.appendTo(innerWrapper);
	descriptionsExport.find('span').removeClass();
	descriptionsExport.appendTo(innerWrapper);
	copyrightExport.appendTo(innerWrapper);

	return this.postProcessOutput(wrapper.html());
};
/**
 * Exports the active spread into JSON
 */
Editor.prototype.exportJSON = function() {
	return JSON.stringify(this.spread.exportObject());
};
/**
 * Makes the deck active, if loaded. Otherwise downloads the deck description file via AJAX and caches it in the settings object
 */
Editor.prototype.loadDeck = function(deckName) {
	var url = this.settings.decksPath + deckName + "/" + this.settings.deckDescriptionFile;
	if(this.settings.decks[deckName].cards === undefined) {
		$.getJSON(url, $.proxy(function(data) {
			this.settings.decks[deckName].cards = data;
			this.activeDeck = deckName;
			this.reloadDeck();
			if(!this.spread) {
				this.createSpread(this.savedStructure);
			}
		}, this)).error(function(jqXHR, textStatus, errorThrown) {
			console.log(textStatus);
		})
	} else {
		this.activeDeck = deckName;
		this.reloadDeck();
	}
};
/**
 * Even more problems with non-crossbrowser CSS3 styling - have to add the unsupported ones directly to the text (again)
 */
Editor.prototype.postProcessOutput = function(text) {
	var expr = /(-webkit-transform: rotate\(-180deg\);)|(-moz-transform: rotate\(-180deg\);)|(-o-transform: rotate\(-180deg\);)|(transform: rotate\(-180deg\);)|(filter: progid:DXImageTransform.Microsoft.BasicImage\(rotation=2\))/, replacement = "-moz-transform: rotate(-180deg); -webkit-transform: rotate(-180deg); (-o-transform: rotate(-180deg);) transform: rotate(-180deg); filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=2)";
	return text.replace(expr, replacement);
};
/**
 * Reloads the cards' dropdown and all the card images, according to the selected deck
 */
Editor.prototype.reloadDeck = function() {
	var currentValue = this.positionDialog.cardSelect.val();
	this.positionDialog.cardSelect.html('<option value="">Выберите карту</option>');
	$.each(this.settings.decks[this.activeDeck].cards, $.proxy(function(id, name) {
		$('<option value="' + id + '">' + name + '</option>').appendTo(this.positionDialog.cardSelect);
	}, this));
	if(this.spread && this.spread.hasPositions()) {
		this.spread.setPositionsDeck(this.activeDeck);
	}
	this.positionDialog.cardSelect.val(currentValue);
};
/**
 * Populates the dialog box with values provided in the data property
 */
Editor.prototype.reloadDialog = function() {
	var position = this.positionDialog.data('position');
	this.positionDialog.nameField.val(position.getDescription());
	if(position.getCard() !== false) {
		this.positionDialog.cardSelect.val(position.getCard().getId());
		if(position.getCard().isUpsideDown() === true) {
			this.positionDialog.upsideDown.attr('checked', 'checked');
		} else {
			this.positionDialog.upsideDown.removeAttr('checked');
		}
		this.positionDialog.valueField.val(position.getCard().getValue());
	} else {
		this.positionDialog.cardSelect.val('');
		this.positionDialog.upsideDown.removeAttr('checked');
		this.positionDialog.valueField.val('');
	}
};
/**
 * Starts the removal of all the card images upon confirmation
 */
Editor.prototype.removeCards = function() {
	if(this.spread.hasPositions()) {
		this.confirm('Вы действительно хотите убрать все карты с позиций?', function() {
			this.spread.removeCards();
		}, this);
	}
};

Editor.prototype.saveDialog = function() {
	var position = this.positionDialog.data('position');
	position.updateParams({
		'description' : this.positionDialog.nameField.val(),
		'cardId' : this.positionDialog.cardSelect.val(),
		'upsideDown' : ($.proxy(function() {
			if(this.positionDialog.upsideDown.is(':checked') === true) {
			return true;
			} else {
			return false;
			}
			}, this)()),
		'cardDescription' : this.positionDialog.valueField.val()
	});
	this.positionDialog.dialog("close");
};
/**
 * Sets the new grid, for the editor field to be displayed and for the spread to set new rules for position movement.
 */
Editor.prototype.setGrid = function(newGrid) {
	this.defaultGrid = newGrid;
	$.each(this.settings.gridSizes, $.proxy(function(grid) {
		this.field.removeClass('grid-' + grid);
	}, this));
	this.field.addClass('grid-' + this.defaultGrid);
	this.spread.setGrid(this.defaultGrid);
};
/**
 * Passes the new default position size further to the spread and its positions
 */
Editor.prototype.setPositionSize = function(newSize) {
	this.defaultPositionSize = newSize;
	this.spread.setPositionSize(this.defaultPositionSize);
};
/**
 * Passes the selected position's parameters to the dialog window and opens it
 */
Editor.prototype.setupDialog = function(data) {
	this.positionDialog.data(data).trigger('dialogreload').dialog("open");
};

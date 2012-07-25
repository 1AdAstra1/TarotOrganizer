/*
 * One particular position in the spread
 */"use strict";

/**
 * Position object prototype constructor
 */
var Position = function(spread, savedPosition) {
	//set the default values
	this.card = null;
	this.spread = spread;
	this.editor = this.spread.getEditor();
	this.number = this.spread.getLastNumber();
	this.description = '';
	this.box = $('');

	this.descriptionElement = $('');
	//create the DOM nodes
	this.createElements();

	if(this.editor.hasForm() === true) {
		this.form = this.spread.getEditor().getForm();
		this.formElements = {};
		this.setForm();
	}

	//add events
	this.addDrag();
	this.addDblClick();
	this.addClick();
	this.addRightClick();

	//set the proper size for the element
	this.sizes = EditorSettings.sizes;
	this.setSize(this.spread.getPositionSize());

	this.gridSizes = EditorSettings.gridSizes;
	this.setGrid(this.spread.getGrid());
	if(savedPosition) {
		this.setDescription(savedPosition.description);
		this.box.css({
			top: savedPosition.top,
			left: savedPosition.left
		});
	}
};
/**
 * Adds a handler for the click event
 */
Position.prototype.addClick = function() {
	this.box.click($.proxy(function() {
		this.box.addClass("selected").siblings().removeClass("selected");
		this.editor.setupDialog({
			'position' : this
		});
	}, this));
};
/**
 * Adds a handler for the double click event
 */
Position.prototype.addDblClick = function() {
	this.box.dblclick($.proxy(function() {
		this.rotate();
	}, this));
};
/**
 * Adds a handler for the drag-n-drop event
 */
Position.prototype.addDrag = function() {
	this.box.draggable({
		containment : this.spread.getElement(),
		drag : $.proxy(function(event, ui) {
			this.updatePositionForm();
		}, this),
		scroll : false
	});
};
/**
 * Adds a handler for the right click event, removes the default context menu
 */
Position.prototype.addRightClick = function() {
	this.box.bind("contextmenu", $.proxy(function(event) {
		this.box.fadeOut('fast', 'swing', $.proxy(function() {
			this.spread.removePosition(this.number);
		}, this));
		return false;
	}, this));
};
/**
 * Creates the DOM elements: the visual representation and the description field
 */
Position.prototype.createElements = function() {
	this.box = $('<div></div>').addClass('position').addClass('vertical');
	this.numberElement = $('<div></div>').addClass('number').text(this.number + 1).appendTo(this.box);
	this.cardElement = $('<div></div>').addClass('value').appendTo(this.box);
	this.box.appendTo(this.spread.getElement()).fadeIn('fast', 'swing');

	this.listItem = $('<li></li>');
	this.descriptionElement = $('<span></span>').addClass('description').appendTo(this.listItem);
	this.valueElement = $('<span></span>').addClass('value').appendTo(this.listItem);
	this.listItem.appendTo(this.editor.getDescriptionsList());
};
/**
 * Exports the position to a new DOM node
 */
Position.prototype.exportNode = function() {
	var outElement = $('<div></div>').css({
		width : this.box.css('width'),
		height : this.box.css('height'),
		position : this.box.css('position'),
		top : this.box.css('top'),
		left : this.box.css('left'),
		'font-size' : this.box.css('font-size'),
		'text-align' : this.box.css('text-align'),
		'background-color' : this.box.css('background-color'),
		'border-top-width' : this.box.css('border-top-width'),
		'border-right-width' : this.box.css('border-right-width'),
		'border-bottom-width' : this.box.css('border-bottom-width'),
		'border-left-width' : this.box.css('border-left-width'),
		'border-top-color' : this.box.css('border-top-color'),
		'border-right-color' : this.box.css('border-right-color'),
		'border-bottom-color' : this.box.css('border-bottom-color'),
		'border-left-color' : this.box.css('border-left-color'),
		'border-top-style' : this.box.css('border-top-style'),
		'border-right-style' : this.box.css('border-right-style'),
		'border-bottom-style' : this.box.css('border-bottom-style'),
		'border-left-style' : this.box.css('border-left-style')
	});
	outElement.append($('<div></div>').text(this.number + 1).css({
		'float' : this.numberElement.css('float'),
		'text-align' : this.numberElement.css('text-align'),
		'position' : this.numberElement.css('position'),
		'top' : this.numberElement.css('top'),
		'margin-top' : this.numberElement.css('margin-top'),
		'margin-left' : this.numberElement.css('margin-left'),
		'margin-right' : this.numberElement.css('margin-right')
	}));
	if(this.card) {
		outElement.append($('<div></div>').append(this.card.exportNode()).css({
			'margin-top' : this.cardElement.css('margin-top'),
			'margin-bottom' : this.cardElement.css('margin-bottom')
		}));
	}

	return outElement;
};
/**
 * Exports the position to a new JSON object
 */
Position.prototype.exportObject = function() {
	var me = this,
	output = {
		width : this.box.css('width'),
		height : this.box.css('height'),
		position : this.box.css('position'),
		top : this.box.css('top'),
		left : this.box.css('left'),
		fontSize : this.box.css('font-size'),
		textAlign : this.box.css('text-align'),
		backgroundColor : this.box.css('background-color'),
		border : this.box.css('border'),
		number : {
			value : this.number + 1,
			mode : (function() {
				if(me.box.hasClass('vertical')) return 'vertical';
				return 'horizontal';
			})(),			
			textAlign : this.numberElement.css('text-align'),
			position : this.numberElement.css('position'),
			top : this.numberElement.css('top'),
			marginTop : this.numberElement.css('margin-top'),
			marginLeft : this.numberElement.css('margin-left'),
			marginRight : this.numberElement.css('margin-right')
		},
		description: this.getDescription()
	};

	if(this.card) {
		output.card = this.card.exportObject();
		output.card.marginTop = this.cardElement.css('margin-top');
		output.card.marginBottom = this.cardElement.css('margin-bottom');
	}
	
	return output;
};
/**
 * Getter for the card property
 */
Position.prototype.getCard = function() {
	if(this.card) {
		return this.card;
	}
	return false;
};
/**
 * Getter for the description property
 */
Position.prototype.getDescription = function() {
	return this.description;
};
/**
 * Getter for the descriptionElement property
 */
Position.prototype.getDescriptionElement = function() {
	return this.descriptionElement;
};
/**
 * Getter for the element property
 */
Position.prototype.getElement = function() {
	return this.box;
};
/**
 * Removes the position's elements
 */
Position.prototype.remove = function() {
	if(this.card) {
		this.removeCard();
	}
	this.box.remove();
	this.listItem.remove();
	this.removeForm();
};
/**
 * Removes the card and everything that depends on it
 */
Position.prototype.removeCard = function() {
	if(this.card) {
		this.card.remove();
		this.formElements.cardPath.remove();
		this.formElements.cardHeight.remove();
		delete this.card;
	}
};
/**
 * Removes the position's form fields
 */
Position.prototype.removeForm = function() {
	$.each(this.formElements, function(index, element) {
		element.remove();
	});
};
/**
 * Rotates the element, 90 degrees
 */
Position.prototype.rotate = function() {
	if(this.box.hasClass('vertical')) {
		this.box.switchClass('vertical', 'horizontal', 500);
		this.formElements.textPosition.val('horizontal');
	} else {
		this.box.switchClass('horizontal', 'vertical', 500);
		this.formElements.textPosition.val('vertical');
	}
	setTimeout($.proxy(function() {
		this.setSizeForm();
	}, this), 500);
};
/**
 * Sets the position's image and value according to the deck chosen
 */
Position.prototype.setDeck = function(deck) {
	if(this.card) {
		this.card.setDeck(deck);
		this.formElements.cardPath.val(this.card.getImagePath());
	}
};
/**
 * Sets the new description for the position,
 * makes it appear in the descriptions section
 */
Position.prototype.setDescription = function(description) {
	this.description = description;
	this.descriptionElement.text(description);
};
/**
 * Sets the new index number for the position, makes it appear on the 'card'
 */
Position.prototype.setNumber = function(number) {
	this.number = parseInt(number, 10);
	this.numberElement.text(this.number + 1);
	this.removeForm();
	this.setForm();
};
/**
 * Sets up the form fields for the card, if needed
 */
Position.prototype.setCardForm = function() {
	this.formElements.cardPath = $('<input type = "hidden" name = "positions[' + this.number + '][card_path]" id = "position-' + this.number + '-card-path" value="' + this.card.getImagePath() + '"/>').appendTo(this.form);
	this.formElements.cardHeight = $('<input type = "hidden" name = "positions[' + this.number + '][card_height]" id = "position-' + this.number + '-card-height" value="' + this.card.getHeight() + '"/>').appendTo(this.form);
	this.formElements.cardReverted = $('<input type = "hidden" name = "positions[' + this.number + '][card_reverted]" id = "position-' + this.number + '-card-reverted" value="' + this.card.isUpsideDown() + '"/>').appendTo(this.form);
};
/**
 * Restricts position movement to grid provided
 */
Position.prototype.setGrid = function(gridName) {
	if(gridName !== '') {
		var currentGrid = this.gridSizes[gridName], currentTop = parseInt(this.box.css('top'), 10), currentLeft = parseInt(this.box.css('left'), 10);

		this.box.css({
			'top' : currentTop - (currentTop % currentGrid.height),
			'left' : currentLeft - (currentLeft % currentGrid.width)
		});

		this.updatePositionForm();
		this.box.draggable("option", "grid", [currentGrid.width, currentGrid.height]);
	} else {
		this.box.draggable("option", "grid", false);
	}
}
/**
 * Sets up the form fields for the position, if needed
 */
Position.prototype.setForm = function() {
	this.formElements.number = $('<input type = "hidden" name = "positions[' + this.number + '][number]" id = "position-' + this.number + '-number" value="' + this.number + '"/>');
	this.formElements.top = $('<input type = "hidden" name = "positions[' + this.number + '][top]" id = "position-' + this.number + '-top" value="' + parseInt(this.box.css('top'), 10) + '"/>');
	this.formElements.left = $('<input type = "hidden" name = "positions[' + this.number + '][left]" id = "position-' + this.number + '-left" value="' + parseInt(this.box.css('left'), 10) + '"/>');
	this.formElements.width = $('<input type = "hidden" name = "positions[' + this.number + '][width]" id = "position-' + this.number + '-width" value="' + this.box.width() + '"/>');
	this.formElements.height = $('<input type = "hidden" name = "positions[' + this.number + '][height]" id = "position-' + this.number + '-height" value="' + this.box.height() + '"/>');
	this.formElements.textPosition = $('<input type = "hidden" name = "positions[' + this.number + '][text_position]" id = "position-' + this.number + '-text-position" value="vertical"/>');

	$.each(this.formElements, $.proxy(function(index, element) {
		element.appendTo(this.form);
	}, this));
};
/**
 * Resizes the position box by assigning pre-defines size classes to it
 */
Position.prototype.setSize = function(sizeName) {
	if(this.sizes.hasOwnProperty(sizeName)) {
		var sizeClassName = "size-" + sizeName;
		$.each(this.sizes, $.proxy(function(name, description) {
			this.box.removeClass("size-" + name);
		}, this));
		this.box.addClass(sizeClassName);
	}
	this.setSizeForm();
};
/**
 * Assigns the width, height and card height values to the form inputs
 */
Position.prototype.setSizeForm = function() {
	if(this.formElements) {
		this.formElements.width.val(this.box.width());
		this.formElements.height.val(this.box.height());
		if(this.card) {
			this.formElements.cardHeight.val(this.card.getHeight());
		}
	}
};
/**
 * Removes the selection
 */
Position.prototype.unselect = function() {
	this.box.removeClass("selected");
};
/**
 * Updates the position according to the data received from the dialog form
 */
Position.prototype.updateParams = function(params) {
	if(params.hasOwnProperty('description')) {
		this.setDescription(params.description);
	}
	if(params.hasOwnProperty('cardId') && params.cardId !== '') {
		if(!this.card) {
			this.card = new Card(this.editor.getActiveDeck(), params.cardId, params.cardDescription, this.cardElement, this.valueElement);
			this.setCardForm();
		} else {
			this.card.setId(params.cardId);
			this.formElements.cardPath.val(this.card.getImagePath());
			this.card.setValue(params.cardDescription);
		}
		if(params.upsideDown === true) {
			this.card.setUpsideDown();
		} else {
			this.card.setStraight();
		}
		this.formElements.cardReverted.val(this.card.isUpsideDown());
	} else {
		this.removeCard();
	}
};
/**
 * Updates the form values upon dragging or snapping to grid
 */
Position.prototype.updatePositionForm = function() {
	if(this.formElements) {
		this.formElements.top.val(parseInt(this.box.css('top'), 10));
		this.formElements.left.val(parseInt(this.box.css('left'), 10));
	}
};

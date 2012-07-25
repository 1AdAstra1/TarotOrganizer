/*
 * One particular position in the spread
 */"use strict";

/**
 * Position object prototype constructor
 */
var Position = function(spread, savedPosition) {
	var me = this;
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
			top : savedPosition.top,
			left : savedPosition.left
		});
		if(savedPosition.card) {
			this.card = new Card(me.editor.getActiveDeck(), savedPosition.card.id, savedPosition.card.value, this.cardElement, this.valueElement);
			if(savedPosition.card.reverted === true) this.card.setUpsideDown();
		}
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
	var me = this, output = {
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
				if(me.box.hasClass('vertical'))
					return 'vertical';
				return 'horizontal';
			})(),
			textAlign : this.numberElement.css('text-align'),
			position : this.numberElement.css('position'),
			top : this.numberElement.css('top'),
			marginTop : this.numberElement.css('margin-top'),
			marginLeft : this.numberElement.css('margin-left'),
			marginRight : this.numberElement.css('margin-right')
		},
		description : this.getDescription()
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
};
/**
 * Removes the card and everything that depends on it
 */
Position.prototype.removeCard = function() {
	if(this.card) {
		this.card.remove();
		delete this.card;
	}
};
/**
 * Rotates the element, 90 degrees
 */
Position.prototype.rotate = function() {
	if(this.box.hasClass('vertical')) {
		this.box.switchClass('vertical', 'horizontal', 500);
	} else {
		this.box.switchClass('horizontal', 'vertical', 500);
	}
};
/**
 * Sets the position's image and value according to the deck chosen
 */
Position.prototype.setDeck = function(deck) {
	if(this.card) {
		this.card.setDeck(deck);
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

		this.box.draggable("option", "grid", [currentGrid.width, currentGrid.height]);
	} else {
		this.box.draggable("option", "grid", false);
	}
}
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
		} else {
			this.card.setId(params.cardId);
			this.card.setValue(params.cardDescription);
		}
		if(params.upsideDown === true) {
			this.card.setUpsideDown();
		} else {
			this.card.setStraight();
		}
	} else {
		this.removeCard();
	}
};

/*
 * The whole spread
 */
/**
 * Spread object prototype constructor
 */
var Spread = function(editor, structure) {
	var me = this;
	this.positions = [];
	this.editor = editor;
	this.element = this.editor.getElement();
	this.settings = this.editor.settings;
	this.defaultPositionSize = this.editor.defaultPositionSize;
	this.defaultGrid = this.editor.defaultGrid;
	if(structure) {
		$.each(structure.positions, function(index, position) {
			me.addPosition(position);
		});
	}
};
/**
 * Adds a new position
 */
Spread.prototype.addPosition = function(savedPosition) {
	var newPosition = new Position(this, savedPosition);
	this.positions[this.getLastNumber()] = newPosition;
	return newPosition;
};
/**
 * Removes the spread's positions before removing the spread itself
 */
Spread.prototype.remove = function() {
	$.each(this.positions, function(index, position) {
		position.remove();
	});
	this.positions = [];
};
/**
 * Clears all cards from the positions
 */
Spread.prototype.removeCards = function() {
	$.each(this.positions, function(index, position) {
		position.removeCard();
	});
};
/**
 * Getter for the editor property
 */
Spread.prototype.getEditor = function() {
	return this.editor;
};
/**
 * Getter for the element property
 */
Spread.prototype.getElement = function() {
	return this.element;
};
/**
 * Getter for the defaultGrid property
 */
Spread.prototype.getGrid = function() {
	return this.defaultGrid;
}
/**
 * Gets the number of positions in the spread so that the new one could be inserted
 */
Spread.prototype.getLastNumber = function() {
	return this.positions.length;
};
/**
 * Getter for the defaultPositionSize property
 */
Spread.prototype.getPositionSize = function() {
	return this.defaultPositionSize;
};
/**
 * Exports the spread into a new DOM node
 */
Spread.prototype.exportNode = function() {
	var outElement = $('<div></div>');
	outElement.css({
		width : this.element.css('width'),
		height : this.element.css('height'),
		border : this.element.css('border'),
		position : this.element.css('position'),
		'background-color' : this.element.css('background-color'),
		'border-top-width' : this.element.css('border-top-width'),
		'border-right-width' : this.element.css('border-right-width'),
		'border-bottom-width' : this.element.css('border-bottom-width'),
		'border-left-width' : this.element.css('border-left-width'),
		'border-top-color' : this.element.css('border-top-color'),
		'border-right-color' : this.element.css('border-right-color'),
		'border-bottom-color' : this.element.css('border-bottom-color'),
		'border-left-color' : this.element.css('border-left-color'),
		'border-top-style' : this.element.css('border-top-style'),
		'border-right-style' : this.element.css('border-right-style'),
		'border-bottom-style' : this.element.css('border-bottom-style'),
		'border-left-style' : this.element.css('border-left-style')
	});
	for(var counter in this.positions) {
		this.positions[counter].exportNode().appendTo(outElement);
	}
	return outElement;
};
/**
 * Exports the spread into a new JSON object
 */
Spread.prototype.exportObject = function() {
	var output = {
		width : this.element.css('width'),
		height : this.element.css('height'),
		border : this.element.css('border'),
		backgroundColor : this.element.css('background-color'),
		deck: this.editor.getActiveDeck(),
		size: this.editor.getPositionSize(),
		positions: []
	};
	for(var counter in this.positions) {
		output.positions.push(this.positions[counter].exportObject());
	}
	return output;
};
/**
 * Returns true if the spread has any positions, false if the spread is empty
 */
Spread.prototype.hasPositions = function() {
	if(this.positions.length > 0)
		return true;
	return false;
};
/**
 * Removes the selected position
 */
Spread.prototype.removePosition = function(number) {
	this.positions[number].remove();
	var lastPositionIndex = this.positions.length - 1;
	//shifting the positions array properly
	if(this.positions.length > 1) {
		for(var counter = number; counter < lastPositionIndex; counter++) {
			this.positions[counter] = this.positions[parseInt(counter, 10) + 1];
			this.positions[counter].setNumber(counter);
		}
	}
	this.positions.splice(lastPositionIndex, 1);
};
/**
 * Applies the chosen deck to all positions
 */
Spread.prototype.setPositionsDeck = function(deck) {
	$.each(this.positions, $.proxy(function(index, position) {
		position.setDeck(deck);
	}, this));
};
/**
 * Sets new size for all positions in the spread
 */
Spread.prototype.setPositionSize = function(sizeName) {
	this.defaultPositionSize = sizeName;
	$.each(this.positions, $.proxy(function(index, position) {
		position.setSize(sizeName);
	}, this));
};
/**
 * Passes the new grid to all positions in the spread
 */
Spread.prototype.setGrid = function(gridName) {
	this.defaultGrid = gridName;
	$.each(this.positions, $.proxy(function(index, position) {
		position.setGrid(gridName);
	}, this));
};

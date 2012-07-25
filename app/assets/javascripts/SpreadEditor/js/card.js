/* 
 * A concrete card that fills the position
 */
'use strict';

/**
 * Card object prototype constructor
 */
var Card = function(deck, id, value, imageContainer, valueContainer) {
    this.id = id;
    this.deck = deck;
    this.value = value;
    this.upsideDown = false;
        
    this.imageContainer = imageContainer;
    this.valueContainer = valueContainer;
    this.decks = EditorSettings.decks;
    this.decksPath = EditorSettings.decksPath;
    this.imageFormat = EditorSettings.imageFormat;
    
    this.setName();
    this.setCardImage();
};

/**
 * Displays the card info in the description section
 */
Card.prototype.displayDescription = function() {
    var upsideDownText = '';
    if(this.isUpsideDown() === true) {
		upsideDownText = ' (перевёрнутая)';
    }
    this.valueContainer.html(' - <strong>' + this.cardName + upsideDownText + ':</strong> ' + this.value);
};

/**
 * Exports the card to a new DOM node
 */
Card.prototype.exportNode = function() {
    var outElement = this.cardImage.clone();
    outElement.removeClass();
    outElement.css({
	'width' : this.getWidth(),
	'height' : this.getHeight()
    });
    //as browsers can't understand all these properties at the same time, I have to set them manually
    if(this.isUpsideDown() === true) {
	outElement.css({
	    '-webkit-transform' : 'rotate(-180deg)',
	    '-moz-transform' : 'rotate(-180deg)',
	    '-o-transform': 'rotate(-180deg)',
	    'transform' : 'rotate(-180deg)',
	    'filter' : 'progid:DXImageTransform.Microsoft.BasicImage(rotation=2)'
	});
    }
    return outElement;
};

/**
 * Exports the card to a new JSON object
 */
Card.prototype.exportObject = function() {
	var output = {
		image: this.getImagePath(),
		width: this.getWidth(),
		height: this.getHeight(),
		reverted: this.isUpsideDown(), 
		id: this.getId(),
		name: this.getName(),
		value: this.getValue()
	};
	return output;
};

/**
 * Getter for the current computed height of the card image
 */
Card.prototype.getHeight = function() {
    return this.cardImage.height();
};

/**
 * Getter for the id property
 */
Card.prototype.getId = function() {
    return this.id;
};

/**
 * Getter for the cardImage property
 */
Card.prototype.getImage = function() {
    return this.cardImage;
};

/**
 * Getter for the current computed path of the card image
 */
Card.prototype.getImagePath = function() {
    return this.decksPath + this.deck + '/' + this.id + '.' + this.imageFormat;
};

/**
 * Getter for the cardName property
 */
Card.prototype.getName = function() {
    return this.cardName;
};

/**
 * Getter for the value property
 */
Card.prototype.getValue = function() {
    return this.value;
};

/**
 * Getter for the current computed width of the card image
 */
Card.prototype.getWidth = function() {
    return this.cardImage.width();
};

/**
 * Returns true if the card is upside-down, false otherwise
 */
Card.prototype.isUpsideDown = function() {
    return this.upsideDown;
};

/**
 * Removes all card-specific content from the DOM
 */
Card.prototype.remove = function() {
    this.cardImage.remove();
    this.valueContainer.html('');
};

/**
 * Sets the printable name for the card and sends the card info to the description section
 */
Card.prototype.setName = function() {
    this.cardName = this.decks[this.deck].cards[this.id];
    this.displayDescription();
};

/**
 * Inserts the image node into the image container
 */
Card.prototype.setCardImage = function() {
    this.cardImage = $('<img />').attr({
	'src' : EditorSettings.siteURL + this.getImagePath()
    });
    if(this.isUpsideDown() === true) {
	this.cardImage.addClass('reverted');
    } else {
	this.cardImage.removeClass('reverted');
    }
    this.imageContainer.html('');
    this.imageContainer.append(this.cardImage);
};

/**
 * Sets the new card ID and updates all params depending on it
 */
Card.prototype.setId = function(id) {
    this.id = id;
    this.setName();
    this.setCardImage();
};

/**
 * Sets the new deck and updates all params depending on it
 */
Card.prototype.setDeck = function(deck) {
    this.deck = deck;
    this.setName();
    this.setCardImage();
};

/**
 * Removes the upside-down flag and reloads the card image and description
 */
Card.prototype.setStraight = function() {
    this.upsideDown = false;
    this.setCardImage();
    this.displayDescription();
};

/**
 * Adds the upside-down flag and reloads the card image and description
 */
Card.prototype.setUpsideDown = function() {
    this.upsideDown = true;
    this.setCardImage();
    this.displayDescription();
};

/**
 * Sets the new value and updates the description
 */
Card.prototype.setValue = function(value) {
    this.value = value;
    this.displayDescription();
};

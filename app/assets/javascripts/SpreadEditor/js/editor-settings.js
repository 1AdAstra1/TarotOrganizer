/* 
 * Spread configuration
 */
'use strict';

var EditorSettings = {
    siteURL : 'http://ad-astra.name/SpreadEditor/',

    imageGeneratorPath : 'image-gen/',
   
    imageFormat : 'jpg',
    
    sizes : {
	'small' : 'Маленькие',
	'medium' : 'Средние',
	'large' : 'Большие'
    },
    
    gridSizes : {
	'small' : {
	    'name': 'Мелкая',
	    'width': 10,
	    'height' : 10
	},
	'medium' : {
	    'name': 'Средняя',
	    'width': 25,
	    'height' : 25
	},
	'large' : {
	    'name': 'Крупная',
	    'width': 50,
	    'height' : 50
	}
    },
    
    deckDescriptionFile: 'deck.json',
    
    decks : {
		'rider-waite' : {
		    'name' : 'Таро Райдера-Уэйта'
		},
	
		'thoth' : {
		    'name' : 'Таро Тота (А. Кроули)'
		},
		
		'marseille' : {
		    'name' : 'Марсельское Таро'
		},
		
		'doors-78' : {
		    'name' : 'Таро 78 дверей'
		}
    },    
    
    decksPath: 'assets/'
};


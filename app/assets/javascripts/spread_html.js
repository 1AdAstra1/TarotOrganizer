var getExportDOM = function(imageUrl) {
	this.wrapper = $('<div></div>');
    this.innerWrapper = $('<div></div>').appendTo(this.wrapper);
    this.spreadImage = $('<img />').attr({
		'src' : imageUrl
    }).appendTo(this.innerWrapper);
    this.descriptionsExport = $('#descriptions').clone().removeAttr('id').removeAttr('class').appendTo(this.wrapper);
    this.descriptionsExport.find('span').removeAttr('class');
	this.copyright = $('<div style="text-align:right">Расклад сделан в <a href="http://tarot-organizer.heroku.com">Блокноте Таролога</a></div>').appendTo(this.wrapper);
    this.getHTML = function() {
    	return this.wrapper.html().replace(/(\r\n|\n|\r)/gm, "").replace(/([ \t])[ \t]+/gm, "$1");
    };
    return this;
};

var getSpreadHTML = function(imageUrl) {
	this.dom = new getExportDOM(imageUrl);
    return this.dom.getHTML();
};

var getBBCode = function(imageUrl) {
	this.dom = new getExportDOM(imageUrl);
	this.dom.copyright.remove();
	var source_html = this.dom.getHTML().replace(/<(\/)?div>/gm, "").replace(/<(\/)?span>/gm, ""),
	bbcode = source_html.replace(/<img src="([^"]+)"\s*[^>]*>/, "[img]$1[/img]")
						.replace(/<ol>/, "[list=1]").replace(/<\/ol>/, "[/list]")
						.replace(/<(\/)?strong>/gm, "[$1b]")
						.replace(/<li>([^<]+)<\/li>/gm, "[*]$1[/*]");
	bbcode += "[right]Расклад сделан в [url=http://tarot-organizer.heroku.com]Блокноте Таролога[/url]﻿[/right]"
						
	return bbcode;	
}

var loadExport = function(mode, imageUrl) {
	var content,
	exportBox = $('#export'),
	exportArea = $('<textarea></textarea>');
	switch(mode) {
		case 'html':
			content = getSpreadHTML(imageUrl);
		break;
		case 'bbcode':
			content = getBBCode(imageUrl);
		break;
	}
	exportBox.html('');
	exportArea.text(content).appendTo(exportBox);
};

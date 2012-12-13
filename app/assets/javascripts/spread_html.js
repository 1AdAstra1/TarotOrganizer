var getSpreadHTML = function(imageUrl) {
	var wrapper = $('<div></div>'),
    innerWrapper = $('<div></div>').appendTo(wrapper),
    spreadImage = $('<img />').attr({
		'src' : imageUrl
    }),
    descriptionsExport = $('#descriptions').clone().removeAttr('id').removeAttr('class');
    innerWrapper.append(spreadImage);
    descriptionsExport.find('span').removeAttr('class');
    descriptionsExport.appendTo(wrapper);

    return wrapper.html().replace(/(\r\n|\n|\r)/gm, "").replace(/([ \t])[ \t]+/gm, "$1");
};

var getBBCode = function(imageUrl) {
	var source_html = getSpreadHTML(imageUrl).replace(/<(\/)?div>/gm, "").replace(/<(\/)?span>/gm, ""),
	bbcode = source_html.replace(/<img src="([^"]+)"\s*(\/)?>/, "[img]$1[/img]")
						.replace(/<ol>/, "[list=1]").replace(/<\/ol>/, "[/list]")
						.replace(/<(\/)?strong>/gm, "[$1b]")
						.replace(/<li>([^<]+)<\/li>/gm, "[*]$1[/*]");
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

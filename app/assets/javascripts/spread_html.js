var getSpreadHTML = function(imageUrl) {
	var wrapper = $('<div></div>'),
    innerWrapper = $('<div></div>').appendTo(wrapper),
    spreadImage = $('<img />').attr({
		'src' : imageUrl
    }),
    descriptionsExport = $('#descriptions').clone();
    innerWrapper.append(spreadImage);
    descriptionsExport.find('span').removeClass();
    descriptionsExport.appendTo(wrapper);

    return wrapper.html().replace(/(\r\n|\n|\r)/gm, "");
};

var loadExport = function(mode, imageUrl) {
	var content,
	exportBox = $('#export'),
	exportArea = $('<textarea></textarea>');
	switch(mode) {
		case 'html':
			content = getSpreadHTML(imageUrl);
		break;
		case 'bbcode':
			content = '';
		break;
	}
	exportBox.html('');
	exportArea.text(content).appendTo(exportBox);
			
};

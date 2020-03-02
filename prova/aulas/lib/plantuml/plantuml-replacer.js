$(document).ready(function () {
  $('.uml').each(function () {
    var text = $(this).text(),
      url = 'http://www.plantuml.com/plantuml/img/' + plantumlEncoder.encode(text);
    $(this).replaceWith('<img src="' + url + '"></img>');
  });
});
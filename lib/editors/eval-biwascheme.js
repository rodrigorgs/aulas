biwascheme = new BiwaScheme.Interpreter(on_error);

$(document).ready(() => {
  $('body').append('<div id="bs-console"></div>');
});

///////////////////////

var on_error = function(e){
  console.log('%c(Scheme) ' + e.message, 'color: red;')
};

function bs_eval(str) {
  var ret = biwascheme.evaluate(str);
  return BiwaScheme.to_write(ret);
}


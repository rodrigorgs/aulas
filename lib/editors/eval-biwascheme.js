$(document).ready(() => {
  $('body').append('<div id="bs-console"></div>');
  biwascheme = new BiwaScheme.Interpreter(on_error);
});

///////////////////////

var on_error = function(e) {
  console.log('%c(Scheme) ' + e.message, 'color: red;');
};

SchemeEval = {
  eval: (code) => {
    $('#bs-console').html('');

    var res = biwascheme.evaluate(code);
    var ret = BiwaScheme.to_write(res);

    console.log('%c' + $('#bs-console').text(), 'color: blue;');
    console.log('%c=> ' + ret, 'color: black;');
    $('#bs-console').html('');
  }
};
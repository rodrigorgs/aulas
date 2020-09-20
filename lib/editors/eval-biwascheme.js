Tester = {
  test: function (expected, actual) {
    if (JSON.stringify(expected) === JSON.stringify(actual)) {
      if (window.testesCertos) {
        testesCertos += 1;
      }
      console.log("OK!");
    } else {
      if (window.testesErrados) {
        testesErrados += 1;
      }
      console.log("ERRO! Esperado: " + JSON.stringify(expected) + "; obtido: " + JSON.stringify(actual));
    }
  },

  schemeWrapper: '(define (teste expected actual) (js-invoke (js-eval "Tester") "test" expected actual)) '
};

$(document).ready(() => {
  $('body').append('<div id="bs-console"></div>');
  biwascheme = new BiwaScheme.Interpreter(on_error);
});

///////////////////////

var on_error = function(e) {
  console.log('%c(Scheme) ' + e.message, 'color: red;');
};

SchemeEval = {
  eval: (code, input, outputFunc, callback) => {
    $('#bs-console').html('');

    var res = biwascheme.evaluate(Tester.schemeWrapper + code);
    var ret = BiwaScheme.to_write(res);

    if ($('#bs-console').text().length > 0) {
      outputFunc($('#bs-console').text() + "\n");
    }
    outputFunc("=> " + ret + "\n");
    // console.log('%c' + $('#bs-console').text(), 'color: blue;');
    // console.log('%c=> ' + ret, 'color: black;');
    $('#bs-console').html('');

    if (callback != undefined) {
      callback();
    }
  }
};
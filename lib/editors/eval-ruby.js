var repl = new ReplitClient('api.repl.it', 80, 'ruby', {"msg_mac":"fhguliPQj3WDEbpunRc6/UMi5uZ163GZlSh8MA03hRA=","time_created":1480260077000});

RubyEval = {
  eval: (code, codeMirror) => {
    var button = codeMirror.button;

    if ($(button).prop('disabled')) {
      return;
    }

    var oldText = $(button).text();
    $(button).text('Aguarde...');
    $(button).prop('disabled', true);

    repl.evaluateOnce(
       code, {
       stdout: function(output) {
         console.log('%c' + output, 'color: blue;');
       }
     }).then(
       function success(result) {
         // The evaluation succeeded. Result will contain `data` or `error`
         // depending on whether the code compiled and ran or if there was an
         // error.
         if (result.error) {
           console.log('%c(Ruby) ' + result.error, 'color: red;');
         } else {
           console.log('=> ', result.data);
         }

         $(button).text(oldText);
         $(button).prop('disabled', false);
       },
       function error(error) {
         // There was an error connecting to the service :(
         console.error('Error connecting to repl.it');

         $(button).text(oldText);
         $(button).prop('disabled', false);
       }
     );
  }
};


CppEval = {
  eval: (code, codeMirror, input, outputFunc) => {
    var config = {
      stdio: {
        write: function(s) {
          outputFunc(s);
        }
      }
    };

    try {
      JSCPP.run(code, input, config);
    } catch (error) {
      outputFunc("!!!!!\n");
      outputFunc(error);
    }
  }
};
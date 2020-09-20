CppEval = {
  eval: (code, input, outputFunc, callback) => {
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

    if (callback != undefined) {
      callback();
    }
  }
};
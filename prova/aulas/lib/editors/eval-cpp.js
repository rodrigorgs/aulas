CppEval = {
  eval: (code, input) => {
    var config = {
      stdio: {
        write: function(s) {
          console.log(s);
        }
      }
    };
    JSCPP.run(code, input, config);
  }
};
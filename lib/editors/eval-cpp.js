CppEval = {
  eval: (code, codeMirror, input, outputFunc) => {
    var config = {
      stdio: {
        write: function(s) {
          outputFunc(s);
          // if ($("#consolelog").length > 0) {
          //   let encodedStr = s.replace(/[\u00A0-\u9999<>\&]/gim, i => '&#'+i.charCodeAt(0)+';').replace("\n", "<br>");
          //   $("#consolelog").html($("#consolelog").html() + encodedStr);
          // } else {
          //   console.log(s);
          // }
        }
      }
    };
    // console.log('code: ', code);
    // console.log('input: ', input);
    // console.log('config: ', config);
    JSCPP.run(code, input, config);
  }
};
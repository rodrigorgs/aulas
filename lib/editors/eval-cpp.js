CppEval = {
  eval: (code, input) => {
    var config = {
      stdio: {
        write: function(s) {
          if ($("#consolelog").length > 0) {
            let encodedStr = s.replace(/[\u00A0-\u9999<>\&]/gim, i => '&#'+i.charCodeAt(0)+';').replace("\n", "<br>");
            $("#consolelog").html($("#consolelog").html() + encodedStr);
          } else {
            console.log(s);
          }
        }
      }
    };
    JSCPP.run(code, input, config);
  }
};
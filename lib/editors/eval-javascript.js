JavaScriptEval = {
  eval: (code, codeMirror, input, outputFunc) => {
    let oldLog = console.log;
    console.log = s => {
      outputFunc(s + "\n");
    }

    eval(code);
    
    console.log = oldLog;
  }
};
JavaScriptEval = {
  eval: (code, input, outputFunc, callback) => {
    let oldLog = console.log;
    console.log = s => {
      outputFunc(s + "\n");
    }

    eval(code);
    
    console.log = oldLog;
    if (callback != undefined) {
      callback();
    }
  }
};
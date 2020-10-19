JavaScriptEval = {
  eval: (code, input, outputFunc, callback) => {
    let oldLog = console.log;

    console.log = s => {
      outputFunc(s + "\n");
    }

    try {
      eval(code);
    } catch (e) {
      outputFunc(e.stack + "\n");
      console.error(e);
    }
    
    console.log = oldLog;

    if (callback != undefined) {
      callback();
    }
  }
};
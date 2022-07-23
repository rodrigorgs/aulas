async function pyodideMain() {
  let pyodide = await loadPyodide();
  return pyodide;
}
let pyodideReadyPromise = pyodideMain();

PythonEval = {
  eval: (code, input, outputFunc, callback) => {
    async function mainRunPyodide(){
      let pyodide = await pyodideReadyPromise;  
      pyodide.globals.clear();
      pyodide.runPython(`
          import sys
          import io
          sys.stdout = io.StringIO()`);
      try {
        pyodide.runPython(code);
        var stdout = pyodide.runPython("sys.stdout.getvalue()");
        outputFunc(stdout);
        if (callback != undefined) {
          callback();
        }
      } catch (error) {
        outputFunc(error);
      }
    }
    mainRunPyodide();
  }
};
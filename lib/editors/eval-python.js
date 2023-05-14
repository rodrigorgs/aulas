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
          sys.stdout = sys.stderr = io.StringIO()
          __name__ = '__main__'`);
          
      try {
        pyodide.setStdin();  // clear leftover input
        pyodide.setStdin({stdin: () => input});
        pyodide.runPython(code);
        var stdout = pyodide.runPython("sys.stdout.getvalue()");
        outputFunc(stdout);
      } catch (error) {
        outputFunc(error.message);
      }
      if (callback != undefined) {
        callback();
      }
    }
    mainRunPyodide();
  }
};
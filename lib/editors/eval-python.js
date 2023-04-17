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
      pyodide.runPython(`
class Image:
  def __new__(cls, *args, **kwargs):
    self = super().__new__(cls)
    self.x = 0
    self.y = 0
    self.file = self.__class__.__name__.lower() + '.png'
    self.angle = 0
    return self

def run(x):
  pass
`)
          
      try {
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
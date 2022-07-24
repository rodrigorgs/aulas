codeMirrorEditors = [];

$(document).ready(($) => {
  
$('textarea.code').each((idx, el) => {
  buildEditor(el);
});

function getLanguageFromClasses(classes) {
  var language = "javascript";

  var regex = /\blang-(.+?)\b/;
  var match = regex.exec(classes);
  if (match !== null && match.length >= 2) {
    language = match[1];
  }

  if (language == 'cpp') {
    language = 'text/x-c++src';
  } else if (language == 'python') {
    language = 'text/x-python';
  }

  return language;
}

function buildEditor(el) {
  var language = getLanguageFromClasses($(el).attr('class'));
  var nextElem = $(el).next();

  var codeMirror = CodeMirror.fromTextArea(el, {
      lineNumbers: true,
      mode: language,
      gutters: ["CodeMirror-lint-markers"],
      lint: true,
      options: { esversion: 6 },
      matchBrackets: true,
      autoRefresh: true,
      tabSize: 2,
      indentWithTabs: false,
      hint: true,
      extraKeys: {
        "Ctrl-Space": "autocomplete",
        // "Ctrl-Enter": () => {
        //   runCode(codeMirror.getValue(), codeMirror);
        // },
        // "Cmd-Enter": () => {
        //   runCode(codeMirror.getValue(), codeMirror);
        // }
      }
    });

  codeMirror.setSize("100%", "auto");

  codeMirror.originalText = codeMirror.getValue();
  if (nextElem.attr('class') == 'answer') {
    codeMirror.answer = nextElem.val();
  }

  codeMirrorEditors.push(codeMirror);
  buildButtons(codeMirror);
}

function buildButtons(codeMirror) {
  let editor = codeMirror.getWrapperElement();

  if (codeMirror.answer) {
    let buttonAnswer = $('<button style="margin-left: 200px;">Resposta</button>');
    buttonAnswer.insertAfter(editor);
    codeMirror.buttonAnswer = buttonAnswer;
    buttonAnswer.on('click', () => {
      codeMirror.setValue(codeMirror.answer);
    });
  }

  let oldStdinTextarea = $(editor).next('.stdin');

  // Test cases
  let testCases = [];
  let testcasesElem = $(editor).nextUntil('h2').filter('.testcases');
  if (testcasesElem.length > 0) {
    let text = testcasesElem.text();
    let cases = text.split("=====").map(c => c.split("]]]"));
    cases = cases.filter(x => x instanceof Array && x.length == 2);
    testCases = cases.map(x => ({
      input: x[0].trim(),
      output: x[1].trim()}));
    // console.table(testCases);
  }
  
  let buttonRun = $('<button style="display: block" class="go">Rodar</button>');
  buttonRun.insertAfter(editor);
  codeMirror.buttonRun = buttonRun;

  let stdoutTextarea = undefined;
  let stdinTextarea = undefined;

  stdinTextarea = $('<textarea class="stdin" placeholder="Entrada"></textarea>');
  stdinTextarea.insertAfter(buttonRun);
  if (oldStdinTextarea.length > 0) {
    stdinTextarea.val(oldStdinTextarea.val());
    oldStdinTextarea.remove();
  }

  stdoutTextarea = $('<textarea disabled class="stdout" placeholder="Saída"></textarea>');
  stdoutTextarea.insertAfter(stdinTextarea);

  let testResultsElem = $('<div class="testresults">&nbsp;</div>');
  testResultsElem.insertAfter(stdoutTextarea);

  let doRun = () => {
    let log = [];
    
    stdoutTextarea.fadeToggle(250, 'swing', () => {
      stdoutTextarea.val('');
      runCode(codeMirror.getValue(), codeMirror, stdinTextarea.val(), s => {
        // let encodedStr = s.replace(/[\u00A0-\u9999<>\&]/gim, i => '&#'+i.charCodeAt(0)+';'); //.replace("\n", "<br>");
        stdoutTextarea.val(stdoutTextarea.val() + s);
      });
    });
    stdoutTextarea.fadeToggle(250, 'swing', () => {
    });

    if (testCases.length > 0) {
      let totalTestsRun = 0;
      let totalTestsPass = 0;
      testResultsElem.fadeToggle(0, 'swing');
      testCases.forEach(testCase => {
        let testOutput = '';
        runCode(codeMirror.getValue(), codeMirror, testCase.input,
            output => { testOutput += output; },
            () => {
              totalTestsRun++;
              if (testOutput.trim() == testCase.output.trim()) {
                totalTestsPass++;
              } else {
                if (log.length == 0) {
                  log.push("Seu programa não passou em pelo menos um teste:\n");
                  log.push(`***Entrada***:\n${testCase.input}`);
                  log.push(`***Saída do seu programa***:\n${testOutput.trim()}`);
                  log.push(`***Saída esperada***:\n${testCase.output.trim()}`);
                  // log.push(`-----------------`);
                }
              }
              if (totalTestsRun == testCases.length) {
                let erroCompilacao = testOutput.trim().match('!!!!!\n');
                testResultsElem.text('');
                if (erroCompilacao) {
                  testResultsElem.append('<b>Erro de compilação</b> (ver saída)');
                } else {
                  testResultsElem.append('Testes: ' + (100 * totalTestsPass / totalTestsRun).toFixed() + "%");
                }
                testResultsElem.fadeTo(1200, 1);
                if (totalTestsPass != totalTestsRun && !erroCompilacao) {
                  var showDetailsElem = $(`<a href="#">(Ver detalhes...)</a>`)
                  showDetailsElem.on('click', () => {
                    window.alert(log.join("\n"));
                    return false;
                  })
                  testResultsElem.append(' ');
                  testResultsElem.append(showDetailsElem);
                }
              }
        });
      });
    }
  };

  stdinTextarea.keydown(e => {
    if ((e.ctrlKey || e.metaKey) && e.keyCode === 13) {
        doRun();
    }
  });
  
  codeMirror.on('keydown', (cm, e) => {
    if ((e.ctrlKey || e.metaKey) && e.keyCode === 13) {
        doRun();
    }
  });
  buttonRun.on('click', e => doRun());
  
}

runCodeHooks = [];

function addRunCodeHook(f) {
  runCodeHooks.push(f);
}

function removeRunCodeHook(f) {
  var index = runCodeHooks.indexOf(f);
  if (index > - 1) {
    runCodeHooks.splice(index, 1);
  }
}

function runCode(code, codeMirror, input, outputFunc, callback) {
  for (var i = 0; i < runCodeHooks.length; i++) {
    runCodeHooks[i](code, codeMirror);
  }

  var language = codeMirror.options.mode;

  if (language === "javascript") {
    JavaScriptEval.eval(code, input, outputFunc, callback);
  } else if (language === "scheme") {
    SchemeEval.eval(code, input, outputFunc, callback);
  } else if (language === "ruby") {
    RubyEval.eval(code, input, outputFunc, callback);
  } else if (language === "python" || language === "text/x-python") {
    PythonEval.eval(code, input, outputFunc, callback);
  } else if (language === "cpp" || language === "text/x-c++src") {
    CppEval.eval(code, input, outputFunc, callback);
  }
}

// Experimental: replace markdown blockquotes with codemirror editors
$(document).ready(() => {
  $('.editor').each((idx, el) => {
    var code = $(el).text().trim();
    var klass = $(el).attr('class').replace('language', 'lang');
    var textarea = $('<textarea></textarea>');
    textarea.attr('class', klass);
    textarea.text(code);
    $(el).replaceWith(textarea);
    buildEditor(textarea[0]);      
  });
});

});
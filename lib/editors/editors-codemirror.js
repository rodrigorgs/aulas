var addRunCodeHook;
codeMirrorEditors = [];
codeMirrorReadyCallbacks = [];
runCodeHooks = [];

$(document).ready(($) => {

$('textarea.code').each((idx, el) => {
  buildEditor(el);
});
for (let i = 0; i < codeMirrorReadyCallbacks.length; i++) {
  codeMirrorReadyCallbacks[i]($);
}

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
  // remove trailing newline
  if ($(el).val().endsWith('\n')) {
    $(el).val($(el).val().slice(0, -1));
  }
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
        "Tab": function(cm) {
          if (cm.somethingSelected()) {
            cm.indentSelection("add");
          } else {
            var spaces = Array(cm.getOption("indentUnit") + 1).join(" ");
            cm.replaceSelection(spaces);
          }
        },
        "Shift-Tab": function(cm) {
          if (cm.somethingSelected()) {
            cm.indentSelection("subtract");
          } else {
          }
        },
        "Ctrl-K": () => {
          el.parentElement.getElementsByClassName('evaluate')[0].click();
        },
        "Cmd-K": () => {
          el.parentElement.getElementsByClassName('evaluate')[0].click();
        }
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
      // replace \n by a newline
      input: x[0].replace(/\\n/g, '\n').trim(),
      output: x[1].replace(/\\n/g, '\n').trim()}));
    // console.table(testCases);
  }

  // Test code
  let testCode = undefined;
  let testcodeElem = $(editor).nextUntil('h2').filter('.testcode');
  if (testcodeElem.length > 0) {
    testCode = testcodeElem.text();
  }
  
  let divButtons = $('<div class="button-div" style="display: flex;"></div>');
  divButtons.insertAfter(editor);

  let buttonRun = $('<button style="display: block; margin-right: 5px;" class="go" x-text="$store.submission.username ? \'Salvar e rodar\' : \'Rodar\'">Rodar</button>');
  divButtons.append(buttonRun);
  codeMirror.buttonRun = buttonRun;

  // TODO: se tiver teste
  let buttonTest = $('<button style="display: block" class="go evaluate" x-text="$store.submission.username ? \'Salvar e avaliar\' : \'Avaliar\'">Avaliar</button>');
  divButtons.append(buttonTest);

  let stdoutTextarea = undefined;
  let stdinTextarea = undefined;

  let language = codeMirror.options.mode.replace('text/x-', '');
  stdinTextarea = $(`<textarea class="stdin ${language}" placeholder="Entrada"></textarea>`);
  stdinTextarea.insertAfter(divButtons);
  if (oldStdinTextarea.length > 0) {
    stdinTextarea.val(oldStdinTextarea.val());
    oldStdinTextarea.remove();
  }

  stdoutTextarea = $(`<textarea disabled class="stdout ${language}" placeholder="Saída"></textarea>`);
  stdoutTextarea.insertAfter(stdinTextarea);

  let testResultsElem = $('<div class="testresults">&nbsp;</div>');
  testResultsElem.insertAfter(stdoutTextarea);

  let runTemplate = '[[[code]]]';
  let runTemplateElem = $(editor).nextUntil('h2').filter('.runtemplate');
  console.log('editor', editor);
  console.log('runTemplateElem', runTemplateElem, 'len = ', runTemplateElem.length);
  if (runTemplateElem.length > 0) {
    runTemplate = runTemplateElem.text().trim();
  }

  let doRun = () => {
    let log = [];
    
    stdoutTextarea.show().fadeToggle(250, 'swing', () => {
      stdoutTextarea.val('');

      const stdinVal = stdinTextarea.val().trim();
      let userTestCode = '\n';
      if (stdinVal.startsWith('# code')) {
        const linebreakIdx = stdinVal.indexOf('\n');
        if (linebreakIdx > 0) {
          userTestCode += stdinVal.slice(linebreakIdx);
        }
      }
      
      const codeToRun = runTemplate.replaceAll('[[[code]]]', codeMirror.getValue() + userTestCode);
      runCode(codeToRun, codeMirror, stdinTextarea.val(), s => {
        let encodedStr = s.replace(/[\u00A0-\u9999<>\&]/gim, i => '&#'+i.charCodeAt(0)+';'); //.replace("\n", "<br>");
        stdoutTextarea.val(stdoutTextarea.val() + s);
      });
    });
    stdoutTextarea.fadeToggle(250, 'swing', () => {
    });

    for (var i = 0; i < runCodeHooks.length; i++) {
      runCodeHooks[i](codeMirror.getValue(), codeMirror);
    }
  };

  let doTest = () => {
    let log = [];
    // test code
    if (testCode !== undefined) {
      let testOutput = '';
      let totalTestsPass = 0;
      let totalTestsRun = 0;
      testResultsElem.fadeToggle(0, 'swing');
      
      let originalTestCode = testCode;
      let studentCode = codeMirror.getValue();
      if (!testCode.includes('[[[code]]]')) {
        testCode = '[[[header]]]\n[[[code]]]\n[[[footer]]]' + testCode;
      }
      // console.log('testCode:', testCode);
      let fullCode = testCode
          .replaceAll('[[[header]]]', `__print = print; print = lambda *args, **kwargs: None; __input = input; input = lambda *args, **kwargs: "3";`)
          .replaceAll('[[[footer]]]', `\nprint = __print; input = __input\n`)
          .replaceAll('[[[code]]]',  studentCode);
      // console.log(fullCode);
      runCode(fullCode, codeMirror, stdinTextarea.val(),
          output => { testOutput += output; },
          () => {
            testOutput = testOutput.trim();
            log.push(testOutput);

            // compute tests run / passed
            if (testOutput == '') {
              totalTestsPass = 1;
              totalTestsRun = 1;
            } else {
              let line1 = testOutput.split('\n')[0];
              if (line1.match(/^[.EF]*$/)) {
                totalTestsPass = line1.split('.').length - 1;
                totalTestsRun = line1.length;
              } else {
                totalTestsPass = 0;
                totalTestsRun = 1;
              }
            }

            // show results
            testResultsElem.text('');
            testResultsElem.append('Testes: ' + (100 * totalTestsPass / totalTestsRun).toFixed() + "%");

            testResultsElem.fadeTo(1200, 1);
            if (totalTestsPass != totalTestsRun) {
              showToast("Seu programa NÃO passou em todos os testes!\nClique para mais informações...", "error",
                {onClick: () => { window.alert(log.join("\n")); }});
              var showDetailsElem = $(`<a href="#">(Ver detalhes...)</a>`)
              showDetailsElem.on('click', () => {
                jQuery("#codeDialogText").html(`<b>Saída:</b><pre>${log.join("\n")}</pre><b>Código de teste:</b><pre>${originalTestCode.replace('<', '&lt;').replace('>', '&gt;')}</pre>`);
                testResultsDialog = jQuery("#codeDialog").dialog({                  
                  autoOpen: true,
                  modal: true,
                  width: 800,
                  maxHeight: 600,
                  buttons: {
                      "Cancelar": function () { testResultsDialog.dialog("close"); }
                  }
                });
                return false;
              })
              testResultsElem.append(' ');
              testResultsElem.append(showDetailsElem);
            } else {
              showToast("Seu programa passou em todos os testes!", "success");
              throwConfetti();
            }
          });
    }

    // input/output test cases
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
                  showToast("Seu programa NÃO passou em todos os testes!\nClique para mais informações...", "error",
                      {onClick: () => { window.alert(log.join("\n")); }});
  
                  var showDetailsElem = $(`<a href="#">(Ver detalhes...)</a>`)
                  showDetailsElem.on('click', () => {
                    window.alert(log.join("\n"));
                    return false;
                  })
                  testResultsElem.append(' ');
                  testResultsElem.append(showDetailsElem);
                } else {
                  showToast("Seu programa passou em todos os testes!", "success");
                  throwConfetti();
                }
              }
        });
      });
    }

    for (var i = 0; i < runCodeHooks.length; i++) {
      runCodeHooks[i](codeMirror.getValue(), codeMirror);
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
  buttonTest.on('click', e => doTest());
  
}

addRunCodeHook = function (f) {
  runCodeHooks.push(f);
}

function removeRunCodeHook(f) {
  var index = runCodeHooks.indexOf(f);
  if (index > - 1) {
    runCodeHooks.splice(index, 1);
  }
}

function runCode(code, codeMirror, input, outputFunc, callback) {
  console.log('will run', code);
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
  } else if (language === "dart" || language === "flutter") {
    outputFunc("Não é possível executar programas\nescritos em Dart neste ambiente.\nUse seu computador ou o DartPad.");
    if (callback != undefined) {
      callback();
    }
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
codeMirrorEditors = [];

$(document).ready(() => {
  $('textarea.code').each((idx, el) => {
    buildEditor(el);
  });  
})

function getLanguageFromClasses(classes) {
  var language = "javascript";

  var regex = /\blang-(.+?)\b/;
  var match = regex.exec(classes);
  if (match !== null && match.length >= 2) {
    language = match[1];
  }

  if (language == 'cpp') {
    language = 'text/x-c++src';
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

  let buttonRun = $('<div><button class="go">Rodar</button></div>');
  buttonRun.insertAfter(editor);

  let stdinTextarea = $('<textarea rows="3" style="vertical-align: top; width: 49%;" class="stdin" placeholder="Entrada"></textarea>');
  stdinTextarea.insertAfter(buttonRun);
  if (oldStdinTextarea.length > 0) {
    stdinTextarea.val(oldStdinTextarea.val());
    oldStdinTextarea.remove();
  }

  let stdoutTextarea = $('<textarea rows="3" style="vertical-align: top; width: 49%;" disabled class="stdout" placeholder="Saída"></textarea>');
  stdoutTextarea.insertAfter(stdinTextarea);

  codeMirror.buttonRun = buttonRun;

  let doRun = () => {
    stdoutTextarea.val('');
    // console.log('stdinTextarea', stdinTextarea);
    runCode(codeMirror.getValue(), codeMirror, stdinTextarea.val(), s => {
      // let encodedStr = s.replace(/[\u00A0-\u9999<>\&]/gim, i => '&#'+i.charCodeAt(0)+';'); //.replace("\n", "<br>");
      stdoutTextarea.val(stdoutTextarea.val() + s);
    });
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

function runCode(code, codeMirror, input, outputFunc) {
  for (var i = 0; i < runCodeHooks.length; i++) {
    runCodeHooks[i](code, codeMirror);
  }

  var language = codeMirror.options.mode;

  if (language === "javascript") {
    JavaScriptEval.eval(code, codeMirror, input, outputFunc);
  } else if (language === "scheme") {
    SchemeEval.eval(code, codeMirror, input, outputFunc);
  } else if (language === "ruby") {
    RubyEval.eval(code, codeMirror, input, outputFunc);
  } else if (language === "cpp" || language === "text/x-c++src") {
    CppEval.eval(code, codeMirror, input, outputFunc);
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
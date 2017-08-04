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
        "Ctrl-Enter": () => {
          runCode(codeMirror.getValue(), codeMirror);
        },
        "Cmd-Enter": () => {
          runCode(codeMirror.getValue(), codeMirror);
        }
      }
    });

  codeMirror.setSize("100%", "auto");
  codeMirrorEditors.push(codeMirror);

  buildButtons(codeMirror);
}

function buildButtons(codeMirror) {
  var editor = codeMirror.getWrapperElement();
  var button = $('<button class="go">Rodar</button>');
  button.insertAfter(editor);
  codeMirror.button = button;
  button.on('click', () => {
    runCode(codeMirror.getValue(), codeMirror);
  });
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

function runCode(code, codeMirror) {
  var language = codeMirror.options.mode;

  if (language === "javascript") {
    JavaScriptEval.eval(code, codeMirror);
  } else if (language === "scheme") {
    SchemeEval.eval(code, codeMirror);
  } else if (language === "ruby") {
    RubyEval.eval(code, codeMirror);
  } else if (language === "cpp" || language === "text/x-c++src") {
    CppEval.eval(code, window.input || '');
  }

  for (var i = 0; i < runCodeHooks.length; i++) {
    runCodeHooks[i](code, codeMirror);
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
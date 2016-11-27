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


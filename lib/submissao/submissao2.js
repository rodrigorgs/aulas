// URL_PREFIX = 'http://localhost:8080/';
URL_PREFIX = 'https://suporteic.ufba.br/_submissao/';
if (window.location.href.includes("localhost")) {
  URL_PREFIX = 'http://localhost:8080/';
}
/////////////////
// Session
/////////////////
class SubmissionSession {
  static get SESSION_KEY() { return "submissao_token_key"; }

  getToken() {
    return sessionStorage.getItem(SubmissionSession.SESSION_KEY);
  }
  setToken(token) {
    if (token) {
      sessionStorage.setItem(SubmissionSession.SESSION_KEY, token);
    } else {
      sessionStorage.removeItem(SubmissionSession.SESSION_KEY);
    }
  }
  getLoggedInUsername() {
    const token = this.getToken();
    let username = "";
    if (token) {
      const parts = token.split(".");
      const payload = parts[1];
      username = JSON.parse(atob(payload))["sub"];
    }
    return username;
  }

  isAdmin() {
    const token = this.getToken();
    let resultIsAdmin = false;
    if (token) {
      const parts = token.split(".");
      const payload = parts[1];
      resultIsAdmin = JSON.parse(atob(payload))["admin"];
    }
    return resultIsAdmin;
  }
}
let submissionSession = new SubmissionSession();

// document.addEventListener("DOMContentLoaded", function(e) {
//   initSubmissao();
// })
jQuery(document).ready(function() {
  initSubmissao(jQuery);
});

function initSubmissao() {
  html = jQuery.parseHTML(`
<div id="loginbar">
  <span class="loginbar-logout">
    <span>User:</span>
    <span class="loginbar-username">?</span>
    <button onclick="logout();">Logout</button>
    <button onclick="enviaRespostasTotal();">Enviar respostas</button>
  </span>
  <span class="loginbar-login">
    <button onclick="showLogin();">Login</button>
  </span>
</div>
<div id="dialog" title="Login" style="display: none">
<form autocomplete="off">
  <input id="username" type="text" size="25" placeholder="Username" /><br/>
  <input id="password" type="password" size="25" placeholder="Password" /><br/>
  <input type="submit" tabindex="-1" style="position:absolute; top:-1000px" />
</form>
</div>
  `);
  jQuery('#submission-bar').html(html);
  updateUIUsername();

  // loginDialog
  loginDialog = jQuery("#dialog").dialog({
      autoOpen: false,
      modal: true,
      buttons: {
          "Enviar": submitLoginDialog,
          "Cancelar": function () { loginDialog.dialog("close"); }
      }
  });
  loginDialog.find("form").on("submit", function (evt) {
      evt.preventDefault();
      submitLoginDialog();
  });

  // envia 1 resposta
  if (typeof addRunCodeHook === 'function') {
    addRunCodeHook(function (code, codeMirror) {
      var editorIndex = codeMirrorEditors.indexOf(codeMirror);
      enviaRespostasCodeMirror(editorIndex, true);
    });
  }

  // TODO:
  // localStorage para salvar respostas localmente
  // setTimeout(carregaRespostasLocais, 1000);
  // carregaRespostasLocais();
  // addRunCodeHook(function (code, codeMirror) {
  //     salvaRespostasLocalmente();
  // });
}

function showLogin() {
  loginDialog.dialog('open')
}


function submitLoginDialog() {
console.log('submitLoginDialog');
var valid = false,
    data = {};

data.username = jQuery("#username").val();
data.password = jQuery("#password").val();

login(data);

jQuery("#username").val('');
jQuery("#password").val('');

loginDialog.dialog("close");

return valid;
}

/////////////////////////////

function login(data) {
  $.post(URL_PREFIX + "login.php",
      JSON.stringify(data))
    .done(function(data) {
      submissionSession.setToken(data);
      updateUIUsername();    
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
      submissionSession.setToken(null);
      updateUIUsername();
      alert("Usuário ou senha inválidos ou erro durante login.");
    });
}

function logout() {
  submissionSession.setToken(null);
  updateUIUsername();
}

function updateUIUsername() {
  const username = submissionSession.getLoggedInUsername();
  jQuery(".loginbar-username").text(username);
  if (username) {
    jQuery(".loginbar-login").hide();
    jQuery(".loginbar-logout").show();
  } else {
    jQuery(".loginbar-login").show();
    jQuery(".loginbar-logout").hide();
  }
}

function enviaRespostasTotal() {
  enviaRespostasCodeMirror();
  enviaRespostasSurvey();
}

function enviaRespostasCodeMirror(question_index = null, silent = false) {
  if (window.codeMirrorEditors !== undefined) {
    let all_answers = codeMirrorEditors.map(ed => ed.getValue());
    enviaRespostas(all_answers, question_index, silent);
  }
}

function enviaRespostasSurvey() {
  const surveyElem = document.querySelector('.survey');
  if (surveyElem) {
    const all_answers = Array.from(surveyElem.querySelectorAll('input[type="radio"]:checked')).map(e => e.value);
    if (surveyElem.querySelectorAll('fieldset').length == all_answers.length) {
      enviaRespostas(all_answers, null, false, "survey");
    } else {
      alert("Preencha todas as questões antes de enviar.");
    }
  }
}

function postSubmit(payload, endpoint="submit.php") {
  const assignment_url = window.location.href;
  payload["assignment_url"] = assignment_url;

  let beforeSend = null;
  if (submissionSession.getToken()) {
    beforeSend = function (xhr) {
      xhr.setRequestHeader("Authorization", "Bearer " + submissionSession.getToken());
    }
  }

  return $.post({
    url: URL_PREFIX + endpoint,
    data: JSON.stringify(payload),
    contentType: "application/json; charset=utf-8",
    beforeSend: beforeSend
    });
}

function enviaRespostas(all_answers, question_index = null, silent = false, question_type = "code") {
  let answer, submission_type;
  if (question_index !== null) {
    answer = all_answers[question_index];
    submission_type = "single";
  } else {
    answer = all_answers;
    submission_type = "batch";
  }
  const assignment_url = window.location.href;
  const submission = { answer, question_index, submission_type, question_type, assignment_url };

  postSubmit(submission)
  .done(function(data) {
    const ret = "Resposta enviada com sucesso.";
    if (silent) {
      console.log(ret);
    } else {
      alert(ret);
    }
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    console.log('Error', textStatus);
    submissionSession.setToken(null);
    updateUIUsername();
    const ret = "Erro ao enviar resposta. Por favor se autentique para tentar novamente.";
    if (silent) {
      console.log(ret);
    } else {
      alert(ret);
    }
  });
}

function obtemRespostasJson() {
  var answers = codeMirrorEditors.map(ed => ed.getValue());
  json = JSON.stringify({answer : answers});
  return json;
}

/////////////////
// LocalStorage
/////////////////

// TODO: review (it may not be compatible with recent changes in the API)
// function salvaRespostasLocalmente() {
//   var data = {
//       timestamp: new Date(),
//       answers: obtemRespostasJson(),
//       apostila: window.apostila
//   };

//   if (window.localStorage) {
//       localStorage.setItem('ufbaprog', JSON.stringify(data));
//   }
// }

// TODO: review (it may not be compatible with recent changes in the API)
// function carregaRespostasLocais() {
//   if (window.localStorage && localStorage['ufbaprog']) {
//       var dataJson = localStorage['ufbaprog'];
//       var data = JSON.parse(dataJson);
//       var timestamp = new Date(data.timestamp);
//       var secondsElapsed = (new Date() - timestamp) / 1000;

//       if (secondsElapsed <= 30 * 60) {
//           console.log('Carregando respostas...');
//           var answers = JSON.parse(data.answers).answers;
//           carregaRespostasDeArray(answers);
//           console.log("OK. Para apagar as respostas salvas localmente, digite: delete localStorage['ufbaprog'];");
//       }
//   }
// }

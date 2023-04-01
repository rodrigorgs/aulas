// URL_PREFIX = 'http://localhost:8080/';
URL_PREFIX = 'https://ezsubmission.app.ic.ufba.br/';
if (window.location.href.includes("localhost")) {
  URL_PREFIX = 'http://localhost:5001/';
}
let ez = new EZSubmission(URL_PREFIX);
let lastUsername = null;
/////////////////
// Session
/////////////////

function showToast(message, type="success", options={}) {
  let backgroundColor = "#4BB543";
  if (type == 'success') {
    backgroundColor = "#4BB543";
  } else if (type == 'error') {
    backgroundColor = "#FF0000";
  } else if (type == 'info') {
    backgroundColor = "#0000FF";
  }
  Toastify({
    text: message,
    duration: 3000,
    close: true,
    gravity: "top",
    position: "left",
    style: { background: backgroundColor },
    stopOnFocus: true,
    ...options
  }).showToast();
}

document.addEventListener('alpine:init', () => {
  Alpine.store('submission', {
    hasSubmission: window.hasSubmission,
    username: null,
    isAdmin: false,
    submissions: [],
    getSubmissionForPage(page) {
      return this.submissions.find(s => s.question_index == page);
    },
    wasSaved(page) {
      const sub = this.getSubmissionForPage(page);
      return sub && sub.timestamp;
    },
    getSubmissionTimestamp(page) {
      const sub = this.getSubmissionForPage(page);
      let date;
      if (sub && sub.timestamp) {
        date = new Date(sub.timestamp + " UTC");
        return date.toLocaleString('pt-BR', {timeZone: "America/Bahia"}); // TODO: allow configuring timezone
      } else {
        return null;
      }
    }
  });
})

class SubmissionSession {
  static get SESSION_KEY() { return "submissao_token_key"; }

  constructor() {
    document.addEventListener('alpine:initialized', () => {
      Alpine.store('submission').username = this.getLoggedInUsername();
      Alpine.store('submission').isAdmin = this.isAdmin();
    });
    ez.accessToken = this.getToken();
  }

  getToken() {
    return sessionStorage.getItem(SubmissionSession.SESSION_KEY);
  }
  setToken(token) {
    if (token) {
      sessionStorage.setItem(SubmissionSession.SESSION_KEY, token);
    } else {
      sessionStorage.removeItem(SubmissionSession.SESSION_KEY);
    }
    // integration with Alpine.js and ezsubmission
    Alpine.store('submission').username = this.getLoggedInUsername();
    Alpine.store('submission').isAdmin = this.isAdmin();
    ez.accessToken = token;
  }
  getLoggedInUsername() {
    const token = this.getToken();
    let username = '';
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
  initSubmissao();
  let username = submissionSession.getLoggedInUsername();
  if (username) {
    obtemRespostas(username, false);
  }
});

function clickStats(elem) {
  const token = submissionSession.isAdmin() ? submissionSession.getToken() : '';
  elem.href = `${URL_PREFIX}assignment-stats2.php?url=${window.location.href}&token=${token}`;
}

function initSubmissao() {
  // envia 1 resposta
  if (typeof addRunCodeHook === 'function') {
    addRunCodeHook(function (code, codeMirror) {
      var editorIndex = codeMirrorEditors.indexOf(codeMirror);
      if (!submissionSession.isAdmin()) {
        enviaRespostasCodeMirror(editorIndex, true);
      }
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
  loginDialog.dialog({
    autoOpen: false,
    modal: true,
    buttons: {
        "Enviar": submitLoginDialog,
        "Cancelar": function () { loginDialog.dialog("close"); }
    }
}).dialog('open');
}


function submitLoginDialog() {
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
  ez.login(data['username'], data['password'])
    .then(() => { 
      submissionSession.setToken(ez.accessToken); 
      showToast("Login realizado com sucesso.", "success");
      obtemRespostas(data['username'], true);
    })
    .catch(() => {
      submissionSession.setToken(null);
      alert("Usuário ou senha inválidos ou erro durante login.");
    });
}

function logout() {
  submissionSession.setToken(null);
}

// function enviaRespostasTotal() {
//   enviaRespostasCodeMirror();
//   enviaRespostasSurvey();
// }

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

function getAssignmentUrl() {
  return window.location.href;
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
  const assignment_url = getAssignmentUrl();
  const submission = { answer, question_index, submission_type, question_type, assignment_url };

  if (submissionSession.getLoggedInUsername() && !submissionSession.isAdmin()) {
    ez.submit(submission)
      .then((response) => {
        const ret = "Resposta enviada com sucesso.";
        // update local submissions
        const submissions = response.data['submissions'];
        for (const submission of submissions) {
          const idx = Alpine.store('submission').submissions.findIndex(s => s.question_index == submission.question_index);
          if (idx >= 0) {
            Alpine.store('submission').submissions[idx] = submission;
          } else {
            Alpine.store('submission').submissions.push(submission);
          }
        }
        if (silent) { showToast(ret); } else { showToast(ret); }
      })
      .catch(error => {
        console.log('Error', error);
        if (error.response.data.message == 'Assignment has expired') {
          const ret = "Prazo esgotado. Sua resposta NÃO será salva.";
          showToast(ret, "error");
        } else {
          submissionSession.setToken(null);
          const ret = "Erro ao enviar resposta. Por favor se autentique para tentar novamente.";
          if (silent) { showToast(ret, "error"); } else { showToast(ret); }
        }
      });
  }
}

function obtemRespostas(username, promptOverwrite=true) {
  if (submissionSession.isAdmin() && typeof username === 'undefined') {
    username = prompt("Digite o nome de usuário do aluno para carregar suas respostas:");
  } else if (!submissionSession.isAdmin()) {
    username = submissionSession.getLoggedInUsername();
  }
  if (!username) {
    return;
  }
  
  console.log('obtemRespostas', username);
  // showToast('Carregando respostas...', "info");
  ez.getLatestAnswers(getAssignmentUrl(), username)
    .then((response) => {
      if (submissionSession.isAdmin() || !promptOverwrite || confirm('Isso vai substituir suas respostas atuais pelas respostas enviadas por último. Deseja continuar?')) {
        atualizaEditoresComRespostasDoJson(response.data);
        lastUsername = username;
        Alpine.store('submission').submissions = response.data;
        showToast('Respostas carregadas')
      }
    })
    .catch((error) => alert("Erro. " + error));
}

function proximaResposta(delta) {
  $.get(URL_PREFIX + `assignment-stats.php?url=${window.location.href}`,
      data => {
        const rows = data.trim().split("\n").slice(1);
        const usernames = rows.map(r => r.split("\t")[0]);
        if (usernames.length == 0) {
          alert("Não há submissões");
        } else {
          const lastIdx = usernames.indexOf(lastUsername);
          let idx = lastIdx + delta;
          if (lastIdx == -1) {
            idx = 0;
          } else if (idx < 0) {
            idx = usernames.length - 1;
          } else if (idx >= usernames.length) {
            idx = 0;
          }
          obtemRespostas(usernames[idx]);
        }
      });
}

function atualizaEditoresComRespostasDoJson(answers) {
  for (let answer of answers) {
    codeMirrorEditors[answer.question_index].setValue(answer.answer);
  }
}

function obtemRespostasJson() {
  var answers = codeMirrorEditors.map(ed => ed.getValue());
  json = JSON.stringify({answer : answers});
  return json;
}
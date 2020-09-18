URL_PREFIX = '/aulas/lib/submissao/';


// Chame esta função antes de usar o sistema de submissão.
function initSubmissao() {
    jQuery(document).ready(function() {

        // faz uma requisição a cada 10 minutos
        setInterval(checaUsuario, 10 * 60 * 1000);

        html = jQuery.parseHTML(`
<div id="loginbar" style="width: 760px;">
    <span>Nome:</span>
    <span id="loginbar-nome">?</span>
    <span> | Matrícula:</span>
    <span id="loginbar-matricula">?</span>
    <span id="resposta-id"></span>
    <button onclick="enviaRespostas();" style="float: right;">Enviar respostas</button>
    <button onclick="showLogin();" style="float: right;">Login</button>
    <button onclick="logout();" style="float: right;">Logout</button>
</div>
<div id="dialog" title="Login" style="display: none">
    <form autocomplete="off">
        <input id="nome" type="text" size="25" placeholder="Nome Completo" /><br/>
        <input id="matricula" type="text" size="25" placeholder="Matrícula" /><br/>
        <input id="senha" type="password" size="25" placeholder="Senha" /><br/>
        <input type="submit" tabindex="-1" style="position:absolute; top:-1000px" />
    </form>
</div>
        `);
        jQuery('.post-content').append(html);

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

        // enviaRespostas
        addRunCodeHook(function (code, codeMirror) {
            var buttonIndex = codeMirrorEditors.indexOf(codeMirror);
            enviaRespostas({buttonIndex: buttonIndex}, true);
        });

        // localStorage para salvar respostas localmente
        // setTimeout(carregaRespostasLocais, 1000);
        carregaRespostasLocais();
        addRunCodeHook(function (code, codeMirror) {
            salvaRespostasLocalmente();
        });
    });
}

////////////////////////

/////////////////
// LocalStorage
/////////////////

function salvaRespostasLocalmente() {
    var data = {
        timestamp: new Date(),
        answers: obtemRespostasJson(),
        apostila: window.apostila
    };

    if (window.localStorage) {
        localStorage.setItem('ufbaprog', JSON.stringify(data));
    }
}

function carregaRespostasLocais() {
    if (window.localStorage && localStorage['ufbaprog']) {
        var dataJson = localStorage['ufbaprog'];
        var data = JSON.parse(dataJson);
        var timestamp = new Date(data.timestamp);
        var secondsElapsed = (new Date() - timestamp) / 1000;

        if (secondsElapsed <= 30 * 60) {
            console.log('Carregando respostas...');
            var answers = JSON.parse(data.answers).answers;
            carregaRespostasDeArray(answers);
            console.log("OK. Para apagar as respostas salvas localmente, digite: delete localStorage['ufbaprog'];");
        }
    }
}


testesCertos = 0;
testesErrados = 0;
function teste(expected, actual) {
    if (JSON.stringify(expected) === JSON.stringify(actual)) {
        testesCertos += 1;
        console.log("OK!");
    } else {
        testesErrados += 1;
        console.log("ERRO! Esperado: " + JSON.stringify(expected) + "; obtido: " + JSON.stringify(actual));
    }
}

$.noConflict(true); // TODO: hack

function processaRetorno(json, silent) {
    var data = JSON.parse(json);
    if (data.msg && data.msg.length > 0 && !silent) {
        alert(data.msg);
    }
}

function processaLogin(json, silent) {
    // console.log('processaLogin');
    var data = JSON.parse(json),
        nome = '',
        matricula = '';

    if (data && data.userinfo && data.userinfo.nome) {
        nome = data.userinfo.nome;
    }
    if (data && data.userinfo && data.userinfo.matricula) {
        matricula = data.userinfo.matricula;
    }
    jQuery("#loginbar-nome").text(nome);
    jQuery("#loginbar-matricula").text(matricula);
    processaRetorno(json, silent);
}

/////////////////
// Respostas
/////////////////

function obtemRespostasJson() {
    var answers = codeMirrorEditors.map(ed => ed.getValue());
    json = JSON.stringify({answers : answers});
    return json;
}

function carregaRespostasDeArray(answers) {
    codeMirrorEditors.forEach(function (ed, idx) {
        ed.setValue(answers[idx]);
    });
}

function carregaRespostasJson(json) {
    var obj = JSON.parse(json),
        answers = obj.answers;

    carregaRespostasDeArray(answers);
}

function carregaRespostasId(id) {
    recebeRespostas(id, function (data) {
        carregaRespostasJson(data);
        jQuery('#resposta-id').text(id);
    });
}

/////////////////
// Correção
/////////////////

/////////////////
// Requests
/////////////////

function checaUsuario() {
    $.post(URL_PREFIX + "checkuser.php",
        {},
        processaLogin);
}

function enviaRespostas(opcoes, silent) {
    var data = {
            answers: obtemRespostasJson(),
            apostila: window.apostila
        };
    if (opcoes !== undefined) {
        data = $.extend(data, opcoes);
    }
    $.post(URL_PREFIX + "save.php",
        data,
        function (json) {
            console.log(json.msg);
            processaLogin(json, silent);
            // console.log('Respostas enviadas!');
        });
}

function recebeRespostas(id, callback) {
    $.post(URL_PREFIX + "load.php", {id: id}, callback);
}

function listRespostasApostila(apostila) {
    if (!apostila) {
        apostila = window.apostila;
    }
    $.post(URL_PREFIX + "list.php", {apostila: apostila},
        function (data) {
            console.log(JSON.parse(data));
        });
}

function login(data) {
    $.post(URL_PREFIX + "login.php",
        data,
        processaLogin);
}

function logout() {
    $.post(URL_PREFIX + "logout.php",
        {},
        processaLogin);
}

/////////////////
// Diálogo de login
/////////////////

function submitLoginDialog() {
    // console.log('submitLoginDialog');
    var valid = false,
        data = {};

    data.nome = jQuery("#nome").val();
    data.matricula = jQuery("#matricula").val();
    data.senha = jQuery("#senha").val();

    login(data);

    jQuery("#nome").val('');
    jQuery("#matricula").val('');
    jQuery("#senha").val('');

    loginDialog.dialog("close");
    
    return valid;
}

function showLogin() {
    loginDialog.dialog('open')
}
/////////////////

function rodaTudo() {
    jQuery('.go').each(function (idx, btn) {
        console.log("\n===== Questão " + idx);
        jQuery(btn).click();
    })
}


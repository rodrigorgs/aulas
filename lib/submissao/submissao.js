// URL_PREFIX = '/mata56/2016/04/12/';
URL_PREFIX = '/mata56/';

function processaRetorno(json, silent) {
    var data = JSON.parse(json);
    if (data.msg && data.msg.length > 0 && !silent) {
        alert(data.msg);
    }
}

function processaLogin(json, silent) {
    var data = JSON.parse(json),
        nome = '',
        matricula = '';

    if (data && data.userinfo && data.userinfo.nome) {
        nome = data.userinfo.nome;
    }
    if (data && data.userinfo && data.userinfo.matricula) {
        matricula = data.userinfo.matricula;
    }
    $("#loginbar-nome").text(nome);
    $("#loginbar-matricula").text(matricula);
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

function carregaRespostasJson(json) {
    var obj = JSON.parse(json),
        answers = obj.answers;

    codeMirrorEditors.forEach(function (ed, idx) {
        ed.setValue(answers[idx]);
    });
}

function carregaRespostasId(id) {
    recebeRespostas(id, function (data) {
        carregaRespostasJson(data);
        $('#resposta-id').text(id);
    });
}

/////////////////
// Correção
/////////////////

// TODO: load from somewhere
officialTests = [
``,
`
(teste 12 (area '(3 4)))
(teste 100 (area '(2 50)))
(teste 5 (area '(1 5)))
(teste 3 (area '(2 1.5)))
(teste 4.5 (area '(3 1.5)))
(teste 0.75 (area '(0.5 1.5)))
(teste 10000 (area '(100 100)))
(teste 4 (area '(2 2)))
(teste 0.09 (area '(0.3 0.3)))
(teste 999 (area '(1 999)))
`,
`
(teste t (comprimento-par '(m a t a 5 6)))
(teste t (comprimento-par '()))
(teste Nil (comprimento-par '(2)))
(teste Nil (comprimento-par '(2 4 6)))
(teste t (comprimento-par '(m Nil)))
(teste t (comprimento-par '(1 '(3 5))))
(teste Nil (comprimento-par '(()) ))
(teste Nil (comprimento-par '(2 (4) 6)))
(teste t (comprimento-par '(1 2 3 4 5 6 7 8 9 10 11 12)))
(teste Nil (comprimento-par '(1 2 3 4 5 6 7 8 9 10 11) ))
`,
`
(teste t (tem-impar '(2 (3 2) 4)))
(teste Nil (tem-impar '()))
(teste t (tem-impar '(((((((3)))))))))
(teste t (tem-impar '(8 6 2 5)))
(teste Nil (tem-impar '(((((((2)))))))))
(teste t (tem-impar '(2 (6 (2 3 2)) 4)))
(teste Nil (tem-impar '(())))
(teste t (tem-impar '(2 (6 (3 2)) 4)))
(teste Nil (tem-impar '((0))))
(teste t (tem-impar '(+ 1 2)))
`,
`
(teste '(7 9) (filtro (lambda (x) (> x 5)) '(7 4 3 9)))
(teste '(4 3) (filtro (lambda (x) (< x 5)) '(7 4 3 9)))
(teste '(6 7 9 6) (filtro (lambda (x) (> x 5)) '(6 7 4 3 9 6)))
(teste '() (filtro (lambda (x) (> x 5)) '()))
(teste '(2 8) (filtro (lambda (x) (= 0 (% x 2))) '(1 2 3 5 8 13)))
(teste '(1 3 5 13) (filtro (lambda (x) (= 1 (% x 2))) '(1 2 3 5 8 13)))
(teste '() (filtro (lambda (x) (> 20)) '(1 2 3 5 8 13)))
(teste '() (filtro (lambda (x) (> 20)) '()))
(teste '() (filtro (lambda (x) (> x 5)) '(5)))
(teste '(5) (filtro (lambda (x) (>= x 5)) '(5)))
`
];

respostaIds = [4594, 4867, 2708, 5396, 2599, 2973, 1622, 3858, 2482, 2334, 4847, 4712, 2684, 5368, 1567, 2157, 5304, 2780, 4649, 2764, 1512, 2918, 2393, 983, 2831, 2209, 2925, 3592, 1883, 2745, 2905, 2971, 4896, 832, 4825, 2963, 5125, 4870, 5364, 2922, 4937, 5319, 2247, 4945, 4753, 4629, 2746, 5397, 2404, 5386, 4822, 5354, 4756, 1579, 2597, 2093, 2041, 2855, 4959];
respostaIdx = undefined;

function carregaRespostaStep(step) {
    if (respostaIdx === undefined) {
        if (step == 0) {
            respostaIdx = 0;
        } else if (step > 0) {
            respostaIdx = step - 1;
        } else {
            respostaIdx = respostaIds.length - step;
        }
    } else {
        console.log(respostaIdx, step);
        respostaIdx = (respostaIdx + step + respostaIds.length) % respostaIds.length;
    }
    carregaRespostasId(respostaIds[respostaIdx]);
}

function carregaRespostaSeguinte() {
    carregaRespostaStep(1);
}
function carregaRespostaAnterior() {
    carregaRespostaStep(-1);
}


function trocaEvals() {
    if (!window.oldSimplesEval) {
        oldSimplesEval = simplesEval;
        oldMultiEvalLisp = multiEvalLisp;
    }

    // var officialTests = prompt("Test code, questions separated by ---");
    // officialTests = officialTests.split("---");

    simplesEval = function (str, info) {
        str = `
oldTeste = teste;
teste = function () { };
`
+ str +
`
teste = oldTeste;
` +
(officialTests[info.index] || '')
;
        try {
            oldSimplesEval(str, info);
        } catch (e) {
            console.log('Exception: ', e);
        }
        teste = oldTeste;
    };
    multiEvalLisp = function (str, info) {
        str = `
(def oldTeste teste)
(defun teste (x y) Nil)
`
+ str +
`
(def teste (method window "teste"))
` +
(officialTests[info.index] || '')
;
        try {
            oldMultiEvalLisp(str, info);
        } catch (e) {
            console.log('Exception: ', e);
        }
        Javathcript.evalMulti('(def teste oldTeste)');
    };
}

function destrocaEvals() {
    simplesEval = oldSimplesEval;
    multiEvalLisp = oldMultiEvalLisp;
    oldSimplesEval = null;
    oldMultiEvalLisp = null;
}

// function simplesEval(str, info) {
//     zeraTestes();
//     var cmd = "(function(){" + str + "})();";
//     eval(cmd);
//     imprimeResultadoTestes();
//     return "Success!";
// }
// function multiEvalLisp(str, info) {
//     zeraTestes();
//     Javathcript.evalMulti(str);
//     imprimeResultadoTestes();
//     return "Success!";
// }

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
        function (json) { processaLogin(json, silent); });
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
    var valid = false,
        data = {};

    data.nome = $("#nome").val();
    data.matricula = $("#matricula").val();
    data.senha = $("#senha").val();

    login(data);

    $("#nome").val('');
    $("#matricula").val('');
    $("#senha").val('');

    loginDialog.dialog("close");
    
    return valid;
}

function showLogin() {
    loginDialog.dialog('open')
}

loginDialog = $("#dialog").dialog({
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

/////////////////

function rodaTudo() {
    $('.go').each(function (idx, btn) {
        console.log("\n===== Questão " + idx);
        $(btn).click();
    })
}

/////////////////
// Previne expiração da sessão

$(document).ready(function() {
    // faz uma requisição a cada 10 minutos
    setInterval(checaUsuario, 10 * 60 * 1000);

    // Submete formulario ao clicar em Rodar
    $('.go').each(function (idx, btn) {
        $(btn).on('click', function (buttonIndex) {
                return function () {
                    enviaRespostas({buttonIndex: buttonIndex}, true);
                }
            }(idx)) ;
    });
});
<?php
    session_start();
    // header("access-control-allow-origin: *");
    $SENHA_CORRETA = '123456';

    $nome = $_POST["nome"];
    $matricula = $_POST["matricula"];
    $senha = $_POST["senha"];

    $ret = array('success' => true, 'msg' => 'Login bem sucedido.', 'userinfo' => NULL);

    if ($_SESSION["nome"] != NULL || $_SESSION["matricula"] != NULL) {
        // echo json_encode(array('success' => true, msg => 'Os dados foram salvos.'));
        $ret['success'] = false;
        $ret['msg'] = 'Você já está autenticado! Realize logout primeiro.';
    } else if ($senha == $SENHA_CORRETA) {
        $_SESSION["nome"] = $nome;
        $_SESSION["matricula"] = $matricula;
    } else {
        $ret['success'] = false;
        $ret['msg'] = 'Senha incorreta.';
    }

    $ret['userinfo'] = array(
        'nome' => $_SESSION["nome"],
        'matricula' => $_SESSION["matricula"]);

    echo json_encode($ret);
?>
<?php
    session_set_cookie_params([
        'secure' => true,
        'httponly' => true,
        'samesite' => 'Strict'
    ]);
    session_start();
  
    $ret = array('success' => true, 'msg' => '', 'userinfo' => NULL);
    $ret['userinfo'] = array(
        'nome' => $_SESSION["nome"],
        'matricula' => $_SESSION["matricula"]);
    
    echo json_encode($ret);
?>
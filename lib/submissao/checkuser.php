<?php
    session_start();
  
    $ret = array('success' => true, 'msg' => '', 'userinfo' => NULL);
    $ret['userinfo'] = array(
        'nome' => $_SESSION["nome"],
        'matricula' => $_SESSION["matricula"]);
    
    echo json_encode($ret);
?>
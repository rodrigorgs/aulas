<?php
    session_start();
  
    $ret = array('success' => true, 'msg' => '', 'userinfo' => NULL);
    $ret['userinfo'] = array(
        'nome' => $_SESSION["nome"]);
    
    echo json_encode($ret);
?>

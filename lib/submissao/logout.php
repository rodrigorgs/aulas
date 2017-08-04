<?php
    // header("access-control-allow-origin: *");

    session_start();
    session_unset(); 
    session_destroy(); 
    echo json_encode(array('success' => true,
        'msg' => 'Logout realizado.',
        'userinfo' => array(
            'nome' => '',
            'matricula' => '')));
?>
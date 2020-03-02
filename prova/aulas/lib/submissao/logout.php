<?php
    // header("access-control-allow-origin: *");
    
    require_once 'config.php';
    require_once '../phpCAS/CAS.php';

    phpCAS::setDebug();
    phpCAS::setVerbose(true);

    phpCAS::client(CAS_VERSION_2_0, $cas_host, $cas_port, $cas_context);

    phpCAS::setNoCasServerValidation();

    phpCAS::logout();

    session_start();
    session_unset(); 
    session_destroy(); 
    echo json_encode(array('success' => true,
        'msg' => 'Logout realizado.',
        'userinfo' => array(
            'nome' => '')));
?>

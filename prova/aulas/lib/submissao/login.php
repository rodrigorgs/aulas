<?php
	require_once 'config.php';
	require_once '../phpCAS/CAS.php';

	phpCAS::setDebug();
	phpCAS::setVerbose(true);

	phpCAS::client(CAS_VERSION_2_0, $cas_host, $cas_port, $cas_context);

	phpCAS::setNoCasServerValidation();

	if(phpCAS::isAuthenticated()){
		$ret['success'] = false;
		$ret['msg'] = 'Você já está autenticado! Realize logout primeiro.';
	}

	phpCAS::forceAuthentication();

	if (isset($_REQUEST['logout'])) {
		phpCAS::logout();
	}

	$ret = array('success' => true, 'msg' => 'Login bem sucedido.', 'userinfo' => NULL);

	if (phpCAS::isAuthenticated()){
		$_SESSION["nome"] = phpCAS::getUser();
	}
	else{
		$ret['success'] = false;
		$ret['msg'] = 'Senha incorreta.';	
	}

	$ret['userinfo'] = array(
		'nome' => $_SESSION["nome"]);

	echo json_encode($ret);
?>

<?php
	// TODO: pegar IP e outras informações
	session_start();
	// header("access-control-allow-origin: *");
    $dbuser = 'root';
    $dbpass = '';

  	$answers = $_POST["answers"];
    $apostila = $_POST["apostila"];
    if (isset($_POST["buttonIndex"])) {
  	  $buttonIndex = $_POST["buttonIndex"];
    }
  	$nome = $_SESSION["nome"];

  	function converteMsg($msg) {
  		$msg['userinfo'] = array();
  		$msg['userinfo']['nome'] = $_SESSION["nome"];
  		return json_encode($msg);
  	}

  	if ($nome == NULL) {
  		die(converteMsg(array(
  			'success' => false,
  			'msg' => 'Faça login primeiro!')));
  	}

	$conn = mysqli_connect("localhost", $dbuser, $dbpass, "mata56");

	if (!$conn) {
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	mysqli_query($conn, "SET NAMES 'utf8'");

	mysqli_query($conn, "CREATE TABLE IF NOT EXISTS resposta (
      id INT AUTO_INCREMENT PRIMARY KEY,
			timestamp DATETIME,
			apostila VARCHAR(20),
			nome VARCHAR(256),
      button_index INT,
			answers TEXT
		);");

  $sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, button_index, answers) VALUES (NOW(), ?, ?, ?, ?);");
	
  $sql->bind_param("sssis", $apostila, $nome, $buttonIndex, $answers);
	$result = $sql->execute();

	echo converteMsg(array('success' => true, msg => 'Os dados foram salvos.'));
?>

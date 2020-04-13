<?php

	session_start();
		
	$matricula = $_GET["mat"];

	//echo $nome."<br>";

	$button_index = $_GET["questao"];

	//echo $button_index."<br>";

	$apostila = $_GET["apostila"];
	
	//$apostila = "unica";

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");

	if (!$conn) {
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	
  	mysqli_query($conn, "SET NAMES 'utf8'");
	
	$query = "select answers from resposta where (matricula = ? and button_index = ? and apostila = ?);";

	//echo $query."<br>";

	$sql = $conn->prepare($query);
	
	$sql->bind_param("sis", $matricula, $button_index, $apostila);
	
	$sql->execute();

	$result = $sql->get_result();

	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){

		echo json_encode($row['answers']);
		echo "<br>";

	}

?>

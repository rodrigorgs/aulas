<?php

	session_start();
		
	$nome = $_GET["name"];

	//echo $nome."<br>";

	$button_index = $_GET["questao"];

	//echo $button_index."<br>";

	//$apostila = $_GET["apostila"];
	
	$apostila = "unica";

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");

	if (!$conn) {
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	
  	mysqli_query($conn, "SET NAMES 'utf8'");
	
	$query = "select answers from resposta where (nome = ? and button_index = ? and apostila = ?);";

	//echo $query."<br>";

	$sql = $conn->prepare($query);
	
	$sql->bind_param("sis", $nome, $button_index, $apostila);
	
	$sql->execute();

	$result = $sql->get_result();

	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

	echo $row['answers'];

?>

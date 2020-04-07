<?php

	session_start();
		
	$nome = (STRING)$_GET["name"];

	echo $nome."<br>";

	$button_index = (INT)$_GET["questao"];

	echo $button_index."<br>";

	$apostila = $_GET["apostila"];

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");

	if (!$conn) {
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	
  	mysqli_query($conn, "SET NAMES 'utf8'");
	
	$query = "SELECT answers FROM resposta WHERE nome = ? AND button_index = ? AND apostila = ?;";

	echo $query."<br>";

	$sql = $conn->prepare($query);
	
	$sql->bind_param('sis', $nome, $button_index, $apostila);

	$result = $sql->execute();

	echo $result."<br>";

	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);

	echo $row['answers'];

?>

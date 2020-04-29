<?php

	session_start();
		
	$matricula = $_GET["mat"];

	//echo $nome."<br>";

	$button_index = $_GET["questao"];

	//echo $button_index."<br>";

	$apostila = $_GET["apostila"];
	
	//$apostila = "unica";

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");

	if (!$conn){
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	
  	mysqli_query($conn, "SET NAMES 'utf8'");
	
	$query = "select answers from resposta where (matricula = ? and apostila = ?) order by timestamp desc;";

	//echo $query."<br>";

	$sql = $conn->prepare($query);
	
	$sql->bind_param("ss", $matricula, $apostila);
	
	$sql->execute();

	$result = $sql->get_result();

	$val = array();

	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		$val = $row["answers"];
	}

	echo "<pre>" . $val . "</pre><br>";

	$value = json_decode($val, true);

	echo "<pre>" . $value[1]["answers"] . "</pre>";

	//echo "<pre>" . htmlspecialchars($value["answers"][1]) . "</pre>";

?>

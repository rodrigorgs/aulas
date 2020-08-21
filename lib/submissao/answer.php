<?php

	session_start();
		
	$matricula = $_GET["mat"];

	//echo $matricula."<br>";

	$button_index = $_GET["questao"];

	//echo $button_index."<br>";

	$apostila = $_GET["apostila"];
	
	//echo $apostila."<br>";

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");

	if (!$conn){
  		die(converteMsg(array(
  				'success' => false,
  				'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
	}
	
  	mysqli_query($conn, "SET NAMES 'utf8'");
	
	$query = "select answers from resposta where (matricula = ? and apostila = ?) order by button_index, timestamp desc;";

	//echo $query."<br>";

	$sql = $conn->prepare($query);
	
	$sql->bind_param("ss", $matricula, $apostila);
	
	$sql->execute();

	$result = $sql->get_result();

	$val = array();

	$count = 0;

	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		$val[$count] = $row["answers"];
		$count = $count + 1;
	}

	//echo "<pre>" . $val[(int)$button_index] . "</pre><br>";

	//echo $val[1]."<br>";

	$value = json_encode($val[(int)$button_index]);

	$data = json_decode(json_decode($value, true), true);

	echo "<pre>" . htmlspecialchars($data["answers"][0]) . "</pre>";

?>

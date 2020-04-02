<?php

	$apostila = $_GET["apostila"];
	$conn = mysqli_connect("localhost", "root", "root", "mata56");

 	if (!$conn) {
		die(converteMsg(array(
			'success' => false,
			'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  	}
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$sql = $conn->prepare("
		select ? from resposta");
	$sql->bind_param("s", $apostila);
	$sql->execute();
	$result = $sql->get_result();

  	echo "<table>";
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		$apostila = $row['apostila'];
		echo "<tr><td>".$apostila."<td><tr>";
	}
?>

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

 	$data = mysqli_fetch_all($result, MYSQLI_ASSOC);

  	echo "<table border='1'>";
  	foreach($data as $key => $row) {
  	    echo "<tr>";
  	    foreach($row as $key2 => $row2){
  	        echo "<td>" . $row2 . "</td>";
  	    }
  	    echo "</tr>";
  	}
  	echo "</table>";
?>

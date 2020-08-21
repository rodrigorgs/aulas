<?php

	session_start();
	$conn = mysqli_connect("localhost", "root", "123456", "mata56");
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$sql = $conn->prepare("select distinct apostila from resposta order by apostila");
	$sql->execute();
	$result = $sql->get_result();

	echo "<h1>Respostas</h1>";

  	echo "<table>";
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		$apostila = $row['apostila'];
		echo "<tr><td><a href = 'handout.php?apostila=".$apostila."'>".$apostila."</a><td><tr>";
	}
	echo "</table>";
?>

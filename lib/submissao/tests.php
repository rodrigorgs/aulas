<?php

	$dbuser = 'root';
    $dbpass = '123456';

	$conn = mysqli_connect("localhost", $dbuser, $dbpass, "mata56");

	mysqli_query($conn, "SET NAMES 'utf8'");

	mysqli_query($conn, "CREATE DATABASE IF NOT EXISTS mata56;");

	mysqli_query($conn, "USE mata56;");
	
	mysqli_query($conn, "DROP TABLE resposta;");

	mysqli_query($conn, "CREATE TABLE IF NOT EXISTS resposta (
      						id INT AUTO_INCREMENT PRIMARY KEY,
							timestamp DATETIME,
							apostila VARCHAR(20),
							nome VARCHAR(256),
							matricula VARCHAR(20),
					  		button_index INT,
							answers TEXT,
							testes_ok INT,
							testes_total INT
						);");

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Fulano', '1234567890', 1, '{}', 3, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Fulano', '1234567890', 2, '{}', 3, 6);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Sicrana', '1233214567', 1, '{}', 5, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Sicrana', '1233214567', 2, '{}', 6, 6);");
	$result = $sql->execute();
	
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Beltrano', '0987654321', 1, '{}', 8, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Beltrano', '0987654321', 2, '{}', 1, 6);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Beltrano', '0987654321', 4, '{}', 4, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), '{}', 'Beltrano', '0987654321', 3, '{}', 15, 15);");
	$result = $sql->execute();

	echo "Tudo foi impresso";
?>

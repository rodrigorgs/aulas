<?php

	$dbuser = 'root';
    $dbpass = '123456';

	$value = "{\"answers\":[\"digite seu nome completo\",\"; se quiser, pode definir funções auxiliares\n(define (area medidas) \n 'implementeAFuncao)\n\n(teste 12 (area '(3 4)))\n; Crie no mínimo 2 testes adicionais\n;(teste ... ...)\n;(teste ... ...)\n;(teste ... ...)\n\"]}";

	/* echo "INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 1, '".json_encode($value)."', 3, 10); <br>";

	var_dump(json_encode($value, true));
	echo "<br>"; */

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

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 1, ? , 3, 10);");
	$sql->bind_param("s", json_encode($value, true));
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 2, 'resposta 1', 3, 6);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Sicrana', '1233214567', 1, 'resposta 2', 5, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Sicrana', '1233214567', 2, 'resposta 3', 6, 6);");
	$result = $sql->execute();
	
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 1, 'resposta 4', 8, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 2, 'resposta 5', 1, 6);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 4, 'resposta 6', 4, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 3, 'resposta 7', 15, 15);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Fulana', '1238634712', 3, 'resposta 8', 10, 15);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Fulana', '1238634712', 4, 'resposta 9', 7, 10);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Sicrano', '0988907654', 3, 'resposta 10', 3, 15);");
	$result = $sql->execute();

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, testes_ok, testes_total) VALUES (NOW(), 'unica', 'Sicrano', '0988907654', 1, 'resposta 11', 9, 10);");
	$result = $sql->execute();

	echo "Tudo foi impresso";
?>

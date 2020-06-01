<?php

	$dbuser = 'root';
    $dbpass = '123456';

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 15 (area '(5 3)))\\n;(teste 20 (area '(4 5)))\\n;(teste 0 (area '(2 0)))\\n\"]}";

	$val = "{\"results\": [{\"ok\": 3, \"total\": 10}]}";

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
							results TEXT
						);");

	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 1, ? , ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 4 (area '(2 2)))\\n;(teste 10 (area '(5 2)))\\n;(teste 6 (area '(3 2)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 3, \"total\": 6}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 2, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 100 (area '(2 50)))\\n;(teste 25 (area '(5 5)))\\n;(teste 18 (area '(9 2)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 5, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrana', '1233214567', 1, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 13 (area '(13 1)))\\n;(teste 144 (area '(12 12)))\\n;(teste 169 (area '(13 13)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 6, \"total\": 6}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrana', '1233214567', 2, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();
	
	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 90 (area '(15 6)))\\n;(teste 310 (area '(31 10)))\\n;(teste 5 (area '(1 5)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 8, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 1, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 1 (area '(1 1)))\\n;(teste 30 (area '(15 2)))\\n;(teste 8 (area '(4 2)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 1, \"total\": 6}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 2, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 40 (area '(2 20)))\\n;(teste 90 (area '(3 30)))\\n;(teste 70 (area '(14 5)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 4, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 4, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 200 (area '(2 100)))\\n;(teste 200 (area '(25 8)))\\n;(teste 200 (area '(50 4)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 15, \"total\": 15}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 3, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 350 (area '(7 50)))\\n;(teste 490 (area '(7 70)))\\n;(teste 280 (area '(7 40)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 15}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulana', '1238634712', 3, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 9 (area '(1 9)))\\n;(teste 11 (area '(11 1)))\\n;(teste 19 (area '(19 1)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 7, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulana', '1238634712', 4, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 55 (area '(5 11)))\\n;(teste 33 (area '(3 11)))\\n;(teste 99 (area '(9 11)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 3, \"total\": 15}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrano', '0988907654', 3, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 60 (area '(12 5)))\\n;(teste 48 (area '(4 12)))\\n;(teste 72 (area '(6 12)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 9, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrano', '0988907654', 1, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"Sicrano\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrano', '0988907654', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"Beltrano\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Beltrano', '0987654321', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"Fulano\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulano', '1234567890', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"Sicrana\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Sicrana', '1233214567', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	$value = "{\"answers\":[\"Fulana\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'unica', 'Fulana', '1238634712', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

 $value = "{\"answers\":[\"Fulana\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'computacao', 'Fulana', '1238634712', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 9 (area '(1 9)))\\n;(teste 11 (area '(11 1)))\\n;(teste 19 (area '(19 1)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 7, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'computacao', 'Fulana', '1238634712', 2, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"Sicrana\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'lab', 'Sicrana', '1233214567', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 13 (area '(13 1)))\\n;(teste 144 (area '(12 12)))\\n;(teste 169 (area '(13 13)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 6, \"total\": 6}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'lab', 'Sicrana', '1233214567', 1, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"Fulano\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'atividade', 'Fulano', '1234567890', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 4 (area '(2 2)))\\n;(teste 10 (area '(5 2)))\\n;(teste 6 (area '(3 2)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 3, \"total\": 6}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'atividade', 'Fulano', '1234567890', 3, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"Beltrano\"]}";
	$val = "{\"results\": [{\"ok\": 10, \"total\": 10}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'programacao', 'Beltrano', '0987654321', 0, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

$value = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;(teste 200 (area '(2 100)))\\n;(teste 200 (area '(25 8)))\\n;(teste 200 (area '(50 4)))\\n\"]}";
	$val = "{\"results\": [{\"ok\": 15, \"total\": 15}]}";
	$sql = $conn->prepare("INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), 'programacao', 'Beltrano', '0987654321', 2, ?, ?);");
	$sql->bind_param("ss", $value, $val);
	$result = $sql->execute();

	echo "Tudo foi impresso";
?>

<?php

	session_start();

	$apostila = $_GET["apostila"];

	//$apostila = "unica";

	//echo $apostila;
	//echo "<br>";

	function defineColor($parameter){
		//echo $parameter. "<br>";
		if($parameter < 5.0){
			return "red";
		}
		else{
			if($parameter >= 5.0 && $parameter < 7.0){
				return "#3366ff";
			}
			else{
				return "green";
			} 
		}
	}

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");
	

	if (!$conn){
		die(converteMsg(array(
			'success' => false,
			'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  	}
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$query = "select matricula, nome, button_index, results from resposta where (apostila = ? && button_index > 0) order by nome, button_index";

	$zeroquery = "INSERT INTO resposta (timestamp, apostila, nome, matricula, button_index, answers, results) VALUES (NOW(), ?, ?, ?, ?, ?, ?)"; 

	$jsonpadrao = "{\"answers\":[\"; se quiser, pode definir funções auxiliares\\n(define (area medidas) \\n 'implementeAFuncao)\\n\\n(teste 12 (area '(3 4)))\\n; Crie no mínimo 2 testes adicionais\\n;\\n\"]}";

	$resultspadrao = "{\"results\": [{\"ok\": 3, \"total\": 10}]}";

	//echo $query;

	$sql = $conn->prepare($query);
	$sql->bind_param("s", $apostila);
	$sql->execute();
	$result = $sql->get_result();
	$um = 1;

	$sql_2 = $conn->prepare("select max(button_index) from resposta where apostila = ?");
	$sql_2->bind_param("s", $apostila);
	$sql_2->execute();
	$result_2 = $sql_2->get_result();
	$num_linhas = mysqli_fetch_array($result_2, MYSQLI_ASSOC);
	$total_rows = $num_linhas['max(button_index)'];

	//echo $total_rows."<br>";

	$questoestotais = array();
	$questoestotais[0] = 10;

	$contador = 1;
	while($contador <= $total_rows){
		$totalparc = 0;
		$sql_4 = $conn->prepare("select results from resposta where button_index = ?");
		$sql_4->bind_param("i", $contador);
		$sql_4->execute();
		$result_4 = $sql_4->get_result();
		while($t = mysqli_fetch_array($result_4, MYSQLI_ASSOC)){
			$val_qparcial = $t["results"];
			$val_qtotal = json_decode($val_qparcial, true);
			$val_q = $val_qtotal["results"][0]["total"];
			if($val_q > $totalparc){
				$totalparc = $val_q;
			}
		}
		$questoestotais[$contador] = $totalparc;
		$contador = $contador + 1;
	}

	echo "<h1>Atividades</h1>";

	echo "<table style = 'border: solid 2px; border-collapse: collapse;'>";
	echo "<thead>";
	echo "<tr><th style = 'text-align: center; border: solid 2px;'>Matrícula</th><th style = 'text-align: center; border: solid 2px;'>Nome</th>";
	$num_rows = 1;
	while($num_rows <= $total_rows){
		echo"<th style = 'border: solid 2px;'>Atividade ".$num_rows."</th>";
		$num_rows++;
	}
	echo "</tr>";
	echo "</thead>";
	echo "<tbody>";

	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$num_rows = 1;
	$matricula = $row['matricula'];
	$nome = $row['nome'];
	$button_index = $row['button_index'];
	$results = $row['results'];
	//echo $results . "<br>";
	$testes = json_decode($results, true);
	//var_dump($testes["results"][0]["ok"]) . "<br>";
	$testes_ok = $testes["results"][0]["ok"];
	$testes_total = $testes["results"][0]["total"];
	$testes_corretos = $testes_ok / $testes_total * 100;
	echo "<tr><td style = 'text-align: center; border: solid black 2px;'>".$matricula."</td><td style = 'text-align: center; border: solid black 2px;'>".$nome."</td>";
	if ($button_index == 1){
		echo "<td style = 'text-align: center; color:".
			defineColor($testes_corretos/10).
			"; border: solid black 2px;'>".
			"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
			number_format((float)$testes_corretos, 2, '.', '')."%)".
			"</td>";
			//echo $button_index." first part one <br>";
	}
	else{
		while($button_index > $num_rows){
			$resultspadrao = "{\"results\": [{\"ok\": 0, \"total\": ". $questoestotais[1] ."}]}";
			$sql_3 = $conn->prepare($zeroquery);
			$sql_3->bind_param("sssiss", $apostila, $nome, $matricula, $num_rows, $jsonpadrao, $resultspadrao);
			$sql_3->execute();
			echo "<td style = 'text-align: center; color:red; border: solid black 2px;'>"."<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=1'>"."0</a> (".number_format(0, 2, '.', '')."%)"."</td>";
			//echo "first part two <br>";
			$num_rows++;
		}
		echo "<td style = 'text-align: center; color:".
			defineColor($testes_corretos/10).
			"; border: solid black 2px;'>".
			"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
			number_format((float)$testes_corretos, 2, '.', '')."%)".
			"</td>";
			//echo $button_index." first part three <br>";		
	}				
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		if ($nome == $row['nome']){
			$num_rows++;
			$button_index = $row['button_index'];
			if ($button_index > $num_rows){
				while ($num_rows < $button_index){
					$resultspadrao = "{\"results\": [{\"ok\": 0, \"total\": ". $questoestotais[$num_rows] ."}]}";
					$sql_3 = $conn->prepare($zeroquery);
					$sql_3->bind_param("sssiss", $apostila, $nome, $matricula, $num_rows, $jsonpadrao, $resultspadrao);
					$sql_3->execute();
					echo "<td style = 'text-align: center; color:red; border: solid black 2px;'>"."<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$num_rows."'>"."0</a> (".number_format(0, 2, '.', '')."%)"."</td>";
					//echo $num_rows." ".$button_index." second part one <br>";
					$num_rows++;
				}
				$results = $row['results'];
				//echo $results . "<br>";
				$testes = json_decode($results, true);
				//var_dump($testes["results"][0]["ok"]) . "<br>";
				$testes_ok = $testes["results"][0]["ok"];
				$testes_total = $testes["results"][0]["total"];
				$testes_corretos = $testes_ok / $testes_total * 100;
				echo "<td style = 'text-align: center; color:".
				defineColor($testes_corretos/10).
				"; border: solid black 2px;'>".
				"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
				number_format((float)$testes_corretos, 2, '.', '')."%)".
				"</td>";
				//echo $button_index." second part two <br>";
			}
			else{
				$results = $row['results'];
				//echo $results . "<br>";
				$testes = json_decode($results, true);
				//var_dump($testes["results"][0]["total"]) . "<br>";
				$testes_ok = $testes["results"][0]["ok"];
				$testes_total = $testes["results"][0]["total"];
				//echo $testes_ok . "<br>" . $testes_total . "<br>";
				$testes_corretos = $testes_ok / $testes_total * 100;
				echo "<td style = 'text-align: center; color:".
				defineColor($testes_corretos/10).
				"; border: solid black 2px;'>".
				"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
				number_format((float)$testes_corretos, 2, '.', '')."%)";
				"</td>";
				//echo $button_index." second part three <br>";
			}
		}
		else{
			$num_rows++;
			if ($num_rows <= $total_rows){
				while ($num_rows <= $total_rows){
					$resultspadrao = "{\"results\": [{\"ok\": 0, \"total\": ". $questoestotais[$num_rows] ."}]}";
					$sql_3 = $conn->prepare($zeroquery);
					$sql_3->bind_param("sssiss", $apostila, $nome, $matricula, $num_rows, $jsonpadrao, $resultspadrao);
					$sql_3->execute();
					echo "<td style = 'text-align: center; color:red; border: solid black 2px;'>"."<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$num_rows."'>"."0</a> (".number_format(0, 2, '.', '')."%)"."</td>";
					$num_rows++;
					//echo $num_rows." third part one <br>";
				}
			}
			echo "</tr>";
			$num_rows = 1;
			$matricula = $row['matricula'];
			$nome = $row['nome'];
			$button_index = $row['button_index'];
			$results = $row['results'];
			//echo $results . "<br>";
			$testes = json_decode($results, true);
			//var_dump($testes["results"][0]["ok"]) . "<br>";
			$testes_ok = $testes["results"][0]["ok"];
			$testes_total = $testes["results"][0]["total"];
			$testes_corretos = $testes_ok / $testes_total * 100;
			echo "<tr><td style = 'border: solid black 2px;'>".$matricula."</td style = 'border: solid black 2px;'><td style = 'border: solid black 2px;'>".$nome."</td>";
			if ($button_index == 1){
				echo "<td style = 'text-align: center; color:".
					defineColor($testes_corretos/10).
					"; border: solid black 2px;'>".
					"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
					number_format((float)$testes_corretos, 2, '.', '')."%)";
					"</td>";
				//echo $button_index." third part two <br>";
			}
			else{
					while ($num_rows < $button_index){
						$resultspadrao = "{\"results\": [{\"ok\": 0, \"total\": ". $questoestotais[$num_rows] ."}]}";
						//echo $resultspadrao . "<br>";
						$sql_3 = $conn->prepare($zeroquery);
						$sql_3->bind_param("sssiss", $apostila, $nome, $matricula, $num_rows, $jsonpadrao, $resultspadrao);
						$sql_3->execute();
						echo "<td style = 'text-align: center; color:red; border: solid black 2px;'>"."<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=1'>"."0</a> (".number_format(0, 2, '.', '')."%)"."</td>";
						//echo $num_rows." ".$button_index." third part three <br>";
						$num_rows++;
					}
					$results = $row['results'];
					//echo $results . "<br>";
					$testes = json_decode($results, true);
					//var_dump($testes["results"][0]["ok"]) . "<br>";
					$testes_ok = $testes["results"][0]["ok"];
					$testes_total = $testes["results"][0]["total"];
					$testes_corretos = $testes_ok / $testes_total * 100;
					echo "<td style = 'text-align: center; color:".
					defineColor($testes_corretos/10).
					"; border: solid black 2px;'>".
					"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
					number_format((float)$testes_corretos, 2, '.', '')."%)".
					"</td>";
					//echo $button_index." third part four <br>";
			}				
		}
	}
	$num_rows++;
	if ($num_rows <= $total_rows){
		while ($num_rows <= $total_rows){
			$resultspadrao = "{\"results\": [{\"ok\": 0, \"total\": ". $questoestotais[$num_rows] ."}]}";
			$sql_3 = $conn->prepare($zeroquery);
			$sql_3->bind_param("sssiss", $apostila, $nome, $matricula, $num_rows, $jsonpadrao, $resultspadrao);
			$sql_3->execute();
			echo "<td style = 'text-align: center; color:red; border: solid black 2px;'>"."<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$num_rows."'>"."0</a> (".number_format(0, 2, '.', '')."%)"."</td>";
			$num_rows++;
			//echo $num_rows." fourth part one <br>";
		}
	}
	echo "</tr>";
	echo "</tbody>";
	echo"</table>";
?>

<?php

	session_start();

	function defineColor($parameter){
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

	function passparameters($par_nome, $par_button_index){
		$_SESSION['nome'] = $par_nome;
		$_SESSION['button_index'] = $par_button_index;
	}

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");
	

	if (!$conn){
		die(converteMsg(array(
			'success' => false,
			'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  	}
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$sql = $conn->prepare("
		select matricula, nome, button_index, testes_ok, testes_total from resposta order by nome, button_index");
	$sql->execute();
	$result = $sql->get_result();


	$sql_2 = $conn->prepare("select max(button_index) from resposta");
	$sql_2->execute();
	$result_2 = $sql_2->get_result();
	$num_linhas = mysqli_fetch_array($result_2, MYSQLI_ASSOC);
	$total_rows = $num_linhas['max(button_index)'];

	echo "<h1>Atividades</h1>";

	echo "<table>";
	echo "<tr><td>Matrícula</td><td>Nome</td>";
	$num_rows = 1;
	while($num_rows <= $total_rows){
		echo"<td>Atividade ".$num_rows."</td>";
		$num_rows++;
	}
	echo "</tr>";

	$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
	$num_rows = 1;
	$matricula = $row['matricula'];
	$nome = $row['nome'];
	$button_index = $row['button_index'];
	$testes_ok = $row['testes_ok'];
	$testes_total = $row['testes_total'];
	$testes_corretos = $testes_ok / $testes_total * 10;
	echo "<tr><td>".$matricula."</td><td>".$nome."</td>";
	if ($button_index == 1){
		echo "<td href='answer.php' style = 'color:".
			defineColor($testes_corretos).
			";'>".
			number_format((float)$testes_corretos, 2, '.', '').
			"</td>";
			//echo $button_index." first part one <br>";
	}
	else{
		echo "<td style = 'color:red'>".number_format(0, 2, '.', '')."</td>";
		//echo "first part two <br>";
	}				
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		if ($nome == $row['nome']){
			$num_rows++;
			$button_index = $row['button_index'];
			if ($button_index > $num_rows){
				while ($num_rows < $button_index){
					echo "<td style = 'color:red;'>".number_format(0, 2, '.', '')."</td>";
					//echo $num_rows." second part one <br>";
					$num_rows++;
				}
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total * 10;
				echo "<td style = 'color:".
				defineColor($testes_corretos).
				";'>".
				number_format((float)$testes_corretos, 2, '.', '').
				"</td>";
				//echo $button_index." second part two <br>";
			}
			else{
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total * 10;
				echo "<td style = 'color:".
				defineColor($testes_corretos).
				";'>".
				number_format((float)$testes_corretos, 2, '.', '').
				"</td>";
				//echo $button_index." second part three <br>";
			}
		}
		else{
			$num_rows++;
			if ($num_rows <= $total_rows){
				while ($num_rows <= $total_rows){
					echo "<td style = 'color:red;'>".number_format(0, 2, '.', '')."</td>";
					$num_rows++;
					//echo $num_rows." third part one <br>";
				}
			}
			echo "</tr>";
			$num_rows = 1;
			$matricula = $row['matricula'];
			$nome = $row['nome'];
			$button_index = $row['button_index'];
			$testes_ok = $row['testes_ok'];
			$testes_total = $row['testes_total'];
			$testes_corretos = $testes_ok / $testes_total * 10;
			echo "<tr><td>".$matricula."</td><td>".$nome."</td>";
			if ($button_index == 1){
				echo "<td style = 'color:".
					defineColor($testes_corretos).
					";'>".
					number_format((float)$testes_corretos, 2, '.', '').
					"</td>";
				//echo $button_index." third part two <br>";
			}
			else{
				echo "<td style = 'color:red;'>".number_format(0, 2, '.', '')."</td>";
				//echo $button_index." third part three <br>";
			}				
		}
	}
	$num_rows++;
	if ($num_rows <= $total_rows){
		while ($num_rows <= $total_rows){
			echo "<td style = 'color:red'>".number_format(0, 2, '.', '')."</td>";
			$num_rows++;
			//echo $num_rows." third part one <br>";
		}
	}
	echo "</tr>";
	echo"</table>";
?>

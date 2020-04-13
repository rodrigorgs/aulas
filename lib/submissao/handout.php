<?php

	session_start();

	$apostila = $_GET["apostila"];

	//$apostila = "unica";

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

	$conn = mysqli_connect("localhost", "root", "123456", "mata56");
	

	if (!$conn){
		die(converteMsg(array(
			'success' => false,
			'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  	}
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$query = "select matricula, nome, button_index, testes_ok, testes_total from resposta where apostila = ? order by nome, button_index";

	//echo $query;

	$sql = $conn->prepare($query);
	$sql->bind_param("s", $apostila);
	$sql->execute();
	$result = $sql->get_result();


	$sql_2 = $conn->prepare("select max(button_index) from resposta");
	$sql_2->execute();
	$result_2 = $sql_2->get_result();
	$num_linhas = mysqli_fetch_array($result_2, MYSQLI_ASSOC);
	$total_rows = $num_linhas['max(button_index)'];

	echo "<h1>Atividades</h1>";

	echo "<table>";
	echo "<thead>";
	echo "<tr><th style = 'text-align: center;'>Matrícula</th><th style = 'text-align: center;'>Nome</th>";
	$num_rows = 1;
	while($num_rows <= $total_rows){
		echo"<th>Atividade ".$num_rows."</th>";
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
	$testes_ok = $row['testes_ok'];
	$testes_total = $row['testes_total'];
	$testes_corretos = $testes_ok / $testes_total * 100;
	echo "<tr><td style = 'text-align: center;'>".$matricula."</td><td style = 'text-align: center;'>".$nome."</td>";
	if ($button_index == 1){
		echo "<td style = 'text-align: center; color:".
			defineColor($testes_corretos).
			";'>".
			"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
			number_format((float)$testes_corretos, 2, '.', '')."%)".
			"</td>";
			//echo $button_index." first part one <br>";
	}
	else{
		echo "<td style = 'text-align: center; color:red'>"."0 (".number_format(0, 2, '.', '')."%)"."</td>";
		//echo "first part two <br>";
	}				
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		if ($nome == $row['nome']){
			$num_rows++;
			$button_index = $row['button_index'];
			if ($button_index > $num_rows){
				while ($num_rows < $button_index){
					echo "<td style = 'text-align: center; color:red;'>"."0 (".number_format(0, 2, '.', '')."%)"."</td>";
					//echo $num_rows." ".$button_index." second part one <br>";
					$num_rows++;
				}
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total * 100;
				echo "<td style = 'text-align: center; color:".
				defineColor($testes_corretos).
				";'>".
				"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
				number_format((float)$testes_corretos, 2, '.', '')."%)".
				"</td>";
				//echo $button_index." second part two <br>";
			}
			else{
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total * 100;
				echo "<td style = 'text-align: center; color:".
				defineColor($testes_corretos).
				";'>".
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
					echo "<td style = 'text-align: center; color:red;'>"."0 (".number_format(0, 2, '.', '')."%)"."</td>";
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
			$testes_corretos = $testes_ok / $testes_total * 100;
			echo "<tr><td>".$matricula."</td><td>".$nome."</td>";
			if ($button_index == 1){
				echo "<td style = 'text-align: center; color:".
					defineColor($testes_corretos).
					";'>".
					"<a href = 'answer.php?apostila=".$apostila."&mat=".$matricula."&questao=".$button_index."'>".$testes_ok."</a>"." (".
					number_format((float)$testes_corretos, 2, '.', '')."%)";
					"</td>";
				//echo $button_index." third part two <br>";
			}
			else{
					while ($num_rows < $button_index){
						echo "<td style = 'text-align: center; color:red;'>"."0 (".number_format(0, 2, '.', '')."%)"."</td>";
						//echo $num_rows." ".$button_index." third part three <br>";
						$num_rows++;
					}
					$testes_ok = $row['testes_ok'];
					$testes_total = $row['testes_total'];
					$testes_corretos = $testes_ok / $testes_total * 100;
					echo "<td style = 'text-align: center; color:".
					defineColor($testes_corretos).
					";'>".
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
			echo "<td style = 'text-align: center; color:red'>"."0 (".number_format(0, 2, '.', '')."%)"."</td>";
			$num_rows++;
			//echo $num_rows." fourth part one <br>";
		}
	}
	echo "</tr>";
	echo "</tbody>";
	echo"</table>";
?>

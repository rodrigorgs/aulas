<?php

	function defineColor($parameter){
		if($parameter < 5.0){
			return "red";
		}
		else{
			if($parameter >= 5.0 && $parameter < 7.0){
				return "yellow";
			}
			else{
				return "green";
			} 
		}
	}

	$conn = mysqli_connect("localhost", "root", "root", "mata56");
	

	if (!$conn){
		die(converteMsg(array(
			'success' => false,
			'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  	}
  	mysqli_query($conn, "SET NAMES 'utf8'");

	$sql = $conn->prepare("
		select matricula, nome, button_index, testes_ok, testes_total from resposta order by matricula, button_index");
	$sql->execute();
	$result = $sql->get_result();


	$sql_2 = $conn->prepare("select max(button_index) from resposta");
	$sql_2->execute();
	$result_2 = $sql_2->get_result();
	$num_linhas = mysqli_fetch_array($result_2, MYSQLI_ASSOC)
	$total_rows = $num_linhas['max(button_index)'];

	echo "<table>";
	$row = mysqli_fetch_array($result, MYSQLI_ASSOC)
	$num_rows = 1;
	$matricula = $row['matricula'];
	$nome = $row['nome'];
	$button_index = $row['button_index'];
	$testes_ok = $row['testes_ok'];
	$testes_total = $row['testes_total'];
	$testes_corretos = $testes_ok / $testes_total;
	$apostila = $row['apostila'];		
	echo "<tr><td>".$matricula."</td><td>".$nome."</td>";
	if ($button_index == 1){
		echo "<td>".
			$button_index.
			"<pre color = '".
			defineColor($testes_corretos).
			"'>".
			$testes_corretos.
			"</pre></td>";
	}
	else{
		echo "<td>".
			$button_index.
			"<pre color = 'red'>0</pre></td>";
	}				
	while ($row = mysqli_fetch_array($result, MYSQLI_ASSOC)){
		if ($nome == $row['nome']){
			$num_rows++;
			if ($button_index > $num_rows){
				while ($num_rows < $button_index){
					echo "<td>".
						$num_rows.
						"<pre color = 'red'>0</pre></td>";
					$num_rows++;
				}
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total;
				echo "<td>".
				$button_index.
				"<pre color = '".
				defineColor($testes_corretos).
				"'>".
				$testes_corretos.
				"</pre></td>";
			}
			else{
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total;
				echo "<td>".
				$button_index.
				"<pre color = '".
				defineColor($testes_corretos).
				"'>".
				$testes_corretos.
				"</pre></td>";
			}
		}
		else{
			$num_rows++;
			if ($num_rows <= $total_rows){
				while ($num_rows <= $total_rows){
					echo "<td>".
						$num_rows.
						"<pre color = 'red'>0</pre></td>";
					$num_rows++;
				}
			}
			else{
				echo "</tr>";
				$num_rows = 1;
				$matricula = $row['matricula'];
				$nome = $row['nome'];
				$button_index = $row['button_index'];
				$testes_ok = $row['testes_ok'];
				$testes_total = $row['testes_total'];
				$testes_corretos = $testes_ok / $testes_total;
				$apostila = $row['apostila'];		
				echo "<tr><td>".$matricula."</td><td>".$nome."</td>";
				if ($button_index == 1){
					echo "<td>".
						$button_index.
						"<pre color = '".
						defineColor($testes_corretos).
						"'>".
						$testes_corretos.
						"</pre></td>";
				}
				else{
					echo "<td>".
						$button_index.
						"<pre color = 'red'>0</pre></td>";
				}				
			}
		}
	}
	echo "</tr>";
	echo"</table>";
?>

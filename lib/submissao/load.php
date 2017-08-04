<?php
  $id = $_POST["id"];

  $conn = mysqli_connect("localhost", "root", "root", "mata56");

  if (!$conn) {
    die(converteMsg(array(
        'success' => false,
        'msg' => 'Erro de banco de dados: ' . mysqli_connect_error())));
  }
  mysqli_query($conn, "SET NAMES 'utf8'");

  $sql = $conn->prepare("SELECT answers FROM resposta WHERE id = ?;");
  
  $sql->bind_param("i", $id);
  $sql->execute();
  $result = $sql->get_result();

  $data = mysqli_fetch_all($result, MYSQLI_ASSOC)[0]["answers"];

  echo $data;

?>

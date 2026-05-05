<?php
  ini_set('display_errors', 1);
  error_reporting(E_ALL);

  $host_name = 'host_name';
  $database = 'database';
  $user_name = 'user_name';
  $password = 'password';

  $link = new mysqli($host_name, $user_name, $password, $database);

  if ($link->connect_error) {
    die('<p>Verbindung zum MySQL Server fehlgeschlagen: '. $link->connect_error .'</p>');
  } else {
    $result = $link->query("SELECT * FROM pokedex");

    $pokemon = [];

    while($row = $result->fetch_assoc()) {
        $pokemon[] = $row;
    }

    echo json_encode ($pokemon);
  }
?>
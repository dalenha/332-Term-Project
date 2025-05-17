<?php /* db_config.php */
$DB_HOST = "mariadb";
$DB_USER = "cs332t3";   // change to the account that hosts the DB
$DB_PASS = "kRmw60Wv";
$DB_NAME = "cs332t3";
$conn = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
if ($conn->connect_error) die("Connection failed: ".$conn->connect_error);
?>
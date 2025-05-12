<?php /* db_config.php */
$DB_HOST = "localhost";
$DB_USER = "cpsc332xx";   // change to the account that hosts the DB
$DB_PASS = "YOUR_PASSWORD";
$DB_NAME = "university";
$conn = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
if ($conn->connect_error) die("Connection failed: ".$conn->connect_error);
?>

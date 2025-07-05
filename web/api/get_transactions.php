<?php

header("Content-Type: application/json");

require_once '../config/Database.php';
require_once '../models/Transaction.php';

$database = new Database();
$db = $database->getConnection();
$model = new Transaction($db);

$stmt = $model->getAll();
$data = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode([
    "status" => true,
    "data" => $data
]);


<?php

header("Content-Type: application/json");
require_once '../config/Database.php';
require_once '../models/Transaction.php';

$id = $_GET['id'] ?? null;

if (!$id) {
    echo json_encode([
        "status" => false,
        "message" => "ID is required"
    ]);
    exit;
}

$database = new Database();
$db = $database->getConnection();
$model = new Transaction($db);

$model->id = $id;

$data = $model->show();

echo json_encode([
    "status" => true,
    "data" => $data
]);
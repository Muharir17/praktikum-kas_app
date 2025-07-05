<?php

header("Content-Type: application/json");

require_once '../config/Database.php';
require_once '../models/Transaction.php';

$id = $_GET['id'] ?? null;

if (!$id) {
    echo json_encode([
        "status" => false,
        "message" => "Transaksi Tidak Ditemukan"
    ]);
    exit;
}

$database = new Database();
$db = $database->getConnection();
$model = new Transaction($db);

$model->id = $id;

if ($model->delete()) {
    echo json_encode([
        "status" => true,
        "message" => "Transaksi Berhasil Dihapus"
    ]);
}else{
    echo json_encode([
        "status" => false,
        "message" => "Transaksi Gagal Dihapus"
    ]);
}
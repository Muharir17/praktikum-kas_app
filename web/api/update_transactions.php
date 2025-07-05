<?php

header("Content-Type: application/json");

require_once '../config/Database.php';
require_once '../models/Transaction.php';

$data = json_decode(file_get_contents("php://input"));

if(!$data || !$data->id){
    echo json_encode([
        "status" => false,
        "message" => "Data Tidak Ditemukan"
    ]);
    exit;
}

$database = new Database();
$db = $database->getConnection();
$model = new Transaction($db);

$model->id = $data->id;
$model->title = $data->title;
$model->amount = $data->amount;
$model->type = $data->type;
$model->description = $data->description ?? null;
$model->date = $data->date;

if($model->update()){
    echo json_encode([
        "status" => true,
        "message" => "Data Berhasil Diubah"
    ]);
}else{
    echo json_encode([
        "status" => false,
        "message" => "Data Gagal Diubah"
    ]);
}
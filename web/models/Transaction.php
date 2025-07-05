<?php

class Transaction {
    private $conn;
    private $table = 'transactions';

    public $id;
    public $title;
    public $amount;
    public $type;
    public $description;
    public $date;

    public function __construct($db) {
        $this->conn = $db;
    }

    public function getAll(){
        $query = "SELECT * FROM " . $this->table . " ORDER BY date DESC";
        $stmt = $this->conn->prepare($query);
        $stmt->execute();
        return $stmt;
    }

    public function show()
    {
        $query = "SELECT * FROM " . $this->table . " WHERE id = ? LIMIT 1";
        $stmt = $this->conn->prepare($query);
        $stmt->bindParam(1, $this->id);
        $stmt->execute();
        return $stmt->fetch(PDO::FETCH_ASSOC);
    }

    public function create() {
        $query = "INSERT INTO " . $this->table . " ( title, amount, type, description, date, created_at, updated_at ) VALUES ( :title, :amount, :type, :description, :date, NOW(), NOW() )";
        $stmt = $this->conn->prepare($query);
       
        return $stmt->execute([
            ':title' => $this->title,
            ':amount' => $this->amount,
            ':type' => $this->type,
            ':description' => $this->description,
            ':date' => $this->date,

        ]);
    }

    public function update() {
        $query = "UPDATE " . $this->table . " SET title = :title, amount = :amount, type = :type, description = :description, date = :date WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([
            ':title' => $this->title,
            ':amount' => $this->amount,
            ':type' => $this->type,
            ':description' => $this->description,
            ':date' => $this->date,
            ':id' => $this->id
        ]);
    }

    public function delete() {
        $query = "DELETE FROM " . $this->table . " WHERE id = :id";
        $stmt = $this->conn->prepare($query);
        return $stmt->execute([
            ':id' => $this->id
        ]);
    }
}
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>API List</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body>
    <div class="max-w-md mx-auto p-4 bg-white rounded-lg shadow-md">
        <h1 class="text-3xl font-bold mb-4">API List</h1>
        <ul class="list-none mb-4">
            <li class="py-2 border-b border-gray-200">
                <a href="api/get_transactions.php" class="text-blue-600 hover:text-blue-800">GET /api/get_transactions.php</a>
            </li>
            <li class="py-2 border-b border-gray-200">
                <a href="api/detail_transactions.php?id=1" class="text-blue-600 hover:text-blue-800">GET /api/detail_transactions.php?id={id}</a>
            </li>
            <li class="py-2 border-b border-gray-200">
                <a href="api/add_transactions.php" class="text-blue-600 hover:text-blue-800">POST /api/add_transactions.php</a>
            </li>
            <li class="py-2 border-b border-gray-200">
                <a href="api/update_transactions.php" class="text-blue-600 hover:text-blue-800">PUT /api/update_transactions.php</a>
            </li>
            <li class="py-2 border-b border-gray-200">
                <a href="api/delete_transactions.php?id=1" class="text-blue-600 hover:text-blue-800">DELETE /api/delete_transactions.php?id={id}</a>
            </li>
        </ul>
    </div>
</body>
</html>
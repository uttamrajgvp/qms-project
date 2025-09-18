<?php
/**
 * Standards API
 * Handles fetching standard details
 */

require_once '../config.php';

// Set JSON header and CORS
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Check authentication
if (!isLoggedIn()) {
    jsonResponse(['success' => false, 'error' => 'Authentication required'], 401);
}

$method = $_SERVER['REQUEST_METHOD'];

if ($method === 'GET') {
    handleGetRequest();
} else {
    jsonResponse(['success' => false, 'error' => 'Method not allowed'], 405);
}

/**
 * Handle GET requests for standards
 * Routes:
 * GET /api/standards.php?id=1 - Get specific standard details
 */
function handleGetRequest() {
    if (!isset($_GET['id'])) {
        jsonResponse(['success' => false, 'error' => 'Standard ID required'], 400);
    }

    $standardId = intval($_GET['id']);
    $db = Database::getInstance()->getConnection();

    try {
        $stmt = $db->prepare("
            SELECT id, source, clause_id, title, description, category
            FROM standards
            WHERE id = ?
        ");
        $stmt->execute([$standardId]);
        $standard = $stmt->fetch();

        if (!$standard) {
            jsonResponse(['success' => false, 'error' => 'Standard not found'], 404);
        }

        jsonResponse([
            'success' => true,
            'data' => $standard
        ]);

    } catch (Exception $e) {
        error_log("Error fetching standard: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}
?>

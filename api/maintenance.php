<?php
/**
 * Maintenance API
 * Handles creation and management of maintenance schedules
 */

require_once '../config.php';

// Set JSON header and CORS
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

if (!isLoggedIn()) {
    jsonResponse(['success' => false, 'error' => 'Authentication required'], 401);
}

$method = $_SERVER['REQUEST_METHOD'];

switch ($method) {
    case 'GET':
        handleGetRequest();
        break;
    case 'POST':
        handlePostRequest();
        break;
    default:
        jsonResponse(['success' => false, 'error' => 'Method not allowed'], 405);
}

/**
 * Handle GET requests for maintenance schedules
 */
function handleGetRequest() {
    if (!hasRole(['superadmin', 'admin', 'auditor', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    $db = Database::getInstance()->getConnection();
    
    try {
        $stmt = $db->prepare("
            SELECT
                ms.id, ms.frequency, ms.next_due, ms.is_active,
                a.name AS asset_name, a.asset_tag, a.location,
                dt.name AS document_type_name
            FROM maintenance_schedules ms
            JOIN assets a ON ms.asset_id = a.id
            JOIN document_types dt ON ms.document_type_id = dt.id
            WHERE ms.is_active = 1
            ORDER BY ms.next_due
        ");
        $stmt->execute();
        $schedules = $stmt->fetchAll();
        
        jsonResponse(['success' => true, 'data' => $schedules]);
    } catch (Exception $e) {
        error_log("Error fetching maintenance schedules: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}

/**
 * Handle POST request to create a new maintenance schedule
 */
function handlePostRequest() {
    if (!hasRole(['superadmin', 'admin', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!$input || !isset($input['asset_id']) || !isset($input['document_type_id']) || !isset($input['frequency'])) {
        jsonResponse(['success' => false, 'error' => 'Required data is missing'], 400);
    }
    
    $assetId = intval($input['asset_id']);
    $documentTypeId = intval($input['document_type_id']);
    $frequency = sanitize($input['frequency']);
    
    // Set next due date based on frequency
    $nextDue = date('Y-m-d', strtotime("+$frequency"));
    
    $db = Database::getInstance()->getConnection();
    
    try {
        $stmt = $db->prepare("
            INSERT INTO maintenance_schedules (asset_id, document_type_id, frequency, next_due, is_active)
            VALUES (?, ?, ?, ?, 1)
        ");
        $stmt->execute([$assetId, $documentTypeId, $frequency, $nextDue]);
        
        logAuditTrail('create_maintenance_schedule', 'maintenance_schedule', $db->lastInsertId());
        
        jsonResponse(['success' => true, 'message' => 'Maintenance schedule created successfully']);
    } catch (Exception $e) {
        error_log("Error creating maintenance schedule: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Failed to create maintenance schedule'], 500);
    }
}
?>

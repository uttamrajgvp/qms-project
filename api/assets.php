<?php
/**
 * Assets API
 * Handles CRUD operations for assets
 */

require_once '../config.php';

// Set JSON header and CORS
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type, Authorization');

// Check authentication
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
    case 'PUT':
        handlePutRequest();
        break;
    case 'DELETE':
        handleDeleteRequest();
        break;
    default:
        jsonResponse(['success' => false, 'error' => 'Method not allowed'], 405);
}

/**
 * Handle GET requests for assets
 */
function handleGetRequest() {
    if (!hasRole(['superadmin', 'admin', 'dept_manager', 'auditor', 'viewer'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    $db = Database::getInstance()->getConnection();
    
    try {
        $sql = "SELECT * FROM assets ORDER BY name";
        $stmt = $db->prepare($sql);
        $stmt->execute();
        $assets = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        jsonResponse(['success' => true, 'data' => $assets]);
    } catch (Exception $e) {
        error_log("Error fetching assets: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}

/**
 * Handle POST request to create a new asset
 */
function handlePostRequest() {
    if (!hasRole(['superadmin', 'admin', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($input['asset_type_id']) || !isset($input['name'])) {
        jsonResponse(['success' => false, 'error' => 'Asset type and name are required'], 400);
    }
    
    $assetTypeId = intval($input['asset_type_id']);
    $name = sanitize($input['name']);
    $assetTag = isset($input['asset_tag']) ? sanitize($input['asset_tag']) : null;
    $model = isset($input['model']) ? sanitize($input['model']) : null;
    $serialNo = isset($input['serial_no']) ? sanitize($input['serial_no']) : null;
    $location = isset($input['location']) ? sanitize($input['location']) : null;
    $vendor = isset($input['vendor']) ? sanitize($input['vendor']) : null;
    $installationDate = isset($input['installation_date']) ? $input['installation_date'] : null;
    $warrantyEnd = isset($input['warranty_end']) ? $input['warranty_end'] : null;
    
    try {
        $db = Database::getInstance()->getConnection();
        $stmt = $db->prepare("
            INSERT INTO assets (asset_type_id, name, asset_tag, model, serial_no, location, vendor, installation_date, warranty_end)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");
        $stmt->execute([$assetTypeId, $name, $assetTag, $model, $serialNo, $location, $vendor, $installationDate, $warrantyEnd]);
        
        logAuditTrail('create_asset', 'asset', $db->lastInsertId(), ['name' => $name, 'asset_tag' => $assetTag]);
        
        jsonResponse(['success' => true, 'message' => 'Asset created successfully', 'id' => $db->lastInsertId()]);
    } catch (Exception $e) {
        error_log("Error creating asset: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Failed to create asset'], 500);
    }
}

/**
 * Handle PUT request to update an asset
 */
function handlePutRequest() {
    if (!hasRole(['superadmin', 'admin', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    if (!isset($input['id'])) {
        jsonResponse(['success' => false, 'error' => 'Asset ID is required'], 400);
    }
    
    $id = intval($input['id']);
    
    try {
        $db = Database::getInstance()->getConnection();
        $fields = [];
        $params = [];
        
        if (isset($input['name'])) {
            $fields[] = "name = ?";
            $params[] = sanitize($input['name']);
        }
        if (isset($input['asset_tag'])) {
            $fields[] = "asset_tag = ?";
            $params[] = sanitize($input['asset_tag']);
        }
        if (isset($input['model'])) {
            $fields[] = "model = ?";
            $params[] = sanitize($input['model']);
        }
        // Add more fields here as needed
        
        if (empty($fields)) {
            jsonResponse(['success' => false, 'error' => 'No fields to update'], 400);
        }
        
        $sql = "UPDATE assets SET " . implode(', ', $fields) . " WHERE id = ?";
        $params[] = $id;
        
        $stmt = $db->prepare($sql);
        $stmt->execute($params);
        
        logAuditTrail('update_asset', 'asset', $id, $input);
        
        jsonResponse(['success' => true, 'message' => 'Asset updated successfully']);
    } catch (Exception $e) {
        error_log("Error updating asset: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Failed to update asset'], 500);
    }
}

/**
 * Handle DELETE request to delete an asset
 */
function handleDeleteRequest() {
    if (!hasRole(['superadmin', 'admin', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    if (!isset($_GET['id'])) {
        jsonResponse(['success' => false, 'error' => 'Asset ID is required'], 400);
    }
    
    $id = intval($_GET['id']);
    
    try {
        $db = Database::getInstance()->getConnection();
        $stmt = $db->prepare("DELETE FROM assets WHERE id = ?");
        $stmt->execute([$id]);
        
        logAuditTrail('delete_asset', 'asset', $id);
        
        jsonResponse(['success' => true, 'message' => 'Asset deleted successfully']);
    } catch (Exception $e) {
        error_log("Error deleting asset: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Failed to delete asset'], 500);
    }
}
?>
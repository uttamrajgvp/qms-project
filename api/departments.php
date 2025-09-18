<?php
/**
 * Departments API
 * Handles department listing, asset types, and document types
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
$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$uriParts = explode('/', trim($uri, '/'));

switch ($method) {
    case 'GET':
        handleGetRequest($uriParts);
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
 * Handle GET requests for departments and related data
 * * Routes:
 * GET /api/departments.php - List all departments
 * GET /api/departments.php?id=1&asset_types=1 - Get asset types for department
 * GET /api/departments.php?asset_type_id=1&document_types=1 - Get document types for asset type
 */
function handleGetRequest($uriParts) {
    $db = Database::getInstance()->getConnection();
    
    // Get asset types for a specific department
    if (isset($_GET['id']) && isset($_GET['asset_types'])) {
        $deptId = intval($_GET['id']);
        
        if (!$deptId) {
            jsonResponse(['success' => false, 'error' => 'Invalid department ID'], 400);
        }
        
        try {
            $stmt = $db->prepare("
                SELECT id, name, description
                FROM asset_types 
                WHERE department_id = ?
                ORDER BY name
            ");
            $stmt->execute([$deptId]);
            $assetTypes = $stmt->fetchAll();
            
            jsonResponse([
                'success' => true,
                'data' => $assetTypes
            ]);
            
        } catch (Exception $e) {
            error_log("Error fetching asset types: " . $e->getMessage());
            jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
        }
        
        return;
    }
    
    // Get document types for a specific asset type
    if (isset($_GET['asset_type_id']) && isset($_GET['document_types'])) {
        try {
            // Get all document types (they're shared across asset types)
            $stmt = $db->prepare("
                SELECT id, name, description, requires_signature, validity_days
                FROM document_types
                ORDER BY name
            ");
            $stmt->execute();
            $documentTypes = $stmt->fetchAll();
            
            jsonResponse([
                'success' => true,
                'data' => $documentTypes
            ]);
            
        } catch (Exception $e) {
            error_log("Error fetching document types: " . $e->getMessage());
            jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
        }
        
        return;
    }
    
    // Default: List all departments
    try {
        $stmt = $db->prepare("
            SELECT d.id, d.name, d.description, 
                   u.name as head_name,
                   COUNT(at.id) as asset_types_count
            FROM departments d
            LEFT JOIN users u ON d.head_user_id = u.id
            LEFT JOIN asset_types at ON d.id = at.department_id
            GROUP BY d.id, d.name, d.description, u.name
            ORDER BY d.name
        ");
        $stmt->execute();
        $departments = $stmt->fetchAll();
        
        jsonResponse([
            'success' => true,
            'data' => $departments
        ]);
        
    } catch (Exception $e) {
        error_log("Error fetching departments: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}

/**
 * Handle POST request to create a new department or asset type
 */
function handlePostRequest() {
    if (!hasRole(['superadmin', 'admin'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }

    $input = json_decode(file_get_contents('php://input'), true);

    if (isset($input['department_name'])) {
        // Create new department
        $name = sanitize($input['department_name']);
        $description = isset($input['description']) ? sanitize($input['description']) : null;
        try {
            $db = Database::getInstance()->getConnection();
            $stmt = $db->prepare("INSERT INTO departments (name, description) VALUES (?, ?)");
            $stmt->execute([$name, $description]);
            jsonResponse(['success' => true, 'message' => 'Department created successfully', 'id' => $db->lastInsertId()]);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to create department'], 500);
        }
    } elseif (isset($input['asset_type_name']) && isset($input['department_id'])) {
        // Create new asset type
        $name = sanitize($input['asset_type_name']);
        $departmentId = intval($input['department_id']);
        $description = isset($input['description']) ? sanitize($input['description']) : null;
        try {
            $db = Database::getInstance()->getConnection();
            $stmt = $db->prepare("INSERT INTO asset_types (department_id, name, description) VALUES (?, ?, ?)");
            $stmt->execute([$departmentId, $name, $description]);
            jsonResponse(['success' => true, 'message' => 'Asset type created successfully', 'id' => $db->lastInsertId()]);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to create asset type'], 500);
        }
    } else {
        jsonResponse(['success' => false, 'error' => 'Invalid request body'], 400);
    }
}

/**
 * Handle PUT request to update a department or asset type
 */
function handlePutRequest() {
    if (!hasRole(['superadmin', 'admin'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }

    $input = json_decode(file_get_contents('php://input'), true);
    $db = Database::getInstance()->getConnection();

    if (isset($input['department_id'])) {
        // Update department
        $id = intval($input['department_id']);
        $name = isset($input['name']) ? sanitize($input['name']) : null;
        $description = isset($input['description']) ? sanitize($input['description']) : null;
        try {
            $stmt = $db->prepare("UPDATE departments SET name = COALESCE(?, name), description = COALESCE(?, description) WHERE id = ?");
            $stmt->execute([$name, $description, $id]);
            jsonResponse(['success' => true, 'message' => 'Department updated successfully']);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to update department'], 500);
        }
    } elseif (isset($input['asset_type_id'])) {
        // Update asset type
        $id = intval($input['asset_type_id']);
        $name = isset($input['name']) ? sanitize($input['name']) : null;
        $description = isset($input['description']) ? sanitize($input['description']) : null;
        try {
            $stmt = $db->prepare("UPDATE asset_types SET name = COALESCE(?, name), description = COALESCE(?, description) WHERE id = ?");
            $stmt->execute([$name, $description, $id]);
            jsonResponse(['success' => true, 'message' => 'Asset type updated successfully']);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to update asset type'], 500);
        }
    } else {
        jsonResponse(['success' => false, 'error' => 'Invalid request body'], 400);
    }
}

/**
 * Handle DELETE request to delete a department or asset type
 */
function handleDeleteRequest() {
    if (!hasRole(['superadmin', 'admin'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }
    
    $db = Database::getInstance()->getConnection();
    
    if (isset($_GET['department_id'])) {
        // Delete department
        $id = intval($_GET['department_id']);
        try {
            $stmt = $db->prepare("DELETE FROM departments WHERE id = ?");
            $stmt->execute([$id]);
            jsonResponse(['success' => true, 'message' => 'Department deleted successfully']);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to delete department'], 500);
        }
    } elseif (isset($_GET['asset_type_id'])) {
        // Delete asset type
        $id = intval($_GET['asset_type_id']);
        try {
            $stmt = $db->prepare("DELETE FROM asset_types WHERE id = ?");
            $stmt->execute([$id]);
            jsonResponse(['success' => true, 'message' => 'Asset type deleted successfully']);
        } catch (Exception $e) {
            jsonResponse(['success' => false, 'error' => 'Failed to delete asset type'], 500);
        }
    } else {
        jsonResponse(['success' => false, 'error' => 'Invalid request'], 400);
    }
}
?>
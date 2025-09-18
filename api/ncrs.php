<?php
/**
 * Non-Conformance Reports (NCRs) API
 * Handles fetching and updating NCRs
 */

require_once '../config.php';

// Set JSON header and CORS
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, PUT');
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
    case 'PUT':
        handlePutRequest();
        break;
    default:
        jsonResponse(['success' => false, 'error' => 'Method not allowed'], 405);
}

/**
 * Handle GET requests for NCRs
 * Routes:
 * GET /api/ncrs.php - Get all NCRs
 */
function handleGetRequest() {
    // Only admins, auditors, and department managers can view all NCRs
    if (!hasRole(['superadmin', 'admin', 'auditor', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }

    $db = Database::getInstance()->getConnection();

    try {
        $stmt = $db->prepare("
            SELECT
                n.id, n.ncr_number, n.description, n.root_cause, n.corrective_action, n.preventive_action,
                n.status, n.severity, n.due_date, n.created_at,
                ci.question AS checklist_question,
                a.name AS asset_name,
                d.name AS department_name,
                u1.name AS raised_by_name,
                u2.name AS assigned_to_name
            FROM ncrs n
            JOIN checklist_items ci ON n.checklist_item_id = ci.id
            JOIN assets a ON n.asset_id = a.id
            JOIN departments d ON n.department_id = d.id
            JOIN users u1 ON n.raised_by = u1.id
            LEFT JOIN users u2 ON n.assigned_to = u2.id
            ORDER BY n.created_at DESC
        ");
        $stmt->execute();
        $ncrs = $stmt->fetchAll();

        jsonResponse([
            'success' => true,
            'data' => $ncrs
        ]);

    } catch (Exception $e) {
        error_log("Error fetching NCRs: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}

/**
 * Handle PUT requests to update an NCR
 * Body: {status: string, assigned_to: int, root_cause: string, corrective_action: string}
 */
function handlePutRequest() {
    if (!hasRole(['superadmin', 'admin', 'auditor', 'dept_manager'])) {
        jsonResponse(['success' => false, 'error' => 'Insufficient permissions'], 403);
    }

    $input = json_decode(file_get_contents('php://input'), true);

    if (!isset($input['id'])) {
        jsonResponse(['success' => false, 'error' => 'NCR ID required'], 400);
    }

    $ncrId = intval($input['id']);
    $updateFields = [];
    $updateParams = [];

    if (isset($input['status'])) {
        $updateFields[] = 'status = ?';
        $updateParams[] = sanitize($input['status']);
    }
    if (isset($input['assigned_to'])) {
        $updateFields[] = 'assigned_to = ?';
        $updateParams[] = intval($input['assigned_to']);
    }
    if (isset($input['root_cause'])) {
        $updateFields[] = 'root_cause = ?';
        $updateParams[] = sanitize($input['root_cause']);
    }
    if (isset($input['corrective_action'])) {
        $updateFields[] = 'corrective_action = ?';
        $updateParams[] = sanitize($input['corrective_action']);
    }

    if (empty($updateFields)) {
        jsonResponse(['success' => false, 'error' => 'No fields to update'], 400);
    }

    $updateFields[] = 'updated_at = NOW()';
    $updateParams[] = $ncrId;

    $db = Database::getInstance()->getConnection();
    $sql = "UPDATE ncrs SET " . implode(', ', $updateFields) . " WHERE id = ?";

    try {
        $stmt = $db->prepare($sql);
        $stmt->execute($updateParams);

        if ($stmt->rowCount() > 0) {
            logAuditTrail('update_ncr', 'ncr', $ncrId, ['updates' => $input]);
            jsonResponse(['success' => true, 'message' => 'NCR updated successfully']);
        } else {
            jsonResponse(['success' => false, 'error' => 'NCR not found or no changes made'], 404);
        }
    } catch (Exception $e) {
        error_log("Error updating NCR: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Failed to update NCR'], 500);
    }
}
?>

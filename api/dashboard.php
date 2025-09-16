<?php
/**
 * Dashboard API
 * Fetches real-time dashboard metrics from the database
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
    handleGetDashboardMetrics();
} else {
    jsonResponse(['success' => false, 'error' => 'Method not allowed'], 405);
}

/**
 * Handle GET request for dashboard metrics
 */
function handleGetDashboardMetrics() {
    $db = Database::getInstance()->getConnection();
    
    try {
        // Total Pending Checklists
        $stmt = $db->prepare("SELECT COUNT(*) FROM checklists WHERE status IN ('draft', 'in_progress')");
        $stmt->execute();
        $pendingChecklists = $stmt->fetchColumn();

        // Total Overdue PMs (simplified logic for demonstration)
        $stmt = $db->prepare("SELECT COUNT(*) FROM maintenance_schedules WHERE next_due < CURDATE() AND is_active = 1");
        $stmt->execute();
        $overduePMs = $stmt->fetchColumn();

        // Total Open NCRs
        $stmt = $db->prepare("SELECT COUNT(*) FROM ncrs WHERE status IN ('open', 'in_progress', 'verified')");
        $stmt->execute();
        $openNCRs = $stmt->fetchColumn();
        
        // Overall Compliance Rate
        $stmt = $db->prepare("
            SELECT 
                (SUM(CASE WHEN ci.result = 'pass' THEN 1 ELSE 0 END) * 100.0) / 
                NULLIF(COUNT(ci.id), 0) AS compliance_rate
            FROM checklist_items ci
            JOIN checklists c ON ci.checklist_id = c.id
            WHERE c.status IN ('completed', 'signed_off')
        ");
        $stmt->execute();
        $complianceRate = $stmt->fetchColumn();
        $complianceRate = $complianceRate ? round($complianceRate, 2) : 0;
        
        jsonResponse([
            'success' => true,
            'data' => [
                'pendingChecklists' => $pendingChecklists,
                'overduePMs' => $overduePMs,
                'openNCRs' => $openNCRs,
                'complianceRate' => $complianceRate . '%'
            ]
        ]);
        
    } catch (Exception $e) {
        error_log("Dashboard API Error: " . $e->getMessage());
        jsonResponse(['success' => false, 'error' => 'Internal server error'], 500);
    }
}
?>

/**
 * QuailtyMed Main Application
 * Handles UI interactions, navigation, and business logic
 * Implements department cascade navigation and checklist management
 */

class QuailtyMedApp {
    constructor() {
        this.currentView = 'dashboard';
        this.selectedDepartment = null;
        this.selectedAssetType = null;
        this.selectedDocumentType = null;
        this.selectedAsset = null;
        this.currentChecklist = null;
        this.uploadItemId = null;
        
        // Theme state
        this.theme = localStorage.getItem('theme') || 'light';
        
        // E-signature
        this.signaturePad = null;
        
        // Charts
        this.complianceChart = null;
        this.standardsChart = null;

        // Bind methods to maintain context
        this.handleLogin = this.handleLogin.bind(this);
        this.handleLogout = this.handleLogout.bind(this);
        this.loadDepartments = this.loadDepartments.bind(this);
        this.selectDepartment = this.selectDepartment.bind(this);
        this.selectAssetType = this.selectAssetType.bind(this);
        this.selectDocumentType = this.selectDocumentType.bind(this);
        this.showAssets = this.showAssets.bind(this);
        this.selectAsset = this.selectAsset.bind(this);
        this.saveChecklist = this.saveChecklist.bind(this);
        this.toggleTheme = this.toggleTheme.bind(this);
        this.showReports = this.showReports.bind(this);
        this.showNCRs = this.showNCRs.bind(this);
        this.updateNCR = this.updateNCR.bind(this);
        this.schedulePM = this.schedulePM.bind(this);
    }

    /**
     * Initialize the application
     */
    async init() {
        try {
            console.log('Initializing QuailtyMed...');
            
            // Set initial theme
            this.setTheme(this.theme);
            
            // Register service worker for offline support
            if ('serviceWorker' in navigator) {
                navigator.serviceWorker.register('sw.js')
                    .then(reg => console.log('Service Worker registered', reg))
                    .catch(err => console.error('Service Worker registration failed', err));
            }
            
            // Check if user is already logged in
            const user = await api.getCurrentUser();
            if (user) {
                this.showApp(user);
            } else {
                this.showLogin();
            }
            
            this.bindEvents();
            
        } catch (error) {
            console.error('Failed to initialize app:', error);
            this.showLogin();
        } finally {
            this.hideLoading();
        }
    }

    /**
     * Bind UI event handlers
     */
    bindEvents() {
        // Login form
        const loginForm = document.getElementById('loginForm');
        if (loginForm) {
            loginForm.addEventListener('submit', this.handleLogin);
        }

        // Logout button
        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', this.handleLogout);
        }
        
        // Day/Night mode toggle
        const themeToggleBtn = document.getElementById('themeToggle');
        if (themeToggleBtn) {
            themeToggleBtn.addEventListener('click', this.toggleTheme);
        }

        // Menu toggle for mobile
        const menuToggle = document.getElementById('menuToggle');
        const sidebar = document.getElementById('sidebar');
        if (menuToggle && sidebar) {
            menuToggle.addEventListener('click', () => {
                sidebar.classList.toggle('show');
            });
        }

        // Refresh departments button
        const refreshBtn = document.getElementById('refreshDepartments');
        if (refreshBtn) {
            refreshBtn.addEventListener('click', this.loadDepartments);
        }

        // Back navigation buttons
        document.getElementById('backToDepartments')?.addEventListener('click', () => {
            this.showView('dashboard');
            this.clearDepartmentSelection();
        });

        document.getElementById('backToAssetTypes')?.addEventListener('click', () => {
            this.showAssetTypes(this.selectedDepartment);
        });

        document.getElementById('backToDocumentTypes')?.addEventListener('click', () => {
            this.showDocumentTypes(this.selectedAssetType);
        });

        document.getElementById('backToAssets')?.addEventListener('click', () => {
            this.showAssets(this.selectedDocumentType);
        });
        
        // Save Checklist Button
        document.getElementById('saveChecklistBtn')?.addEventListener('click', this.saveChecklist);
        
        // New quick action buttons
        document.getElementById('createChecklistBtn')?.addEventListener('click', () => {
            this.showView('departments');
        });
        document.getElementById('showReportsBtn')?.addEventListener('click', this.showReports);
        document.getElementById('showNCRsBtn')?.addEventListener('click', this.showNCRs);
        document.getElementById('schedulePMBtn')?.addEventListener('click', () => {
            this.showModal(document.getElementById('pmScheduleModal'));
        });

        // E-Signature
        document.getElementById('signoffBtn')?.addEventListener('click', () => {
            this.showModal(document.getElementById('eSignatureModal'));
        });
        document.getElementById('signoffSaveBtn')?.addEventListener('click', () => {
            this.signOffChecklist();
        });
        document.getElementById('signoffClearBtn')?.addEventListener('click', () => {
            this.signaturePad.clear();
        });
        
        // PM Schedule
        document.getElementById('schedulePMForm')?.addEventListener('submit', (e) => {
            e.preventDefault();
            this.schedulePM();
        });

        // Modal close handlers
        document.querySelectorAll('.modal-close').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const modal = e.target.closest('.modal');
                if (modal) {
                    this.hideModal(modal);
                }
            });
        });

        // Click outside modal to close
        document.querySelectorAll('.modal').forEach(modal => {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    this.hideModal(modal);
                }
            });
        });

        // File upload form
        const uploadForm = document.getElementById('uploadForm');
        if (uploadForm) {
            uploadForm.addEventListener('submit', this.handleFileUpload.bind(this));
        }

        // Keyboard navigation
        document.addEventListener('keydown', this.handleKeyboard.bind(this));
    }
    
    /**
     * Set the application theme
     * @param {string} theme 'light' or 'dark'
     */
    setTheme(theme) {
        document.body.classList.remove('light-mode', 'dark-mode');
        document.body.classList.add(theme + '-mode');
        localStorage.setItem('theme', theme);
        this.theme = theme;
        
        const themeToggleBtn = document.getElementById('themeToggle');
        if (themeToggleBtn) {
            if (theme === 'dark') {
                themeToggleBtn.innerHTML = '☀️ Day Mode';
            } else {
                themeToggleBtn.innerHTML = '🌙 Night Mode';
            }
        }
    }
    
    /**
     * Toggle between Day and Night mode
     */
    toggleTheme() {
        const newTheme = this.theme === 'dark' ? 'light' : 'dark';
        this.setTheme(newTheme);
    }

    /**
     * Handle login form submission
     * @param {Event} e Form submit event
     */
    async handleLogin(e) {
        e.preventDefault();
        
        const form = e.target;
        const email = form.email.value.trim();
        const password = form.password.value;
        const submitBtn = form.querySelector('button[type="submit"]');
        const errorDiv = document.getElementById('loginError');
        
        // Reset error state
        errorDiv.style.display = 'none';
        
        // Show loading state
        submitBtn.querySelector('.btn-text').style.display = 'none';
        submitBtn.querySelector('.btn-loading').style.display = 'inline';
        submitBtn.disabled = true;

        try {
            const response = await api.login(email, password);
            if (response.success) {
                api.showToast('Login successful', 'success');
                this.showApp(response.data);
            } else {
                throw new Error(response.error || 'Login failed');
            }
        } catch (error) {
            console.error('Login error:', error);
            errorDiv.textContent = error.message;
            errorDiv.style.display = 'block';
            api.showToast(error.message, 'error');
        } finally {
            // Reset button state
            submitBtn.querySelector('.btn-text').style.display = 'inline';
            submitBtn.querySelector('.btn-loading').style.display = 'none';
            submitBtn.disabled = false;
        }
    }

    /**
     * Handle logout
     */
    async handleLogout() {
        try {
            await api.logout();
            api.showToast('Logged out successfully', 'info');
            this.showLogin();
        } catch (error) {
            console.error('Logout error:', error);
            // Force logout even if API call fails
            this.showLogin();
        }
    }

    /**
     * Show the login screen
     */
    showLogin() {
        document.getElementById('loginScreen').style.display = 'flex';
        document.getElementById('appContainer').style.display = 'none';
        
        // Focus on email input
        const emailInput = document.getElementById('email');
        if (emailInput) {
            setTimeout(() => emailInput.focus(), 100);
        }
    }

    /**
     * Show the main application
     * @param {Object} user Current user data
     */
    async showApp(user) {
        // Update UI with user info
        document.getElementById('userName').textContent = user.name;
        document.getElementById('userRole').textContent = user.role;
        
        // Show app container
        document.getElementById('loginScreen').style.display = 'none';
        document.getElementById('appContainer').style.display = 'flex';
        
        // Load initial data
        await this.loadDepartments();
        await this.loadDashboardData();
        
        // Show dashboard by default
        this.showView('dashboard');
    }

    /**
     * Hide loading overlay
     */
    hideLoading() {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.style.display = 'none';
        }
    }

    /**
     * Show specific view
     * @param {string} viewName Name of the view to show
     */
    showView(viewName) {
        // Hide all views
        document.querySelectorAll('.view-container').forEach(view => {
            view.classList.remove('active');
        });
        
        // Show requested view
        const targetView = document.getElementById(viewName + 'View');
        if (targetView) {
            targetView.classList.add('active');
            this.currentView = viewName;
        }
        
        // Close mobile menu
        document.getElementById('sidebar')?.classList.remove('show');
    }

    /**
     * Load departments list
     */
    async loadDepartments() {
        try {
            const departments = await api.getDepartments();
            this.renderDepartments(departments);
        } catch (error) {
            console.error('Failed to load departments:', error);
            api.showToast('Failed to load departments', 'error');
        }
    }

    /**
     * Render departments in sidebar
     * @param {Array} departments List of departments
     */
    renderDepartments(departments) {
        const container = document.getElementById('departmentsList');
        if (!container) return;
        
        container.innerHTML = '';
        
        departments.forEach(dept => {
            const item = document.createElement('div');
            item.className = 'department-item';
            item.setAttribute('data-department-id', dept.id);
            item.innerHTML = `
                <div class="item-name">${api.sanitizeHTML(dept.name)}</div>
                <div class="item-description">${api.sanitizeHTML(dept.description || '')}</div>
            `;
            
            item.addEventListener('click', () => this.selectDepartment(dept));
            container.appendChild(item);
        });
    }

    /**
     * Handle department selection
     * @param {Object} department Selected department
     */
    async selectDepartment(department) {
        this.selectedDepartment = department;
        this.selectedAssetType = null;
        this.selectedDocumentType = null;
        this.selectedAsset = null;
        
        // Update UI selection state
        this.updateDepartmentSelection(department.id);
        
        // Load and show asset types
        await this.showAssetTypes(department);
    }

    /**
     * Update department selection UI
     * @param {number} departmentId Selected department ID
     */
    updateDepartmentSelection(departmentId) {
        document.querySelectorAll('.department-item').forEach(item => {
            item.classList.remove('active');
        });
        
        const selectedItem = document.querySelector(`[data-department-id="${departmentId}"]`);
        if (selectedItem) {
            selectedItem.classList.add('active');
        }
    }

    /**
     * Show asset types for department
     * @param {Object} department Department object
     */
    async showAssetTypes(department) {
        try {
            const assetTypes = await api.getAssetTypes(department.id);
            
            document.getElementById('assetTypesTitle').textContent = 
                `Asset Types - ${department.name}`;
            
            this.renderAssetTypes(assetTypes);
            this.showView('assetTypes');
            
        } catch (error) {
            console.error('Failed to load asset types:', error);
            api.showToast('Failed to load asset types', 'error');
        }
    }

    /**
     * Render asset types list
     * @param {Array} assetTypes List of asset types
     */
    renderAssetTypes(assetTypes) {
        const container = document.getElementById('assetTypesList');
        if (!container) return;
        
        container.innerHTML = '';
        
        if (assetTypes.length === 0) {
            container.innerHTML = '<p>No asset types found for this department.</p>';
            return;
        }
        
        assetTypes.forEach(assetType => {
            const item = document.createElement('div');
            item.className = 'asset-type-item';
            item.innerHTML = `
                <div class="item-name">${api.sanitizeHTML(assetType.name)}</div>
                <div class="item-description">${api.sanitizeHTML(assetType.description || '')}</div>
            `;
            
            item.addEventListener('click', () => this.selectAssetType(assetType));
            container.appendChild(item);
        });
    }

    /**
     * Handle asset type selection
     * @param {Object} assetType Selected asset type
     */
    async selectAssetType(assetType) {
        this.selectedAssetType = assetType;
        this.selectedDocumentType = null;
        this.selectedAsset = null;
        
        await this.showDocumentTypes(assetType);
    }

    /**
     * Show document types for asset type
     * @param {Object} assetType Asset type object
     */
    async showDocumentTypes(assetType) {
        try {
            const documentTypes = await api.getDocumentTypes(assetType.id);
            
            document.getElementById('documentTypesTitle').textContent = 
                `Document Types - ${assetType.name}`;
            
            this.renderDocumentTypes(documentTypes);
            this.showView('documentTypes');
            
        } catch (error) {
            console.error('Failed to load document types:', error);
            api.showToast('Failed to load document types', 'error');
        }
    }

    /**
     * Render document types list
     * @param {Array} documentTypes List of document types
     */
    renderDocumentTypes(documentTypes) {
        const container = document.getElementById('documentTypesList');
        if (!container) return;
        
        container.innerHTML = '';
        
        documentTypes.forEach(docType => {
            const item = document.createElement('div');
            item.className = 'document-type-item';
            item.innerHTML = `
                <div class="item-name">${api.sanitizeHTML(docType.name)}</div>
                <div class="item-description">${api.sanitizeHTML(docType.description || '')}</div>
            `;
            
            item.addEventListener('click', () => this.selectDocumentType(docType));
            container.appendChild(item);
        });
    }

    /**
     * Handle document type selection
     * @param {Object} documentType Selected document type
     */
    async selectDocumentType(documentType) {
        this.selectedDocumentType = documentType;
        
        // Show assets for the selected asset type
        await this.showAssets(this.selectedAssetType);
    }

    /**
     * Show assets for the selected asset type and document type
     * @param {Object} assetType Selected asset type
     */
    async showAssets(assetType) {
        try {
            const assets = await api.getAssetsByAssetType(assetType.id);
            
            document.getElementById('assetsTitle').textContent = 
                `Select Asset - ${this.selectedDocumentType.name}`;
                
            this.renderAssets(assets);
            this.showView('assets');
            
        } catch (error) {
            console.error('Failed to load assets:', error);
            api.showToast('Failed to load assets', 'error');
        }
    }
    
    /**
     * Render assets list
     * @param {Array} assets List of assets
     */
    renderAssets(assets) {
        const container = document.getElementById('assetsList');
        if (!container) return;
        
        container.innerHTML = '';
        
        if (assets.length === 0) {
            container.innerHTML = '<p>No assets found for this asset type.</p>';
            return;
        }
        
        assets.forEach(asset => {
            const item = document.createElement('div');
            item.className = 'asset-item';
            item.innerHTML = `
                <div class="item-name">${api.sanitizeHTML(asset.name)}</div>
                <div class="item-description">Tag: ${api.sanitizeHTML(asset.asset_tag)} | Location: ${api.sanitizeHTML(asset.location)}</div>
            `;
            
            item.addEventListener('click', () => this.selectAsset(asset));
            container.appendChild(item);
        });
    }
    
    /**
     * Handle asset selection
     * @param {Object} asset Selected asset
     */
    async selectAsset(asset) {
        this.selectedAsset = asset;
        await this.createNewChecklist();
    }

    /**
     * Create a new checklist
     */
    async createNewChecklist() {
        try {
            // Fetch checklist items dynamically from the database
            const defaultItems = await api.getChecklistItemsByDocumentType(this.selectedDocumentType.id);

            const checklistData = {
                asset_id: this.selectedAsset.id,
                document_type_id: this.selectedDocumentType.id,
                checklist_name: `${this.selectedDocumentType.name} - ${new Date().toLocaleDateString()}`,
                items: defaultItems
            };
            
            const response = await api.createChecklist(checklistData);
            if (response.success) {
                api.showToast('Checklist created successfully', 'success');
                await this.loadChecklist(response.data.checklist_id);
            }
            
        } catch (error) {
            console.error('Failed to create checklist:', error);
            api.showToast('Failed to create checklist', 'error');
        }
    }

    /**
     * Load and display a checklist
     * @param {number} checklistId Checklist ID
     */
    async loadChecklist(checklistId) {
        try {
            const checklist = await api.getChecklistById(checklistId);
            this.currentChecklist = checklist;
            
            // Update checklist header
            document.getElementById('checklistTitle').textContent = 
                checklist.checklist_name || checklist.document_type_name;
            document.getElementById('checklistInfo').textContent = 
                `Asset: ${checklist.asset_name} (${checklist.asset_tag}) | Location: ${checklist.location}`;
            
            this.renderChecklistItems(checklist.items);
            this.showView('checklist');
            
        } catch (error) {
            console.error('Failed to load checklist:', error);
            api.showToast('Failed to load checklist', 'error');
        }
    }

    /**
     * Render checklist items
     * @param {Array} items Checklist items
     */
    renderChecklistItems(items) {
        const container = document.getElementById('checklistContainer');
        if (!container) return;
        
        container.innerHTML = '';
        
        items.forEach(item => {
            const itemDiv = document.createElement('div');
            itemDiv.className = 'checklist-item';
            itemDiv.setAttribute('data-item-id', item.id);
            itemDiv.innerHTML = this.createChecklistItemHTML(item);
            container.appendChild(itemDiv);
            
            // Bind events for this item
            this.bindChecklistItemEvents(itemDiv, item);
        });

        // Add the signoff button if the checklist is completed
        const signoffContainer = document.getElementById('signoffContainer');
        if (this.currentChecklist.status === 'completed' && signoffContainer) {
            signoffContainer.style.display = 'block';
        } else {
            signoffContainer.style.display = 'none';
        }

        // If signed off, display the signature
        const signatureDisplay = document.getElementById('signatureDisplay');
        if (this.currentChecklist.status === 'signed_off' && signatureDisplay) {
            signatureDisplay.innerHTML = `
                <div class="signed-off-badge">✅ Signed Off by ${api.sanitizeHTML(this.currentChecklist.signed_off_by_name)} on ${api.formatDate(this.currentChecklist.signed_off_at)}</div>
                <img src="${this.currentChecklist.signature_image}" alt="Digital Signature" class="signature-image"/>
            `;
        } else {
            signatureDisplay.innerHTML = '';
        }
    }

    /**
     * Create HTML for checklist item
     * @param {Object} item Checklist item data
     * @returns {string} HTML string
     */
    createChecklistItemHTML(item) {
        const standardBadge = item.standard_id ? `
            <div class="standard-reference">
                <span class="standard-badge" data-standard-id="${item.standard_id}" 
                      title="Click to view standard details">
                    ${item.standard_source} ${item.clause_id}
                </span>
                <span>${api.sanitizeHTML(item.standard_title || '')}</span>
            </div>
        ` : '';

        const resultClass = item.result || 'pending';
        const remarksValue = api.sanitizeHTML(item.remarks || '');
        const attachmentInfo = item.attached_file ? `
            <div class="attachment-info">
                <a href="${item.attached_file}" target="_blank">📎 Evidence Attached</a>
            </div>
        ` : '';

        // Disable controls if signed off
        const disabled = this.currentChecklist.status === 'signed_off' ? 'disabled' : '';

        return `
            <div class="checklist-question">
                ${api.sanitizeHTML(item.question)}
            </div>
            
            ${standardBadge}
            
            <div class="checklist-controls">
                <div class="result-options">
                    <button class="result-option pass ${resultClass === 'pass' ? 'active' : ''}" 
                            data-result="pass" data-item-id="${item.id}" ${disabled}>✓ Pass</button>
                    <button class="result-option fail ${resultClass === 'fail' ? 'active' : ''}" 
                            data-result="fail" data-item-id="${item.id}" ${disabled}>✗ Fail</button>
                    <button class="result-option na ${resultClass === 'na' ? 'active' : ''}" 
                            data-result="na" data-item-id="${item.id}" ${disabled}>N/A</button>
                </div>
            </div>
            
            <div class="remarks-section">
                <textarea class="remarks-input" placeholder="Add remarks..." 
                          data-item-id="${item.id}" ${disabled}>${remarksValue}</textarea>
            </div>
            
            <div class="upload-evidence">
                <button class="upload-btn" data-item-id="${item.id}" ${disabled}>
                    📎 Upload Evidence
                </button>
                ${attachmentInfo}
            </div>
        `;
    }

    /**
     * Bind events for checklist item
     * @param {Element} itemDiv Item container element
     * @param {Object} item Item data
     */
    bindChecklistItemEvents(itemDiv, item) {
        // Result option buttons
        itemDiv.querySelectorAll('.result-option').forEach(btn => {
            btn.addEventListener('click', () => {
                this.handleResultSelection(itemDiv, item.id, btn.dataset.result);
            });
        });

        // Standard badge click
        const standardBadge = itemDiv.querySelector('.standard-badge');
        if (standardBadge) {
            standardBadge.addEventListener('click', () => {
                this.showStandardModal(item.standard_id);
            });
        }

        // Remarks input
        const remarksInput = itemDiv.querySelector('.remarks-input');
        if (remarksInput) {
            // No need for debounced save here as a single save button is added
        }

        // Upload button
        const uploadBtn = itemDiv.querySelector('.upload-btn');
        if (uploadBtn) {
            uploadBtn.addEventListener('click', () => {
                this.showUploadModal(item.id);
            });
        }
    }
    
    /**
     * Save the entire checklist
     */
    async saveChecklist() {
        if (!this.currentChecklist) {
            api.showToast('No checklist to save', 'error');
            return;
        }

        // Gather all checklist item data from the DOM
        const checklistItems = [];
        const itemElements = document.querySelectorAll('.checklist-item');
        itemElements.forEach(itemEl => {
            const itemId = itemEl.getAttribute('data-item-id');
            const result = itemEl.querySelector('.result-option.active')?.dataset.result || 'pending';
            const remarks = itemEl.querySelector('.remarks-input')?.value || '';
            const attachedFile = itemEl.querySelector('.attachment-info a')?.getAttribute('href') || null;

            checklistItems.push({
                id: parseInt(itemId),
                result: result,
                remarks: remarks,
                attached_file: attachedFile
            });
        });

        const saveBtn = document.getElementById('saveChecklistBtn');
        saveBtn.disabled = true;
        saveBtn.textContent = 'Saving...';
        
        try {
            const response = await api.saveChecklist({
                checklist_id: this.currentChecklist.id,
                items: checklistItems
            });

            if (response.success) {
                api.showToast('Checklist saved successfully!', 'success');
            } else {
                api.showToast(response.error || 'Failed to save checklist.', 'error');
            }
        } catch (error) {
            console.error('Failed to save checklist:', error);
            api.showToast('Failed to save checklist.', 'error');
        } finally {
            saveBtn.disabled = false;
            saveBtn.textContent = 'Save Checklist';
            // Reload the checklist to update its status and refresh the data
            this.loadChecklist(this.currentChecklist.id);
        }
    }
    
    /**
     * Handle checklist sign-off
     */
    async signOffChecklist() {
        if (!this.signaturePad || this.signaturePad.isEmpty()) {
            api.showToast('Please provide a signature.', 'error');
            return;
        }

        const signatureImage = this.signaturePad.toDataURL(); // Get signature as base64
        const signoffBtn = document.getElementById('signoffSaveBtn');
        signoffBtn.disabled = true;
        signoffBtn.textContent = 'Signing...';

        try {
            const response = await api.signOffChecklist(this.currentChecklist.id, signatureImage);
            if (response.success) {
                api.showToast('Checklist signed off successfully!', 'success');
                this.hideModal(document.getElementById('eSignatureModal'));
                await this.loadChecklist(this.currentChecklist.id); // Reload to show signature
            } else {
                api.showToast(response.error || 'Failed to sign off checklist.', 'error');
            }
        } catch (error) {
            console.error('Sign off failed:', error);
            api.showToast('Failed to sign off checklist.', 'error');
        } finally {
            signoffBtn.disabled = false;
            signoffBtn.textContent = 'Save Signature';
        }
    }
    
    /**
     * Handle PM scheduling
     */
    async schedulePM() {
        const form = document.getElementById('pmScheduleForm');
        const frequency = form.querySelector('#pmFrequency').value;

        if (!this.selectedAsset || !this.selectedDocumentType || !frequency) {
            api.showToast('Please select an asset, document type, and frequency.', 'error');
            return;
        }
        
        const scheduleData = {
            asset_id: this.selectedAsset.id,
            document_type_id: this.selectedDocumentType.id,
            frequency: frequency
        };

        const submitBtn = form.querySelector('button[type="submit"]');
        submitBtn.disabled = true;
        submitBtn.textContent = 'Scheduling...';

        try {
            const response = await api.scheduleMaintenance(scheduleData);
            if (response.success) {
                api.showToast('Maintenance scheduled successfully!', 'success');
                this.hideModal(document.getElementById('pmScheduleModal'));
            } else {
                api.showToast(response.error || 'Failed to schedule maintenance.', 'error');
            }
        } catch (error) {
            console.error('Scheduling failed:', error);
            api.showToast('Failed to schedule maintenance.', 'error');
        } finally {
            submitBtn.disabled = false;
            submitBtn.textContent = 'Schedule PM';
        }
    }

    /**
     * Show standard details modal
     * @param {number} standardId Standard ID
     */
    async showStandardModal(standardId) {
        try {
            const standard = await api.getStandardById(standardId);
            if (standard) {
                const modal = document.getElementById('standardModal');
                document.getElementById('standardModalTitle').textContent = `${standard.source} ${standard.clause_id}`;
                document.getElementById('standardModalContent').innerHTML = `
                    <h3>${api.sanitizeHTML(standard.title)}</h3>
                    <p>${api.sanitizeHTML(standard.description)}</p>
                    <p><strong>Category:</strong> ${api.sanitizeHTML(standard.category)}</p>
                `;
                this.showModal(modal);
            } else {
                api.showToast('Standard details not found', 'error');
            }
        } catch (error) {
            console.error('Failed to load standard details:', error);
            api.showToast('Failed to load standard details', 'error');
        }
    }

    /**
     * Show file upload modal
     * @param {number} itemId Checklist item ID
     */
    showUploadModal(itemId) {
        this.uploadItemId = itemId;
        const modal = document.getElementById('uploadModal');
        this.showModal(modal);
    }

    /**
     * Handle file upload
     * @param {Event} e Form submit event
     */
    async handleFileUpload(e) {
        e.preventDefault();
        
        const form = e.target;
        const fileInput = form.querySelector('#fileInput');
        const file = fileInput.files[0];
        
        if (!file) {
            api.showToast('Please select a file', 'error');
            return;
        }
        
        // Validate file
        const validation = api.validateFile(file);
        if (!validation.valid) {
            api.showToast(validation.error, 'error');
            return;
        }
        
        try {
            const response = await api.uploadFile(file, 'checklist_item', this.uploadItemId);
            
            if (response.success) {
                api.showToast('File uploaded successfully', 'success');
                this.hideModal(document.getElementById('uploadModal'));
                
                // Refresh checklist to show attachment
                await this.loadChecklist(this.currentChecklist.id);
            }
            
        } catch (error) {
            console.error('File upload failed:', error);
            api.showToast('File upload failed', 'error');
        }
    }
    
    /**
     * Show reports view
     */
    async showReports() {
        this.showView('reports');
        try {
            const reports = await api.getReportData('compliance');
            this.renderReports(reports);
        } catch (error) {
            console.error('Failed to load reports:', error);
            api.showToast('Failed to load reports', 'error');
        }
    }
    
    /**
     * Render reports data using Chart.js
     * @param {Object} reportsData Reports data
     */
    renderReports(reportsData) {
        // Destroy old charts if they exist
        if (this.complianceChart) this.complianceChart.destroy();
        if (this.standardsChart) this.standardsChart.destroy();
        
        const complianceCtx = document.getElementById('complianceChart').getContext('2d');
        this.complianceChart = new Chart(complianceCtx, {
            type: 'bar',
            data: {
                labels: reportsData.department_compliance.map(d => d.department_name),
                datasets: [{
                    label: 'Compliance Percentage',
                    data: reportsData.department_compliance.map(d => d.compliance_percentage),
                    backgroundColor: reportsData.department_compliance.map(d => {
                        if (d.compliance_percentage >= 90) return '#00cc88';
                        if (d.compliance_percentage >= 75) return '#ffaa00';
                        return '#ff3333';
                    }),
                    borderColor: reportsData.department_compliance.map(d => {
                        if (d.compliance_percentage >= 90) return '#009966';
                        if (d.compliance_percentage >= 75) return '#cc8800';
                        return '#cc2929';
                    }),
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true,
                        max: 100
                    }
                },
                plugins: {
                    title: {
                        display: true,
                        text: 'Compliance by Department'
                    }
                }
            }
        });
        
        const standardsCtx = document.getElementById('standardsChart').getContext('2d');
        this.standardsChart = new Chart(standardsCtx, {
            type: 'doughnut',
            data: {
                labels: reportsData.standards_compliance.map(s => `${s.source} ${s.clause_id}`),
                datasets: [{
                    label: 'Compliance by Standard',
                    data: reportsData.standards_compliance.map(s => s.compliance_percentage),
                    backgroundColor: [
                        '#00cc88', '#ffaa00', '#ff3333', '#0077ff', '#33e6ff', '#00ffaa'
                    ],
                    hoverOffset: 4
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: {
                        display: true,
                        text: 'Compliance by Standard'
                    }
                }
            }
        });
    }
    
    /**
     * Show NCRs view
     */
    async showNCRs() {
        this.showView('ncrs');
        try {
            const ncrs = await api.getNCRs();
            this.renderNCRs(ncrs);
        } catch (error) {
            console.error('Failed to load NCRs:', error);
            api.showToast('Failed to load NCRs', 'error');
        }
    }
    
    /**
     * Render NCRs data
     * @param {Array} ncrs List of NCRs
     */
    renderNCRs(ncrs) {
        const container = document.getElementById('ncrsContainer');
        if (!container) return;
        
        container.innerHTML = `
            <table class="data-table">
                <thead>
                    <tr>
                        <th>NCR #</th>
                        <th>Description</th>
                        <th>Asset</th>
                        <th>Department</th>
                        <th>Status</th>
                        <th>Severity</th>
                        <th>Raised By</th>
                        <th>Due Date</th>
                    </tr>
                </thead>
                <tbody id="ncrsTableBody"></tbody>
            </table>
        `;
        
        const tableBody = document.getElementById('ncrsTableBody');
        if (ncrs.length === 0) {
            tableBody.innerHTML = `<tr><td colspan="8" style="text-align: center;">No open NCRs found.</td></tr>`;
            return;
        }
        
        ncrs.forEach(ncr => {
            tableBody.innerHTML += `
                <tr data-ncr-id="${ncr.id}">
                    <td>${api.sanitizeHTML(ncr.ncr_number)}</td>
                    <td>${api.sanitizeHTML(ncr.description)}</td>
                    <td>${api.sanitizeHTML(ncr.asset_name)}</td>
                    <td>${api.sanitizeHTML(ncr.department_name)}</td>
                    <td>${api.sanitizeHTML(ncr.status)}</td>
                    <td>${api.sanitizeHTML(ncr.severity)}</td>
                    <td>${api.sanitizeHTML(ncr.raised_by_name)}</td>
                    <td>${api.sanitizeHTML(ncr.due_date)}</td>
                </tr>
            `;
        });
        
        // Add click event for each row to open a modal for updates
        tableBody.querySelectorAll('tr').forEach(row => {
            row.addEventListener('click', () => this.showNCRModal(row.dataset.ncrId));
        });
    }
    
    /**
     * Show NCR details modal
     * @param {number} ncrId NCR ID
     */
    async showNCRModal(ncrId) {
        try {
            const ncrs = await api.getNCRs({ id: ncrId });
            const ncr = ncrs.find(n => n.id == ncrId);
            
            if (!ncr) {
                api.showToast('NCR not found', 'error');
                return;
            }
            
            const modal = document.getElementById('ncrModal');
            document.getElementById('ncrModalTitle').textContent = `NCR #${ncr.ncr_number}`;
            
            const ncrContent = document.getElementById('ncrModalContent');
            ncrContent.innerHTML = `
                <p><strong>Description:</strong> ${api.sanitizeHTML(ncr.description)}</p>
                <p><strong>Asset:</strong> ${api.sanitizeHTML(ncr.asset_name)} (${api.sanitizeHTML(ncr.asset_tag)})</p>
                <p><strong>Department:</strong> ${api.sanitizeHTML(ncr.department_name)}</p>
                <p><strong>Status:</strong> <span class="status-badge ${api.getStatusClass(ncr.status)}">${api.sanitizeHTML(ncr.status)}</span></p>
                <p><strong>Severity:</strong> ${api.sanitizeHTML(ncr.severity)}</p>
                <p><strong>Raised By:</strong> ${api.sanitizeHTML(ncr.raised_by_name)} on ${api.formatDate(ncr.created_at)}</p>
                <div class="form-group">
                    <label for="ncrStatus">Update Status</label>
                    <select id="ncrStatus" class="form-control">
                        <option value="open" ${ncr.status === 'open' ? 'selected' : ''}>Open</option>
                        <option value="in_progress" ${ncr.status === 'in_progress' ? 'selected' : ''}>In Progress</option>
                        <option value="closed" ${ncr.status === 'closed' ? 'selected' : ''}>Closed</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ncrRootCause">Root Cause Analysis</label>
                    <textarea id="ncrRootCause" class="form-control" rows="3" placeholder="Enter root cause...">${api.sanitizeHTML(ncr.root_cause || '')}</textarea>
                </div>
                <div class="form-group">
                    <label for="ncrCorrectiveAction">Corrective Action</label>
                    <textarea id="ncrCorrectiveAction" class="form-control" rows="3" placeholder="Enter corrective action...">${api.sanitizeHTML(ncr.corrective_action || '')}</textarea>
                </div>
            `;
            
            const updateBtn = document.getElementById('updateNcrBtn');
            updateBtn.onclick = () => this.updateNCR(ncr.id);
            this.showModal(modal);

        } catch (error) {
            console.error('Failed to load NCR details:', error);
            api.showToast('Failed to load NCR details', 'error');
        }
    }

    /**
     * Update an NCR from the modal form
     * @param {number} ncrId NCR ID
     */
    async updateNCR(ncrId) {
        const updateData = {
            id: ncrId,
            status: document.getElementById('ncrStatus').value,
            root_cause: document.getElementById('ncrRootCause').value,
            corrective_action: document.getElementById('ncrCorrectiveAction').value
        };

        const updateBtn = document.getElementById('updateNcrBtn');
        updateBtn.disabled = true;
        updateBtn.textContent = 'Updating...';

        try {
            const response = await api.updateNCR(ncrId, updateData);
            if (response.success) {
                api.showToast('NCR updated successfully!', 'success');
                this.hideModal(document.getElementById('ncrModal'));
                this.showNCRs(); // Refresh the NCR list
            } else {
                api.showToast(response.error || 'Failed to update NCR.', 'error');
            }
        } catch (error) {
            console.error('Failed to update NCR:', error);
            api.showToast('Failed to update NCR.', 'error');
        } finally {
            updateBtn.disabled = false;
            updateBtn.textContent = 'Update NCR';
        }
    }
    
    /**
     * Load dashboard data
     */
    async loadDashboardData() {
        try {
            const metrics = await api.getDashboardMetrics();
            document.getElementById('pendingChecklists').textContent = metrics.pendingChecklists;
            document.getElementById('overduePMs').textContent = metrics.overduePMs;
            document.getElementById('openNCRs').textContent = metrics.openNCRs;
            document.getElementById('complianceRate').textContent = metrics.complianceRate;
            
        } catch (error) {
            console.error('Failed to load dashboard data:', error);
        }
    }

    /**
     * Clear department selection
     */
    clearDepartmentSelection() {
        this.selectedDepartment = null;
        this.selectedAssetType = null;
        this.selectedDocumentType = null;
        this.selectedAsset = null;
        
        document.querySelectorAll('.department-item').forEach(item => {
            item.classList.remove('active');
        });
    }

    /**
     * Show modal
     * @param {Element} modal Modal element
     */
    showModal(modal) {
        modal.classList.add('show');
        modal.style.display = 'flex';
        
        // Handle e-signature pad initialization
        if (modal.id === 'eSignatureModal') {
            const canvas = document.getElementById('signatureCanvas');
            this.signaturePad = new SignaturePad(canvas);
        }
        
        // Focus first input in modal
        const firstInput = modal.querySelector('input, textarea, select, button');
        if (firstInput) {
            setTimeout(() => firstInput.focus(), 100);
        }
    }

    /**
     * Hide modal
     * @param {Element} modal Modal element
     */
    hideModal(modal) {
        modal.classList.remove('show');
        setTimeout(() => {
            modal.style.display = 'none';
        }, 300);
        
        // Clear signature pad on close
        if (this.signaturePad) {
            this.signaturePad.clear();
        }
    }

    /**
     * Handle keyboard shortcuts
     * @param {KeyboardEvent} e Keyboard event
     */
    handleKeyboard(e) {
        // ESC key closes modals
        if (e.key === 'Escape') {
            const openModal = document.querySelector('.modal.show');
            if (openModal) {
                this.hideModal(openModal);
            }
        }
        
        // Alt+D for dashboard
        if (e.altKey && e.key === 'd') {
            e.preventDefault();
            this.showView('dashboard');
        }
    }
}

// Initialize app when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    const app = new QuailtyMedApp();
    window.app = app; // Make globally accessible for debugging
    app.init();
});

// Handle browser back/forward buttons
window.addEventListener('popstate', () => {
    // Handle navigation state if needed
});

// Handle app visibility changes (for PWA)
document.addEventListener('visibilitychange', () => {
    if (document.visibilityState === 'visible') {
        // App became visible - could refresh data
        console.log('App is visible');
    }
});

// Service worker registration for offline support
if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('sw.js')
        .then(registration => {
            console.log('SW registered: ', registration);
        })
        .catch(registrationError => {
            console.log('SW registration failed: ', registrationError);
        });
}

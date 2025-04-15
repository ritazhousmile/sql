DECLARE
    modal_id TEXT;
    record_id TEXT;
    templateAssignmentId TEXT;
    fileAssigmentSId TEXT;
    appId TEXT;
BEGIN
    -- Get the current record ID and table IDs
    record_id := rvn('Record ID');
    modal_id := 'assignment_modal_' || record_id;
    templateAssignmentId := tid('Template Assignments');
    fileAssigmentSId := tid('File Assignments');
    
    -- Get application ID - hardcoded based on your example
    appId := 'eqj90dan6huihq';
    
    -- Return button with inline CSS and JavaScript for modal
    RETURN format('
    <div>
        <style>
            /* Button styles */
            .assignment-button {
                background-color: #6366F1;
                color: white;
                border: none;
                border-radius: 6px;
                padding: 10px 16px;
                cursor: pointer;
                font-weight: 500;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
                transition: all 0.2s ease;
            }
            
            .assignment-button:hover {
                background-color: #4F46E5;
                box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            }
            
            /* Modal styles */
            .assignment-modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%%;
                height: 100%%;
                background-color: rgba(0,0,0,0.5);
                z-index: 1000;
                animation: fadeIn 0.2s ease;
            }
            
            @keyframes fadeIn {
                from { opacity: 0; }
                to { opacity: 1; }
            }
            
            .modal-content {
                background-color: white;
                margin: 5%% auto;
                width: 90%%;
                max-width: 700px;
                border-radius: 12px;
                box-shadow: 0 6px 20px rgba(0,0,0,0.15);
                max-height: 90vh;
                display: flex;
                flex-direction: column;
                overflow: hidden;
                animation: slideDown 0.3s ease;
            }
            
            @keyframes slideDown {
                from { transform: translateY(-20px); opacity: 0; }
                to { transform: translateY(0); opacity: 1; }
            }
            
            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 16px 24px;
                background-color: #6366F1;
                color: white;
            }
            
            .modal-header h3 {
                margin: 0;
                font-size: 18px;
                font-weight: 600;
            }
            
            .close-button {
                background: none;
                border: none;
                font-size: 24px;
                cursor: pointer;
                color: white;
                opacity: 0.8;
                transition: opacity 0.2s;
            }
            
            .close-button:hover {
                opacity: 1;
            }
            
            .modal-instructions {
                padding: 16px 24px;
                background-color: #F9FAFB;
                border-bottom: 1px solid #E5E7EB;
                color: #4B5563;
                font-size: 14px;
            }
            
            .modal-body {
                overflow-y: auto;
                flex: 1;
                padding: 0;
            }
            
            .search-container {
                padding: 16px 24px;
                background-color: #F9FAFB;
                border-bottom: 1px solid #E5E7EB;
            }
            
            .search-input {
                width: 100%%;
                padding: 10px 16px;
                padding-left: 40px;
                border: 1px solid #D1D5DB;
                border-radius: 6px;
                box-sizing: border-box;
                background-image: url("data:image/svg+xml,%3Csvg xmlns=''http://www.w3.org/2000/svg'' width=''16'' height=''16'' fill=''%236B7280'' viewBox=''0 0 16 16''%3E%3Cpath d=''M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z''/%3E%3C/svg%3E");
                background-repeat: no-repeat;
                background-position: 12px center;
                font-size: 14px;
            }
            
            .search-input:focus {
                outline: none;
                border-color: #6366F1;
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            }
            
            .template-heading {
                display: flex;
                padding: 12px 24px;
                background-color: #F3F4F6;
                font-weight: 600;
                color: #374151;
                border-bottom: 1px solid #E5E7EB;
            }
            
            .template-heading-checkbox {
                width: 30px;
            }
            
            .template-heading-label {
                flex: 1;
            }
            
            .template-list {
                list-style: none;
                margin: 0;
                padding: 0;
                max-height: 500px;
                overflow-y: auto;
            }
            
            .template-item {
                display: flex;
                align-items: center;
                padding: 12px 24px;
                border-bottom: 1px solid #E5E7EB;
                transition: background-color 0.15s;
                cursor: pointer;
            }
            
            .template-item:hover {
                background-color: #F9FAFB;
            }
            
            .template-item.selected {
                background-color: #EEF2FF;
            }
            
            .template-item:last-child {
                border-bottom: none;
            }
            
            .template-checkbox {
                appearance: none;
                -webkit-appearance: none;
                width: 18px;
                height: 18px;
                border: 2px solid #D1D5DB;
                border-radius: 4px;
                margin-right: 16px;
                cursor: pointer;
                position: relative;
                transition: all 0.2s;
            }
            
            .template-checkbox:checked {
                background-color: #6366F1;
                border-color: #6366F1;
            }
            
            .template-checkbox:checked::after {
                content: "";
                position: absolute;
                top: 2px;
                left: 5px;
                width: 5px;
                height: 10px;
                border: solid white;
                border-width: 0 2px 2px 0;
                transform: rotate(45deg);
            }
            
            .template-checkbox:focus {
                outline: none;
                box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
            }
            
            .template-label {
                flex: 1;
                font-size: 14px;
                color: #1F2937;
                margin-left: 5px;
            }
            
            .modal-footer {
                display: flex;
                justify-content: space-between;
                padding: 16px 24px;
                background-color: #F9FAFB;
                border-top: 1px solid #E5E7EB;
            }
            
            .pagination {
                display: flex;
                align-items: center;
                gap: 8px;
            }
            
            .pagination-button {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 32px;
                height: 32px;
                border: 1px solid #D1D5DB;
                border-radius: 6px;
                background-color: white;
                color: #4B5563;
                cursor: pointer;
                transition: all 0.2s;
            }
            
            .pagination-button:hover:not(:disabled) {
                background-color: #F3F4F6;
                border-color: #9CA3AF;
            }
            
            .pagination-button:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
            
            .pagination-button.active {
                background-color: #6366F1;
                color: white;
                border-color: #6366F1;
            }
            
            .per-page-select {
                display: flex;
                align-items: center;
                margin-left: 16px;
                gap: 8px;
                font-size: 14px;
                color: #4B5563;
            }
            
            .per-page-select select {
                padding: 4px 8px;
                border: 1px solid #D1D5DB;
                border-radius: 4px;
                background-color: white;
            }
            
            .action-buttons {
                display: flex;
                gap: 12px;
            }
            
            .btn {
                padding: 10px 20px;
                border-radius: 6px;
                font-weight: 500;
                cursor: pointer;
                font-size: 14px;
                transition: all 0.2s;
            }
            
            .btn-primary {
                background-color: #6366F1;
                color: white;
                border: none;
                box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            }
            
            .btn-primary:hover {
                background-color: #4F46E5;
                box-shadow: 0 2px 4px rgba(0,0,0,0.15);
            }
            
            .btn-secondary {
                background-color: white;
                color: #4B5563;
                border: 1px solid #D1D5DB;
            }
            
            .btn-secondary:hover {
                background-color: #F3F4F6;
                color: #111827;
            }
            
            .btn-outline {
                background-color: white;
                color: #6366F1;
                border: 1px solid #6366F1;
            }
            
            .btn-outline:hover {
                background-color: #EEF2FF;
            }
            
            .loading-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
            }
            
            .spinner {
                width: 40px;
                height: 40px;
                border: 3px solid #EEF2FF;
                border-radius: 50%%;
                border-top-color: #6366F1;
                animation: spin 1s linear infinite;
                margin-bottom: 16px;
            }
            
            @keyframes spin {
                to { transform: rotate(360deg); }
            }
            
            .no-results {
                padding: 24px;
                text-align: center;
                color: #6B7280;
                font-size: 14px;
            }
            
            @keyframes fadeOut {
                from { opacity: 1; }
                to { opacity: 0; }
            }
        </style>

        <!-- Button with all JS in onclick -->
        <button class="assignment-button" onclick="(function() {
            // Check if the modal already exists
            let modal = document.getElementById(''%s'');
            
            // If not, create it
            if (!modal) {
                modal = document.createElement(''div'');
                modal.id = ''%s'';
                modal.className = ''assignment-modal'';
                modal.innerHTML = `
                    <div class="modal-content">
                        <div class="modal-header">
                            <h3>Add / Remove assignments</h3>
                            <button class="close-button" id="closeBtn_%s">&times;</button>
                        </div>
                        
                        <div class="modal-instructions">
                            Select each assignment you wish to add.
                        </div>
                        
                        <div class="modal-body">
                            <div id="loadingContainer_%s" class="loading-container">
                                <div class="spinner"></div>
                                <p>Loading assignments...</p>
                            </div>
                            
                            <div id="assignmentsContainer_%s" style="display:none;">
                                <div class="search-container">
                                    <input type="text" id="searchInput_%s" class="search-input" placeholder="Type to search...">
                                </div>
                                
                                <div class="template-heading">
                                    <div class="template-heading-checkbox">
                                        <input type="checkbox" class="template-checkbox" id="selectAll_%s">
                                    </div>
                                    <div class="template-heading-label">Diary</div>
                                </div>
                                
                                <ul id="templateList_%s" class="template-list">
                                    <!-- Templates will be loaded here -->
                                </ul>
                            </div>
                        </div>
                        
                        <div class="modal-footer">
                            <div class="pagination">
                                <button class="pagination-button" id="firstPage_%s" disabled>
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                        <path d="M11.7 12.7L7.3 8.3C7.1 8.1 7 7.9 7 7.7C7 7.5 7.1 7.3 7.3 7.1L11.7 2.7C12.1 2.3 12.7 2.3 13.1 2.7C13.5 3.1 13.5 3.7 13.1 4.1L9.4 7.7L13 11.3C13.4 11.7 13.4 12.3 13 12.7C12.8 12.9 12.6 13 12.3 13C12.1 13 11.9 12.9 11.7 12.7ZM3 2C3.6 2 4 2.4 4 3V13C4 13.6 3.6 14 3 14C2.4 14 2 13.6 2 13V3C2 2.4 2.4 2 3 2Z" fill="currentColor"/>
                                    </svg>
                                </button>
                                <button class="pagination-button" id="prevPage_%s" disabled>
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                        <path d="M10.7 12.7L6.3 8.3C6.1 8.1 6 7.9 6 7.7C6 7.5 6.1 7.3 6.3 7.1L10.7 2.7C11.1 2.3 11.7 2.3 12.1 2.7C12.5 3.1 12.5 3.7 12.1 4.1L8.4 7.7L12 11.3C12.4 11.7 12.4 12.3 12 12.7C11.8 12.9 11.6 13 11.3 13C11.1 13 10.9 12.9 10.7 12.7Z" fill="currentColor"/>
                                    </svg>
                                </button>
                                <div id="pageIndicator_%s" style="min-width: 60px; text-align: center;">
                                    1
                                </div>
                                <button class="pagination-button" id="nextPage_%s">
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                        <path d="M5.3 12.7L9.7 8.3C9.9 8.1 10 7.9 10 7.7C10 7.5 9.9 7.3 9.7 7.1L5.3 2.7C4.9 2.3 4.3 2.3 3.9 2.7C3.5 3.1 3.5 3.7 3.9 4.1L7.6 7.7L4 11.3C3.6 11.7 3.6 12.3 4 12.7C4.2 12.9 4.4 13 4.7 13C4.9 13 5.1 12.9 5.3 12.7Z" fill="currentColor"/>
                                    </svg>
                                </button>
                                <button class="pagination-button" id="lastPage_%s">
                                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                                        <path d="M4.3 12.7L8.7 8.3C8.9 8.1 9 7.9 9 7.7C9 7.5 8.9 7.3 8.7 7.1L4.3 2.7C3.9 2.3 3.3 2.3 2.9 2.7C2.5 3.1 2.5 3.7 2.9 4.1L6.6 7.7L3 11.3C2.6 11.7 2.6 12.3 3 12.7C3.2 12.9 3.4 13 3.7 13C3.9 13 4.1 12.9 4.3 12.7ZM13 2C12.4 2 12 2.4 12 3V13C12 13.6 12.4 14 13 14C13.6 14 14 13.6 14 13V3C14 2.4 13.6 2 13 2Z" fill="currentColor"/>
                                    </svg>
                                </button>
                                
                                <div class="per-page-select">
                                    <span>Per Page:</span>
                                    <select id="perPage_%s">
                                        <option value="25">25</option>
                                        <option value="50" selected>50</option>
                                        <option value="100">100</option>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="action-buttons">
                                <button class="btn btn-outline" id="selectAllBtn_%s">Select All/None</button>
                                <button class="btn btn-secondary" id="cancelBtn_%s">Cancel</button>
                                <button class="btn btn-primary" id="saveBtn_%s">Save</button>
                            </div>
                        </div>
                    </div>
                `;
                document.body.appendChild(modal);
            }
            
            // Show the modal
            modal.style.display = ''block'';
            
            // Elements
            const loadingContainer = document.getElementById(''loadingContainer_%s'');
            const assignmentsContainer = document.getElementById(''assignmentsContainer_%s'');
            const templateList = document.getElementById(''templateList_%s'');
            const searchInput = document.getElementById(''searchInput_%s'');
            const closeBtn = document.getElementById(''closeBtn_%s'');
            const cancelBtn = document.getElementById(''cancelBtn_%s'');
            const saveBtn = document.getElementById(''saveBtn_%s'');
            const selectAllCheckbox = document.getElementById(''selectAll_%s'');
            const selectAllBtn = document.getElementById(''selectAllBtn_%s'');
            const firstPageBtn = document.getElementById(''firstPage_%s'');
            const prevPageBtn = document.getElementById(''prevPage_%s'');
            const nextPageBtn = document.getElementById(''nextPage_%s'');
            const lastPageBtn = document.getElementById(''lastPage_%s'');
            const pageIndicator = document.getElementById(''pageIndicator_%s'');
            const perPageSelect = document.getElementById(''perPage_%s'');
            
            // Data
            const modalData = {
                allTemplates: [],
                filteredTemplates: [],
                selectedIds: [],
                recordId: ''%s'',
                appId: ''%s'',
                templateTableId: ''%s'',
                assignmentTableId: ''%s'',
                currentPage: 1,
                itemsPerPage: parseInt(perPageSelect.value),
                totalPages: 1
            };
            
            // Close modal function
            const closeModal = function() {
                modal.style.display = ''none'';
            };
            
            // Set up event listeners
            closeBtn.addEventListener(''click'', closeModal);
            cancelBtn.addEventListener(''click'', closeModal);
            saveBtn.addEventListener(''click'', saveAssignments);
            searchInput.addEventListener(''input'', filterTemplates);
            selectAllCheckbox.addEventListener(''change'', function() {
                togglePageSelections(this.checked);
            });
            selectAllBtn.addEventListener(''click'', toggleAllSelections);
            perPageSelect.addEventListener(''change'', function() {
                modalData.itemsPerPage = parseInt(this.value);
                modalData.currentPage = 1;
                renderTemplates();
            });
            
            // Pagination event listeners
            firstPageBtn.addEventListener(''click'', function() {
                if (modalData.currentPage > 1) {
                    modalData.currentPage = 1;
                    renderTemplates();
                }
            });
            
            prevPageBtn.addEventListener(''click'', function() {
                if (modalData.currentPage > 1) {
                    modalData.currentPage--;
                    renderTemplates();
                }
            });
            
            nextPageBtn.addEventListener(''click'', function() {
                if (modalData.currentPage < modalData.totalPages) {
                    modalData.currentPage++;
                    renderTemplates();
                }
            });
            
            lastPageBtn.addEventListener(''click'', function() {
                if (modalData.currentPage < modalData.totalPages) {
                    modalData.currentPage = modalData.totalPages;
                    renderTemplates();
                }
            });
            
            // Load data
            loadData();
            
            // Function to load templates and current assignments
            function loadData() {
                loadingContainer.style.display = ''flex'';
                assignmentsContainer.style.display = ''none'';
                
                console.log(''Loading templates from: %s'');
                
                // Fetch all templates
                fetch(''https://jag.highsystems.io/api/rest/v1/applications/'' + modalData.appId + ''/tables/'' + modalData.templateTableId + ''/records'')
                    .then(response => {
                        if (!response.ok) throw new Error(''Failed to load templates'');
                        return response.json();
                    })
                    .then(data => {
                        console.log(''Templates loaded:'', data.length);
                        
                        // Process templates
                        modalData.allTemplates = data.map(item => ({
                            id: item.id,
                            label: item.Name || item.name || item.Label || item.label || item.Title || item.title || ''No Name''
                        }));
                        
                        // Sort templates alphabetically
                        modalData.allTemplates.sort((a, b) => a.label.localeCompare(b.label));
                        
                        // Set filtered templates to all templates initially
                        modalData.filteredTemplates = [...modalData.allTemplates];
                        
                        // Now fetch current assignments
                        return fetch(''https://jag.highsystems.io/api/rest/v1/applications/'' + modalData.appId + ''/tables/'' + modalData.assignmentTableId + ''/records?query=Claim=='' + modalData.recordId);
                    })
                    .then(response => {
                        if (!response.ok) throw new Error(''Failed to load current assignments'');
                        return response.json();
                    })
                    .then(assignments => {
                        console.log(''Current assignments loaded:'', assignments.length);
                        
                        // Get selected template IDs
                        modalData.selectedIds = assignments.map(item => item.Template);
                        
                        // Calculate pagination
                        updatePagination();
                        
                        // Render templates
                        renderTemplates();
                        
                        // Hide loading, show assignments
                        loadingContainer.style.display = ''none'';
                        assignmentsContainer.style.display = ''block'';
                    })
                    .catch(error => {
                        console.error(''Error loading data:'', error);
                        templateList.innerHTML = `<li class="no-results">Error loading assignments: ${error.message}</li>`;
                        loadingContainer.style.display = ''none'';
                        assignmentsContainer.style.display = ''block'';
                    });
            }
            
            // Filter templates based on search input
            function filterTemplates() {
                const searchTerm = searchInput.value.toLowerCase().trim();
                
                if (searchTerm) {
                    modalData.filteredTemplates = modalData.allTemplates.filter(template => 
                        template.label.toLowerCase().includes(searchTerm)
                    );
                } else {
                    modalData.filteredTemplates = [...modalData.allTemplates];
                }
                
                modalData.currentPage = 1;
                updatePagination();
                renderTemplates();
            }
            
            // Update pagination
            function updatePagination() {
                modalData.totalPages = Math.ceil(modalData.filteredTemplates.length / modalData.itemsPerPage);
                
                if (modalData.currentPage > modalData.totalPages && modalData.totalPages > 0) {
                    modalData.currentPage = modalData.totalPages;
                }
                
                // Update page indicator
                pageIndicator.textContent = modalData.totalPages > 0 
                    ? `${modalData.currentPage} / ${modalData.totalPages}` 
                    : "0 / 0";
                
                // Update button states
                firstPageBtn.disabled = modalData.currentPage <= 1 || modalData.totalPages <= 1;
                prevPageBtn.disabled = modalData.currentPage <= 1 || modalData.totalPages <= 1;
                nextPageBtn.disabled = modalData.currentPage >= modalData.totalPages || modalData.totalPages <= 1;
                lastPageBtn.disabled = modalData.currentPage >= modalData.totalPages || modalData.totalPages <= 1;
            }
            
            // Render templates for current page
            function renderTemplates() {
                // Update pagination
                updatePagination();
                
                // Calculate slice indexes
                const startIndex = (modalData.currentPage - 1) * modalData.itemsPerPage;
                const endIndex = Math.min(startIndex + modalData.itemsPerPage, modalData.filteredTemplates.length);
                const currentPageItems = modalData.filteredTemplates.slice(startIndex, endIndex);
                
                if (currentPageItems.length === 0) {
                    templateList.innerHTML = `<li class="no-results">No assignments found${searchInput.value ? '' matching your search'' : ''}.</li>`;
                    selectAllCheckbox.checked = false;
                    selectAllCheckbox.disabled = true;
                    return;
                }
                
                selectAllCheckbox.disabled = false;
                
                // Build HTML for templates
                let html = '''';
                
                currentPageItems.forEach(template => {
                    const isSelected = modalData.selectedIds.includes(template.id);
                    html += `
                        <li class="template-item ${isSelected ? ''selected'' : ''''}" data-id="${template.id}">
                            <input type="checkbox" class="template-checkbox" 
                                   id="template_%s_${template.id}" 
                                   ${isSelected ? ''checked'' : ''''}
                                   onchange="this.closest(''.template-item'').classList.toggle(''selected'', this.checked)">
                            <label class="template-label" for="template_%s_${template.id}">${template.label}</label>
                        </li>
                    `;
                });
                
                templateList.innerHTML = html;
                
                // Set selectAll checkbox state based on if all visible items are selected
                selectAllCheckbox.checked = currentPageItems.length > 0 && 
                    currentPageItems.every(template => modalData.selectedIds.includes(template.id));
                
                // Add click event to template items
                templateList.querySelectorAll(''.template-item'').forEach(item => {
                    item.addEventListener(''click'', function(event) {
                        if (event.target.tagName !== ''INPUT'') {
                            const checkbox = this.querySelector(''input[type="checkbox"]'');
                            checkbox.checked = !checkbox.checked;
                            this.classList.toggle(''selected'', checkbox.checked);
                            
                            // Update selected IDs
                            const templateId = this.dataset.id;
                            if (checkbox.checked) {
                                if (!modalData.selectedIds.includes(templateId)) {
                                    modalData.selectedIds.push(templateId);
                                }
                            } else {
                                modalData.selectedIds = modalData.selectedIds.filter(id => id !== templateId);
                            }
                            
                            // Update select all checkbox
                            updateSelectAllCheckbox();
                        }
                    });
                    
                    // Also handle checkbox changes
                    const checkbox = item.querySelector(''input[type="checkbox"]'');
                    checkbox.addEventListener(''change'', function() {
                        const templateId = item.dataset.id;
                        
                        if (this.checked) {
                            if (!modalData.selectedIds.includes(templateId)) {
                                modalData.selectedIds.push(templateId);
                            }
                        } else {
                            modalData.selectedIds = modalData.selectedIds.filter(id => id !== template
                    } else {
                            modalData.selectedIds = modalData.selectedIds.filter(id => id !== templateId);
                        }
                        
                        // Update select all checkbox
                        updateSelectAllCheckbox();
                    });
                });
            }
            
            // Update the select all checkbox based on current selections
            function updateSelectAllCheckbox() {
                const currentPageTemplates = getCurrentPageTemplates();
                selectAllCheckbox.checked = currentPageTemplates.length > 0 && 
                    currentPageTemplates.every(template => modalData.selectedIds.includes(template.id));
            }
            
            // Get current page templates
            function getCurrentPageTemplates() {
                const startIndex = (modalData.currentPage - 1) * modalData.itemsPerPage;
                const endIndex = Math.min(startIndex + modalData.itemsPerPage, modalData.filteredTemplates.length);
                return modalData.filteredTemplates.slice(startIndex, endIndex);
            }
            
            // Toggle all templates on the current page
            function togglePageSelections(checked) {
                const currentPageTemplates = getCurrentPageTemplates();
                
                currentPageTemplates.forEach(template => {
                    const checkbox = document.getElementById(`template_${modalData.recordId}_${template.id}`);
                    if (checkbox) {
                        checkbox.checked = checked;
                        checkbox.closest('.template-item').classList.toggle('selected', checked);
                        
                        if (checked) {
                            if (!modalData.selectedIds.includes(template.id)) {
                                modalData.selectedIds.push(template.id);
                            }
                        } else {
                            modalData.selectedIds = modalData.selectedIds.filter(id => id !== template.id);
                        }
                    }
                });
            }
            
            // Toggle all templates (across all pages)
            function toggleAllSelections() {
                const allSelected = modalData.filteredTemplates.length > 0 && 
                    modalData.filteredTemplates.every(template => modalData.selectedIds.includes(template.id));
                
                // If all are selected, deselect all; otherwise select all
                if (allSelected) {
                    modalData.selectedIds = [];
                } else {
                    modalData.selectedIds = [...new Set([...modalData.selectedIds, ...modalData.filteredTemplates.map(t => t.id)])];
                }
                
                // Re-render current page
                renderTemplates();
            }
            
            // Save assignments function
            function saveAssignments() {
                // Show loading
                loadingContainer.style.display = 'flex';
                assignmentsContainer.style.display = 'none';
                
                // First get existing assignments to compare
                fetch(`https://jag.highsystems.io/api/rest/v1/applications/${modalData.appId}/tables/${modalData.assignmentTableId}/records?query=Claim==${modalData.recordId}`)
                    .then(response => {
                        if (!response.ok) throw new Error('Failed to load current assignments');
                        return response.json();
                    })
                    .then(existingAssignments => {
                        console.log('Processing existing assignments:', existingAssignments.length);
                        
                        // Create maps for easier lookup
                        const existingMap = new Map();
                        existingAssignments.forEach(assignment => {
                            existingMap.set(assignment.Template, assignment);
                        });
                        
                        const selectedMap = new Set(modalData.selectedIds);
                        
                        // Determine which to add and which to remove
                        const toAdd = [];
                        const toRemove = [];
                        
                        // Find assignments to add
                        modalData.selectedIds.forEach(templateId => {
                            if (!existingMap.has(templateId)) {
                                toAdd.push({
                                    Claim: modalData.recordId,
                                    Template: templateId
                                });
                            }
                        });
                        
                        // Find assignments to remove
                        existingAssignments.forEach(assignment => {
                            if (!selectedMap.has(assignment.Template)) {
                                toRemove.push(assignment.id);
                            }
                        });
                        
                        console.log('To add:', toAdd.length, 'To remove:', toRemove.length);
                        
                        // Process removals first
                        const removePromises = toRemove.map(id => 
                            fetch(`https://jag.highsystems.io/api/rest/v1/applications/${modalData.appId}/tables/${modalData.assignmentTableId}/records/${id}`, {
                                method: 'DELETE'
                            })
                        );
                        
                        // Then process additions
                        const addPromises = toAdd.map(assignment => 
                            fetch(`https://jag.highsystems.io/api/rest/v1/applications/${modalData.appId}/tables/${modalData.assignmentTableId}/records`, {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                body: JSON.stringify(assignment)
                            })
                        );
                        
                        // Combine all promises
                        return Promise.all([...removePromises, ...addPromises]);
                    })
                    .then(() => {
                        console.log('All assignments updated successfully');
                        // Close modal after successful update
                        closeModal();
                        
                        // Show success notification if needed
                        const notification = document.createElement('div');
                        notification.style.position = 'fixed';
                        notification.style.bottom = '20px';
                        notification.style.right = '20px';
                        notification.style.backgroundColor = '#10B981';
                        notification.style.color = 'white';
                        notification.style.padding = '12px 20px';
                        notification.style.borderRadius = '6px';
                        notification.style.boxShadow = '0 4px 6px rgba(0,0,0,0.1)';
                        notification.style.zIndex = '1100';
                        notification.style.animation = 'fadeIn 0.3s ease';
                        notification.innerHTML = 'Assignments updated successfully';
                        document.body.appendChild(notification);
                        
                        // Remove notification after 3 seconds
                        setTimeout(() => {
                            notification.style.animation = 'fadeOut 0.3s ease';
                            setTimeout(() => {
                                document.body.removeChild(notification);
                            }, 300);
                        }, 3000);
                        
                        // Reload the page if needed
                        // location.reload();
                    })
                    .catch(error => {
                        console.error('Error saving assignments:', error);
                        
                        // Show error in modal
                        loadingContainer.innerHTML = `
                            <div style="color: #EF4444; margin-bottom: 16px;">
                                <svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M12 22C6.477 22 2 17.523 2 12C2 6.477 6.477 2 12 2C17.523 2 22 6.477 22 12C22 17.523 17.523 22 12 22ZM12 20C16.418 20 20 16.418 20 12C20 7.582 16.418 4 12 4C7.582 4 4 7.582 4 12C4 16.418 7.582 20 12 20ZM11 15H13V17H11V15ZM11 7H13V13H11V7Z" fill="currentColor"/>
                                </svg>
                            </div>
                            <p>Error saving assignments: ${error.message}</p>
                            <button class="btn btn-secondary" style="margin-top: 16px;" onclick="document.getElementById('assignmentsContainer_${modalData.recordId}').style.display='block'; this.parentElement.style.display='none';">
                                Try Again
                            </button>
                        `;
                        loadingContainer.style.display = 'flex';
                    });
            }
            
            // End of function, return false to prevent default action
            return false;
        })();" 
        class="btn btn-primary"
        >
            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
            </svg>
            Manage Assignments
        </button>
    </div>
    ', 
    modal_id, modal_id, record_id, record_id, record_id, record_id, record_id, record_id, 
    record_id, record_id, record_id, record_id, record_id, record_id, record_id, record_id, 
    record_id, record_id, record_id, record_id, record_id, record_id, record_id, record_id, 
    record_id, record_id, templateAssignmentId, record_id, appId, templateAssignmentId, fileAssigmentSId);
END;
DECLARE
    modal_id TEXT;
    record_id TEXT;
BEGIN
    record_id := rvn('Record ID');
    modal_id := 'rediary_modal_' || record_id;
    
    -- Re-Diary Button with Modal
    RETURN format('
    <div>
        <style>
            .rediary-btn {
                --width: 150px;
                --timing: 2s;
                border: 0;
                width: auto;
                padding: 12px 20px;
                color: #fff;
                font-weight: bold;
                font-size: 1em;
                background: rgb(64, 192, 87);
                transition: all 0.2s;
                border-radius: 3px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                justify-content: center;
            }
            
            .rediary-btn:hover {
                background-image: linear-gradient(
                    to right,
                    rgb(250, 82, 82),
                    rgb(250, 82, 82) 16.65%%,
                    rgb(190, 75, 219) 16.65%%,
                    rgb(190, 75, 219) 33.3%%,
                    rgb(76, 110, 245) 33.3%%,
                    rgb(76, 110, 245) 49.95%%,
                    rgb(64, 192, 87) 49.95%%,
                    rgb(64, 192, 87) 66.6%%,
                    rgb(250, 176, 5) 66.6%%,
                    rgb(250, 176, 5) 83.25%%,
                    rgb(253, 126, 20) 83.25%%,
                    rgb(253, 126, 20) 100%%,
                    rgb(250, 82, 82) 100%%
                );
                animation: 2s linear dance6123 infinite;
                transform: scale(1.1) translateY(-1px);
            }
            
            @keyframes dance6123 {
                to {
                    background-position: 150px;
                }
            }
            
            .rediary-btn svg {
                margin-right: 8px;
                width: 20px;
                height: 20px;
            }
            
            .modal {
                display: none;
                position: fixed;
                left: 0;
                top: 0;
                width: 100%%;
                height: 100%%;
                background: rgba(0,0,0,0.5);
                z-index: 1000;
            }
            .modal-content {
                background: white;
                margin: 15%% auto;
                padding: 24px;
                width: 480px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }
            .modal-header {
                margin-bottom: 16px;
                padding-bottom: 16px;
                border-bottom: 1px solid #e5e7eb;
            }
            .modal-header h2 {
                margin: 0;
                font-size: 18px;
                color: #1F2937;
            }
            .input-field {
                width: 100%%;
                padding: 10px;
                margin: 8px 0 16px 0;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 14px;
            }
            .date-field {
                width: 100%%;
                padding: 10px;
                margin: 8px 0 16px 0;
                border: 1px solid #d1d5db;
                border-radius: 4px;
                font-size: 14px;
            }
            textarea.input-field {
                min-height: 80px;
                resize: vertical;
            }
            .form-label {
                display: block;
                margin-bottom: 4px;
                font-weight: 500;
                font-size: 14px;
                color: #374151;
            }
            .modal-footer {
                margin-top: 24px;
                display: flex;
                justify-content: flex-end;
                gap: 12px;
            }
            .loader {
                border: 4px solid #f3f3f3;
                border-radius: 50%%;
                border-top: 4px solid #3B82F6;
                width: 30px;
                height: 30px;
                -webkit-animation: spin 2s linear infinite;
                animation: spin 2s linear infinite;
                display: inline-block;
                margin-right: 8px;
                vertical-align: middle;
            }
            @keyframes spin {
                0%% { transform: rotate(0deg); }
                100%% { transform: rotate(360deg); }
            }
            .btn {
                padding: 10px 16px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
            }
            .btn-primary {
                background: #3B82F6;
                color: white;
            }
            .btn-primary:hover {
                background: #2563EB;
            }
            .btn-secondary {
                background: #e5e7eb;
                color: #374151;
            }
            .btn-secondary:hover {
                background: #d1d5db;
            }
        </style>

        <!-- Re-Diary button -->
        <button onclick="document.getElementById(''%1$s'').style.display=''block''" class="rediary-btn">
            <svg width="20" height="20" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg">
                <circle style="fill:#E2574C;" cx="256" cy="256" r="256"/>
                <path style="fill:#D15046;" d="M488.084,364.044c-0.5-1.024-0.976-2.068-1.584-3.012c-0.672-3.928-2.092-7.604-4.112-10.876
                c-0.7-3.428-2.036-6.54-3.852-9.296c-0.644-3.92-2.06-7.572-4.084-10.804c-0.784-4.372-2.484-8.508-4.904-12.148
                c-0.792-2.6-1.916-5.084-3.304-7.372c-0.732-3.324-2.028-6.392-3.768-9.136c-0.696-3.916-2.112-7.592-4.124-10.892
                c-0.712-3.4-2.048-6.504-3.84-9.272c-0.668-3.916-2.084-7.584-4.112-10.86c-0.696-3.424-2.028-6.552-3.848-9.316
                c-0.644-3.916-2.056-7.564-4.084-10.796c-0.696-3.864-2.116-7.536-4.116-10.86c-0.804-3.796-2.376-7.296-4.532-10.38
                c-0.76-2.664-1.892-5.148-3.336-7.416c-0.68-3.904-2.1-7.58-4.112-10.868c-0.708-3.408-2.044-6.524-3.848-9.304
                c-0.664-3.916-2.084-7.584-4.116-10.856c-0.864-4.292-2.728-8.12-5.32-11.368c-4.056-11.236-14.312-19.22-27.08-19.22h-9.048
                c-0.56-0.84,0.748-1.58-3.252-2.252v-1.364c0-3.544,0-6.692-4-8.888v-1.356c0-3.756-1.128-7.072-3.828-9.264
                c-1.38-5.104-6.312-8.884-11.856-8.884c-6.628,0-12.316,5.372-12.316,12v2.048v2.056V160H176.964c-0.56-0.84,0.744-1.58-3.256-2.252
                v-1.364c0-3.544,0-6.692-4-8.888v-1.356c0-3.756-1.128-7.072-3.828-9.264c-1.38-5.104-6.312-8.884-11.856-8.884
                c-6.628,0-12.316,5.372-12.316,12v2.048v2.056V160h-15.7c-16.572,0-32.3,13.428-32.3,30v2.048v2.056v3.904v2.048v2.056V208v2.048
                v2.056V216v2.048v2.056V328v2.048v2.056v29.904v2.048v2.056c0,5.264,2.272,10.204,5.028,14.492c0.632,3.796,2.372,7.448,4.428,10.78
                c0.664,3.392,2.136,6.576,4.004,9.436c0.604,3.812,2.112,7.46,4.188,10.772c0.704,3.732,2.28,7.176,4.464,10.236
                c0.74,2.736,1.924,5.296,3.468,7.632c0.596,3.848,2.032,7.492,4.12,10.768c0.636,3.44,1.956,6.628,3.856,9.456
                c0.572,3.852,1.992,7.476,4.088,10.736c0.624,3.784,2.044,7.436,4.112,10.768c0.66,3.384,1.968,6.572,3.844,9.436
                c0.196,1.24,0.508,2.452,0.872,3.652C174.968,501.964,214.3,512,256,512C358.764,512,447.34,451.416,488.084,364.044z"/>
                <path style="fill:#F5F5F5;" d="M386,160H126c-16.572,0-30,13.428-30,30v138v34c0,16.572,13.428,30,30,30h34h192h34
                c16.572,0,30-13.428,30-30v-34V190C416,173.428,402.572,160,386,160z"/>
                <path style="fill:#FFD464;" d="M386,168H126c-16.572,0-30,13.428-30,30v18h320v-18C416,181.428,402.572,168,386,168z"/>
                <path style="fill:#263740;" d="M386,160H126c-16.572,0-30,13.428-30,30v18h320v-18C416,173.428,402.572,160,386,160z"/>
                <g>
                    <path style="fill:#F5F5F5;" d="M153.7,192c-6.628,0-12-5.372-12-12v-40c0-6.628,5.372-12,12-12s12,5.372,12,12v40
                        C165.7,186.628,160.328,192,153.7,192z"/>
                    <path style="fill:#F5F5F5;" d="M353.7,192c-6.628,0-12-5.372-12-12v-40c0-6.628,5.372-12,12-12s12,5.372,12,12v40
                        C365.7,186.628,360.328,192,353.7,192z"/>
                </g>
                <g>
                    <path style="fill:#E6E6E6;" d="M380,272H136c-4.416,0-8-3.584-8-8s3.584-8,8-8h244c4.416,0,8,3.584,8,8S384.42,272,380,272z"/>
                    <path style="fill:#E6E6E6;" d="M380,308H136c-4.416,0-8-3.584-8-8s3.584-8,8-8h244c4.416,0,8,3.584,8,8S384.42,308,380,308z"/>
                    <path style="fill:#E6E6E6;" d="M380,344H136c-4.416,0-8-3.584-8-8s3.584-8,8-8h244c4.416,0,8,3.584,8,8S384.42,344,380,344z"/>
                </g>
            </svg>
            Re-Diary
        </button>

        <!-- Modal dialog -->
        <div id="%1$s" class="modal">
            <div class="modal-content">
                <div id="formContainer_%2$s">
                    <div class="modal-header">
                        <h2>Re-Diary Entry #%2$s</h2>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Note</label>
                        <textarea 
                            id="noteInput_%2$s" 
                            class="input-field" 
                            placeholder="Provide any comments in the Note field."
                            autofocus
                        ></textarea>
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label">Re-Diary Due Date</label>
                        <input 
                            type="date" 
                            id="dueDateInput_%2$s" 
                            class="date-field" 
                            required
                        >
                    </div>
                    
                    <div class="modal-footer">
                        <button onclick="document.getElementById(''%1$s'').style.display=''none''" class="btn btn-secondary">
                            Cancel
                        </button>
                        <button 
                            id="submitBtn_%2$s"
                            onclick="(function() {
                                const noteInput = document.getElementById(''noteInput_%2$s'');
                                const dueDateInput = document.getElementById(''dueDateInput_%2$s'');
                                const formContainer = document.getElementById(''formContainer_%2$s'');
                                const statusContainer = document.getElementById(''statusContainer_%2$s'');
                                const submitBtn = document.getElementById(''submitBtn_%2$s'');
                                
                                if (!dueDateInput.value) {
                                    alert(''Please enter the Re-Diary Due Date'');
                                    dueDateInput.focus();
                                    return;
                                }

                                // Disable button and show loading state
                                submitBtn.disabled = true;
                                submitBtn.innerHTML = ''<div class="loader"></div> Processing...'';

                                // API endpoint for PUT request to update current record
                                const updateUrl = ''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/xx9ctsclisfnns/records/%2$s'';
                                
                                // Data to update current record
                                const updateData = {
                                    status: ''Re-Diaried'',
                                    re_diary_due_date: dueDateInput.value,
                                    note: noteInput.value
                                };

                                fetch(updateUrl, {
                                    method: ''PUT'',
                                    headers: {
                                        ''Content-Type'': ''application/json''
                                    },
                                    body: JSON.stringify(updateData)
                                })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error(''Error updating record'');
                                    }
                                    return response.json();
                                })
                                .then(() => {
                                    // Create new diary entry
                                    const createUrl = ''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/diaries/records'';
                                    
                                    // Data for new diary entry
                                    const createData = {
                                        parent_id: ''%2$s'',
                                        diary_date: dueDateInput.value,
                                        status: ''Open''
                                    };
                                    
                                    return fetch(createUrl, {
                                        method: ''POST'',
                                        headers: {
                                            ''Content-Type'': ''application/json''
                                        },
                                        body: JSON.stringify(createData)
                                    });
                                })
                                .then(response => {
                                    if (!response.ok) {
                                        throw new Error(''Error creating new diary entry'');
                                    }
                                    return response.json();
                                })
                                .then(() => {
                                    // Show success message then reload the page
                                    formContainer.style.display = ''none'';
                                    statusContainer.style.display = ''block'';
                                    
                                    setTimeout(() => {
                                        window.location.reload();
                                    }, 1500);
                                })
                                .catch(error => {
                                    console.error(''Error:'', error);
                                    alert(''Error: '' + error.message);
                                    submitBtn.disabled = false;
                                    submitBtn.innerHTML = ''Save & Continue'';
                                });
                            })()"
                            class="btn btn-primary"
                        >
                            Save & Continue
                        </button>
                    </div>
                </div>
                
                <div id="statusContainer_%2$s" style="text-align:center; display:none;">
                    <svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="#4CAF50" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                        <polyline points="22 4 12 14.01 9 11.01"></polyline>
                    </svg>
                    <h2 style="color: #4CAF50; margin-top: 16px;">Re-diary successful!</h2>
                    <p>The diary has been re-diaried and a new record has been created.</p>
                </div>
            </div>
        </div>
    </div>
    ', 
    modal_id,        -- %1$s for modal ID references
    record_id        -- %2$s for record ID references
    );
END;

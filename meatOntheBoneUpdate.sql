DECLARE
    modal_id TEXT;
    record_id TEXT;
BEGIN
    record_id := rvn('Record ID');
    modal_id := 'modal_' || record_id;
    
    IF rvn('Meat on the Bone?') = true THEN
        -- MEAT ICON (when "Meat on the Bone?" is TRUE)
        RETURN format('
        <div>
            <style>
                .btn-icon {
                    background: rgba(139,92,246,0.1);
                    padding: 10px;
                    border-radius: 10px;
                    margin-right: 16px;
                    box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
                    position: relative;
                    z-index: 1;
                    border: none;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 40px;
                    height: 40px;
                }
                .btn-icon:hover {
                    background: rgba(139,92,246,0.15);
                }
            </style>

            <!-- Meat icon with onclick handler -->
            <button onclick="(function() {
                // Toggle from meat to bone by updating the database
                const url = ''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/xx9ctsclisfnns/records/%1$s'';
                const data = {
                    rts2a68b3tt5zn: false,  
                    wf9gp7lnzudg2p: ''''   
                };
                
                fetch(url, {
                    method: ''PUT'',
                    headers: {
                        ''Content-Type'': ''application/json''
                    },
                    body: JSON.stringify(data)
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error(''Network response was not ok'');
                    }
                    return response.json();
                })
                .then(() => {
                    // Reload the page to update the UI
                    window.location.reload();
                })
                .catch(error => {
                    console.error(''Error:'', error);
                    alert(''Error updating record. Please try again.'');
                });
            })()" class="btn-icon">
                <!-- Meat icon SVG -->
                <svg width="36" height="36" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg">
                    <path fill="#FFD983" d="M14.017 10.368L8.173 4.524a2.58 2.58 0 0 0-.15-3.479a2.59 2.59 0 0 0-3.662 0a2.584 2.584 0 0 0-.715 2.282a2.584 2.584 0 0 0-2.282.715a2.59 2.59 0 0 0 0 3.662a2.58 2.58 0 0 0 3.479.15l5.844 5.844l3.33-3.33zm11.918 11.919l5.845 5.844a2.58 2.58 0 0 1 3.479.15a2.587 2.587 0 0 1-2.282 4.377a2.587 2.587 0 0 1-4.377 2.281a2.58 2.58 0 0 1-.149-3.479l-5.845-5.844l3.329-3.329z"/>
                    <path fill="#C1694F" d="M30.021 15.879c-1.632-1.633-4.113-1.543-6.234-3.665c-2.121-2.121-2.032-4.602-3.665-6.235c-3.515-3.515-7.018-1.467-11.313 2.829c-4.296 4.296-6.343 7.799-2.829 11.313c1.633 1.633 4.114 1.544 6.235 3.665c2.122 2.121 2.032 4.603 3.665 6.234c3.515 3.515 7.018 1.468 11.314-2.828s6.341-7.798 2.827-11.313z"/>
                    <path fill="#662113" d="M14 23a1 1 0 0 1-.948-1.317c1.109-3.328 5.305-7.523 8.632-8.632a1 1 0 1 1 .633 1.897c-2.686.895-6.473 4.682-7.368 7.368c-.14.419-.53.684-.949.684z"/>
                </svg>
            </button>
        </div>
        ', 
        rvn('Record ID')   -- %1$s for record ID
        );
    ELSE
        -- BONE ICON (when "Meat on the Bone?" is FALSE)
        RETURN format('
        <div>
            <style>
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
                    padding: 20px;
                    width: 400px;
                    border-radius: 8px;
                }
                .btn-icon {
                    background: rgba(139,92,246,0.1);
                    padding: 10px;
                    border-radius: 10px;
                    margin-right: 16px;
                    box-shadow: inset 0 2px 4px rgba(0,0,0,0.05);
                    position: relative;
                    z-index: 1;
                    border: none;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    width: 40px;
                    height: 40px;
                }
                .btn-icon:hover {
                    background: rgba(139,92,246,0.15);
                }
                .input-field {
                    width: 100%%;
                    padding: 8px;
                    margin: 10px 0;
                    border: 1px solid #ddd;
                    border-radius: 4px;
                }
                .loader {
                    border: 16px solid #f3f3f3;
                    border-radius: 50%%;
                    border-top: 16px solid #3498db;
                    width: 120px;
                    height: 120px;
                    -webkit-animation: spin 2s linear infinite;
                    animation: spin 2s linear infinite;
                    display: none;
                    margin: 20px auto;
                }
                @keyframes spin {
                    0%% { transform: rotate(0deg); }
                    100%% { transform: rotate(360deg); }
                }
                .btn {
                    padding: 8px 16px;
                    border-radius: 4px;
                    border: none;
                    cursor: pointer;
                    margin-left: 10px;
                }
                .btn-primary {
                    background: #2563eb;
                    color: white;
                }
                .btn-secondary {
                    background: #e5e7eb;
                    color: #374151;
                }
            </style>

            <!-- Bone icon button -->
            <button onclick="document.getElementById(''%1$s'').style.display=''block''" class="btn-icon">
                <!-- Bone icon -->
                <svg width="36" height="36" viewBox="0 0 512.001 512.001">
                    <path d="M340.553,239.393c-3.328-3.329-8.727-3.329-12.058,0L197.743,370.146c-1.615,1.613-2.514,3.809-2.498,6.091
                    c0.017,2.283,0.947,4.464,2.584,6.054l0.682,0.648c25.576,25.577,25.576,67.193,0,92.77c-25.577,25.576-67.194,25.577-92.77,0
                    c-11.314-11.314-18.087-26.346-19.07-42.327c-0.264-4.297-3.691-7.722-7.987-7.987c-15.981-0.983-31.012-7.756-42.327-19.07
                    c-22.684-22.683-25.713-58.11-7.205-84.238c2.722-3.843,1.813-9.165-2.029-11.888c-3.842-2.722-9.165-1.813-11.888,2.029
                    c-23.328,32.932-19.517,77.578,9.062,106.156c12.54,12.54,28.703,20.654,46.115,23.271c2.617,17.412,10.731,33.575,23.27,46.115
                    c16.114,16.115,37.276,24.172,58.444,24.17c21.164-0.001,42.333-8.058,58.445-24.17c30.448-30.448,32.13-78.934,5.042-111.375
                    l124.942-124.942C343.884,248.121,343.884,242.722,340.553,239.393z
                    M487.832,93.618c-12.54-12.54-28.703-20.654-46.115-23.27c-2.617-17.412-10.731-33.575-23.27-46.115
                    c-32.226-32.226-84.662-32.226-116.889,0c-30.446,30.446-32.13,78.929-5.042,111.373l-160.85,160.85
                    c-27.549-22.933-67.62-25.639-98.033-5.795c-3.944,2.573-5.056,7.857-2.482,11.801c2.573,3.945,7.858,5.056,11.801,2.482
                    c25.797-16.827,60.355-13.209,82.174,8.608l0.648,0.682c1.591,1.637,3.771,2.568,6.054,2.584c0.02,0,0.041,0,0.061,0
                    c2.26,0,4.43-0.898,6.029-2.498l172.468-172.465c1.615-1.615,2.514-3.809,2.498-6.091c-0.017-2.283-0.947-4.464-2.584-6.054
                    l-0.682-0.647c-25.576-25.577-25.576-67.194,0-92.77c25.577-25.576,67.194-25.576,92.77,0
                    c11.314,11.315,18.087,26.346,19.07,42.327c0.264,4.297,3.691,7.723,7.987,7.987c15.981,0.983,31.013,7.756,42.327,19.07
                    c25.576,25.577,25.576,67.193,0,92.77c-25.576,25.576-67.193,25.576-92.77,0l-0.648-0.682c-1.591-1.637-3.771-2.568-6.054-2.584
                    c-2.298,0.01-4.477,0.883-6.091,2.498l-21.906,21.906c-3.33,3.33-3.33,8.73,0,12.059c3.33,3.33,8.73,3.33,12.06,0l16.095-16.095
                    c32.439,27.087,80.925,25.406,111.375-5.042C520.058,178.281,520.058,125.844,487.832,93.618z" 
                    fill="#000000"/>
                </svg>
            </button>

            <!-- Modal dialog -->
            <div id="%1$s" class="modal">
                <div class="modal-content">
                    <div id="formContainer_%2$s">
                        <h2>Please provide Meat on the Bone Details.</h2>
                        <div class="form-group">
                            <input 
                                type="text" 
                                id="meatInput_%2$s" 
                                class="input-field form-control" 
                                placeholder="Enter details..."
                                autofocus
                            >
                        </div>
                        <div style="margin-top: 20px; text-align: right;">
                            <button onclick="document.getElementById(''%1$s'').style.display=''none''" class="btn btn-secondary">
                                Cancel
                            </button>
                            <button 
                                onclick="(function() {
                                    const input = document.getElementById(''meatInput_%2$s'');
                                    const formContainer = document.getElementById(''formContainer_%2$s'');
                                    const statusContainer = document.getElementById(''statusContainer_%2$s'');
                                    
                                    if (!input.value.trim()) {
                                        alert(''Please enter meat details'');
                                        input.focus();
                                        return;
                                    }

                                    // Show loader, hide form
                                    formContainer.style.display = ''none'';
                                    statusContainer.style.display = ''block'';

                                    const inputValue = input.value.trim();
                                    
                                    // API endpoint for PUT request
                                    const url = ''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/xx9ctsclisfnns/records/%2$s'';
                                    
                                    // Data to update
                                    const data = {
                                        rts2a68b3tt5zn: true,
                                        wf9gp7lnzudg2p: inputValue
                                    };

                                    fetch(url, {
                                        method: ''PUT'',
                                        headers: {
                                            ''Content-Type'': ''application/json''
                                        },
                                        body: JSON.stringify(data)
                                    })
                                    .then(response => {
                                        if (!response.ok) {
                                            throw new Error(''Network response was not ok'');
                                        }
                                        return response.json();
                                    })
                                    .then(() => {
                                        // Reload the page to update the UI
                                        window.location.reload();
                                    })
                                    .catch(error => {
                                        console.error(''Error:'', error);
                                        alert(''Error updating record. Please try again.'');
                                        formContainer.style.display = ''block'';
                                        statusContainer.style.display = ''none'';
                                    });
                                })()"
                                class="btn btn-primary"
                            >
                                Submit
                            </button>
                        </div>
                    </div>
                    
                    <div id="statusContainer_%2$s" style="text-align:center; display:none;">
                        <h2>Updating data, please wait...</h2>
                        <div class="loader" style="display:block;"></div>
                    </div>
                </div>
            </div>
        </div>
        ', 
        modal_id,          -- %1$s for modal ID references
        rvn('Record ID')   -- %2$s for record ID references
        );
    END IF;
END;
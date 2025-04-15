DECLARE
    api_base_url TEXT := 'https://uwyo.highsystems.io/api/rest/v1/applications/yoe8ft23a3jtpg/tables/zaalzpv1d5yn0z/records';
    current_user_name TEXT := (hs_current_user->>'email')::TEXT; 
    venture_name TEXT := (rvn('Venture Name'))::TEXT;
    related_venture TEXT := (rvn('Record ID'))::TEXT;
    button_id TEXT := 'submit_' || related_venture;
    current_date_formatted TEXT := to_char(CURRENT_DATE, 'YYYY/MM/DD');
BEGIN
    RETURN format('
    <div>
        <style>
            /* Button style */
            .survey-btn {
                background-color: #4a86e8;
                color: white;
                padding: 10px 18px;
                border-radius: 4px;
                border: none;
                cursor: pointer;
                font-size: 14px;
                font-weight: 500;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                transition: background-color 0.2s ease;
            }
            
            .survey-btn:hover {
                background-color: #3a76d8;
            }
            
            /* Modal styles */
            .survey-modal {
                display: none;
                position: fixed;
                z-index: 9999;
                left: 0;
                top: 0;
                width: 100%%;
                height: 100%%;
                overflow: auto;
                background-color: rgba(0,0,0,0.5);
            }
            
            .modal-content {
                background-color: #fefefe;
                margin: 10%% auto;
                padding: 25px;
                border: 1px solid #e0e0e0;
                width: 500px;
                max-width: 90%%;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            }
            
            .modal-header {
                margin-bottom: 20px;
            }
            
            .modal-header h2 {
                margin: 0;
                color: #333;
                font-size: 20px;
                font-weight: 600;
            }
            
            .modal-description {
                font-size: 14px;
                color: #666;
                margin-bottom: 25px;
            }
            
            /* Form styles */
            .form-group {
                margin-bottom: 20px;
            }
            
            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #333;
            }
            
            .form-group input[type="text"] {
                width: 100%%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
            }
            
            /* Rating scale styles */
            .rating-scale {
                margin: 20px 0;
            }
            
            .rating-numbers {
                display: flex;
                justify-content: space-between;
                width: 250px;
                margin-bottom: 5px;
            }
            
            .rating-options {
                display: flex;
                align-items: center;
            }
            
            .rating-label {
                margin: 0 10px;
                color: #666;
                font-size: 14px;
            }
            
            .radio-group {
                display: flex;
                justify-content: space-between;
                width: 250px;
            }
            
            .radio-group input[type="radio"] {
                margin: 0;
                cursor: pointer;
            }
            
            /* Comments area */
            .form-group textarea {
                width: 100%%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                min-height: 80px;
                resize: vertical;
            }
            
            /* Button group */
            .button-group {
                text-align: right;
                margin-top: 25px;
                display: flex;
                justify-content: flex-end;
            }
            
            .button {
                padding: 10px 18px;
                border-radius: 4px;
                margin-left: 10px;
                cursor: pointer;
                border: none;
                font-size: 14px;
                font-weight: 500;
            }
            
            .button-secondary {
                background-color: #f0f0f0;
                color: #333;
            }
            
            .button-secondary:hover {
                background-color: #e5e5e5;
            }
            
            .button-primary {
                background-color: #4a86e8;
                color: white;
            }
            
            .button-primary:hover {
                background-color: #3a76d8;
            }
            
            /* Required field indicator */
            .required {
                color: #e53e3e;
                margin-left: 2px;
            }
            
            /* Date picker styles */
            input[type="date"] {
                position: relative;
                padding: 8px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 14px;
                cursor: pointer;
                min-width: 150px;
            }
            
            .loader {
                border: 3px solid #f3f3f3;
                border-radius: 50%%;
                border-top: 3px solid #3498db;
                width: 20px;
                height: 20px;
                -webkit-animation: spin 2s linear infinite;
                animation: spin 2s linear infinite;
                display: none;
                margin: 0 auto;
            }
            @keyframes spin {
                0%% { transform: rotate(0deg); }
                100%% { transform: rotate(360deg); }
            }
        </style>
        
        <!-- Add Flatpickr CSS and JS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        
        <!-- Button to open the modal -->
        <button class="survey-btn" onclick="
            // Display the modal
            document.getElementById(''surveyModal'').style.display = ''block'';
            
            // Set the date value
            document.getElementById(''session_date'').value = ''%1$s'';
        ">
            Entrepreneur Post Meeting Survey
        </button>
        
        <!-- The Modal -->
        <div id="surveyModal" class="survey-modal">
            <div class="modal-content">
                <div class="modal-header">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <h2>VMS Mentoring Session Survey</h2>
                        <div class="form-group" style="margin: 0;">
                            <label for="session_date" style="font-size: 14px;">Date <span class="required">*</span></label>
                            <input type="text" id="session_date" required value="%1$s" style="padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; width: 100px;">
                        </div>
                    </div>
                </div>
                
                <div class="modal-description">
                    Your response can help us ensure continuous improvement by taking just a moment or two to complete this short survey. Thank you!
                </div>
                
                <div class="form-group">
                    <label for="name">Your Name <span class="required">*</span></label>
                    <input type="text" id="name" required value="%2$s" readonly>
                </div>
                
                <div class="form-group">
                    <label for="venture_name">The name of the venture <span class="required">*</span></label>
                    <input type="text" id="venture_name" placeholder="use TBD if still unnamed" required value="%3$s" readonly>
                </div>
                
                <div class="form-group">
                    <label>Please tell us how you would rate the mentoring session you just had <span class="required">*</span></label>
                    <div class="rating-scale">
                        <div class="rating-numbers">
                            <span>1</span>
                            <span>2</span>
                            <span>3</span>
                            <span>4</span>
                            <span>5</span>
                        </div>
                        <div class="rating-options">
                            <span class="rating-label">Low</span>
                            <div class="radio-group">
                                <input type="radio" name="rating" value="1" id="rating1">
                                <input type="radio" name="rating" value="2" id="rating2">
                                <input type="radio" name="rating" value="3" id="rating3">
                                <input type="radio" name="rating" value="4" id="rating4">
                                <input type="radio" name="rating" value="5" id="rating5">
                            </div>
                            <span class="rating-label">High</span>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="comments">Any additional comments on what you found most helpful and anything that could be improved</label>
                    <textarea id="comments" placeholder="Please feel free to be candid."></textarea>
                </div>
                
                <div class="button-group">
                    <button class="button button-secondary" onclick="document.getElementById(''surveyModal'').style.display=''none'';">
                        Cancel
                    </button>
                    <button class="button button-primary" onclick="
                        // Get form values
                        var rating = document.querySelector(''input[name=rating]:checked'');
                        var comments = document.getElementById(''comments'').value;
                        var sessionDate = document.getElementById(''session_date'').value;
                        
                        // Validation
                        if (!rating) {
                            alert(''Please select a rating'');
                            return;
                        }
                        
                        // Create data object
                        var data = {
                            ugju7ra635onam: parseInt(rating.value),
                            cj5gjv434hspmh: comments || '''',
                            vbcn3j06y6v4t4: ''%4$s'',
                            cqrfm5uzy9qcso: sessionDate
                        };
                        
                        // API call
                        fetch(''%5$s'', {
                            method: ''POST'',
                            headers: {''Content-Type'': ''application/json''},
                            body: JSON.stringify(data)
                        })
                        .then(function(response) { return response.json(); })
                        .then(function() {
                            alert(''Thank you for your feedback!'');
                            document.getElementById(''surveyModal'').style.display = ''none'';
                            
                            // Refresh the page after a short delay (to allow the alert to be seen)
                            setTimeout(function() {
                                window.location.reload();
                            }, 1000);
                        })
                        .catch(function() {
                            alert(''Error submitting survey. Please try again.'');
                        });
                    ">
                        Submit
                    </button>
                </div>
            </div>
        </div>
    </div>
    ',
    current_date_formatted,  -- %1$s: For date in YYYY/MM/DD format
    current_user_name,       -- %2$s: For the name input value
    venture_name,            -- %3$s: For the venture name input value
    related_venture,         -- %4$s: For the related_venture JavaScript variable
    api_base_url             -- %5$s: API base URL
    );
END;


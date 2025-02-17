DECLARE
    button_id TEXT;
    record_id TEXT;
    user_email TEXT;
BEGIN
    record_id := rvn('Record ID');
    button_id := 'star_' || record_id;
    user_email := hs_current_user->>'id';
    
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
        </style>

        <div id="star_container_%1$s">
            <button 
                id="%1$s"
                onclick="(function() {
                    const buttonContainer = document.getElementById(''star_container_%1$s'');
                    const loader = document.getElementById(''loader_%1$s'');
                    
                    // Show loader
                    buttonContainer.style.display = ''none'';
                    loader.style.display = ''block'';
                    
                    const data = {
                        uknft94hxqvjkk: ''%2$s'',
                        hafx38z1srugta: ''%3$s''
                    };

                    fetch(''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/%4$s/records'', {
                        method: ''POST'',
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
                        window.location.href = ''https://jag.highsystems.io/apps/eqj90dan6huihq/tables/xx9ctsclisfnns/records/view/%2$s'';
                    })
                    .catch(error => {
                        console.error(''Error:'', error);
                        alert(''Error starring record. Please try again.'');
                        buttonContainer.style.display = ''block'';
                        loader.style.display = ''none'';
                    });
                })()"
                class="btn-icon"
                style="background: none; border: none; padding: 0; cursor: pointer;"
            >
                <svg width="36" height="36" viewBox="0 0 36 36" xmlns="http://www.w3.org/2000/svg">
                    <path d="M28.84 17.638c-.987 1.044-1.633 3.067-1.438 4.493l.892 6.441c.197 1.427-.701 2.087-1.996 1.469l-5.851-2.796c-1.295-.62-3.408-.611-4.7.018l-5.826 2.842c-1.291.629-2.193-.026-2.007-1.452l.843-6.449c.186-1.427-.475-3.444-1.47-4.481l-4.494-4.688c-.996-1.037-.655-2.102.755-2.365l6.37-1.188c1.41-.263 3.116-1.518 3.793-2.789L16.762.956c.675-1.271 1.789-1.274 2.473-.009L22.33 6.66c.686 1.265 2.4 2.507 3.814 2.758l6.378 1.141c1.412.252 1.761 1.314.774 2.359l-4.456 4.72z" fill="#FFAC33"/>
                    <path d="M9.783 2.181c1.023 1.413 2.446 4.917 1.717 5.447c-.728.531-3.607-1.91-4.63-3.323c-1.022-1.413-.935-2.668-.131-3.254c.804-.587 2.02-.282 3.044 1.13zm19.348 2.124C28.109 5.718 25.23 8.16 24.5 7.627c-.729-.53.695-4.033 1.719-5.445C27.242.768 28.457.463 29.262 1.051c.803.586.89 1.841-.131 3.254zM16.625 33.291c-.001-1.746.898-5.421 1.801-5.421c.897 0 1.798 3.675 1.797 5.42c0 1.747-.804 2.712-1.8 2.71c-.994.002-1.798-.962-1.798-2.709zm16.179-9.262c-1.655-.539-4.858-2.533-4.579-3.395c.277-.858 4.037-.581 5.69-.041c1.655.54 2.321 1.605 2.013 2.556c-.308.95-1.469 1.42-3.124.88zM2.083 20.594c1.655-.54 5.414-.817 5.694.044c.276.857-2.928 2.854-4.581 3.392c-1.654.54-2.818.07-3.123-.88c-.308-.95.354-2.015 2.01-2.556z" fill="#FFD983"/>
                </svg>
            </button>
        </div>

        <div id="loader_%1$s" style="text-align:center; display:none;">
            <div class="loader"></div>
        </div>
    </div>
    ',
    button_id,          -- %1$s for button ID references
    record_id,          -- %2$s for record ID
    user_email,         -- %3$s for user email
    tid('Stared Claims') -- %4$s for table ID
    );
END;
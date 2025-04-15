CREATE OR REPLACE FUNCTION lock_unlock_order()
RETURNS TEXT AS $$
DECLARE
    record_id TEXT;
    current_status TEXT;
    current_user_id TEXT;
    lock_user TEXT;

BEGIN
    record_id := rvn('Record ID');
    current_user_id := (hs_current_user->>'id');
    lock_user := rvn('Lock User');
    
    -- When lock_user field is empty, show Lock icon (to allow locking)
    IF lock_user = '' THEN
        RAISE NOTICE 'Lock user is empty - Showing LOCK button';
        RETURN format('
        <div>
            <style>
                .btn-icon {
                    background: none;
                    border: none;
                    cursor: pointer;
                    padding: 0;
                }
                .btn-icon:hover {
                    transform: scale(1.05);
                    transition: transform 0.2s;
                }
            </style>

            <button onclick="(function() {
                const url = ''https://jag.highsystems.io/api/rest/v1/applications/eqj90dan6huihq/tables/xx9ctsclisfnns/records/%1$s'';
                const data = {
                    vwnr7bup7g8y76: ''%2$s''
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
                    window.location.reload();
                })
                .catch(error => {
                    console.error(''Error:'', error);
                    alert(''Error updating record. Please try again.'');
                });
            })()" class="btn-icon" title="Lock Claim">
                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 32 32" fill="none">
                    <path d="M27 14V20C27 26.08 22.08 31 16 31C9.92 31 5 26.08 5 20V14C5 13.44 5.45 13 6 13H11H21H26C26.59 13 27 13.47 27 14Z" fill="#FFC44D"/>
                    <path d="M16 21C16.55 21 17 20.55 17 20C17 19.45 16.55 19 16 19C15.45 19 15 19.45 15 20C15 20.55 15.45 21 16 21Z" fill="#668077"/>
                    <path d="M16 21V23M16 21C15.447 21 15 20.553 15 20C15 19.447 15.447 19 16 19C16.553 19 17 19.447 17 20C17 20.553 16.553 21 16 21ZM18 13H11V6C11 3.238 13.238 1 16 1C18.762 1 21 3.238 21 6V13H26C26.594 13 27 13.469 27 14V20C27 26.075 22.075 31 16 31C9.925 31 5 26.075 5 20V14C5 13.437 5.453 13 6 13H8" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
        </div>
        ', 
        record_id,
        current_user_id
        );
    ELSE
        -- When lock_user is not empty, show Unlock icon (to allow unlocking)
        RAISE NOTICE 'Lock user is not empty - Showing UNLOCK button';
        RETURN format('
        <div>
            <style>
                .btn-icon {
                    background: none;
                    border: none;
                    cursor: pointer;
                    padding: 0;
                }
                .btn-icon:hover {
                    transform: scale(1.05);
                    transition: transform 0.2s;
                }
            </style>

            <button onclick="(function() {
                const url = ''https://portal-dev.diversifiedrecoverysolutions.net/api/rest/v1/applications/eqj90dan6huihq/tables/ekqxad89ocsv85/records/%1$s'';
                const data = {
                        vwnr7bup7g8y76: ''''
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
                    window.location.reload();
                })
                .catch(error => {
                    console.error(''Error:'', error);
                    alert(''Error updating record. Please try again.'');
                });
            })()" class="btn-icon" title="Unlock Claim">
                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 32 32" fill="none">
                    <path d="M27 14V20C27 26.08 22.08 31 16 31C9.92 31 5 26.08 5 20V14C5 13.44 5.45 13 6 13H11H21H26C26.59 13 27 13.47 27 14Z" fill="#FFC44D"/>
                    <path d="M16 21C16.55 21 17 20.55 17 20C17 19.45 16.55 19 16 19C15.45 19 15 19.45 15 20C15 20.55 15.45 21 16 21Z" fill="#668077"/>
                    <path d="M16 21V23M16 21C15.447 21 15 20.553 15 20C15 19.447 15.447 19 16 19C16.553 19 17 19.447 17 20C17 20.553 16.553 21 16 21ZM1 9V6C1 3.238 3.238 1 6 1C8.762 1 11 3.238 11 6V13H26C26.594 13 27 13.469 27 14V20C27 26.075 22.075 31 16 31C9.925 31 5 26.075 5 20V14C5 13.437 5.453 13 6 13H8" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
        </div>
        ', 
        record_id
        );
    END IF;
END;
$$ LANGUAGE plpgsql;

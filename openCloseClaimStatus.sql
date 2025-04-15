DECLARE
    record_id TEXT;
    current_status TEXT;
BEGIN
    record_id := rvn('Record ID');
    current_status := rvn('Claim Status');
    
    -- Debug logging with string length and trimmed value
    RAISE NOTICE 'Record ID: %, Current Status: [%], Length: %', 
        record_id, 
        current_status, 
        length(current_status);
    
    -- When status is 'Open', show CLOSE icon
    IF TRIM(current_status) = 'Open' THEN
        RAISE NOTICE 'Status matches Open - Showing CLOSE button';
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
                    lo6eyr1nmnhm2c: ''Closed''
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
            })()" class="btn-icon" title="Close Claim">
                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 505 505">
                    <path style="fill:#90DFAA;" d="M505,252.5C505,392,392,505,252.5,505C113.1,505,0,392,0,252.5C0,113.1,113.1,0,252.5,0 C392,0,505,113.1,505,252.5z"/>
                    <path style="fill:#324A5E;" d="M366.5,213.9c-2.4,0-4.7-0.9-6.5-2.7L252.5,103.7L145.1,211.2c-3.6,3.6-9.4,3.6-13,0s-3.6-9.4,0-13 l114-114c1.7-1.7,4.1-2.7,6.5-2.7l0,0c2.4,0,4.8,1,6.5,2.7l114,114c3.6,3.6,3.6,9.4,0,13C371.2,213,368.8,213.9,366.5,213.9z"/>
                    <g>
                        <path style="fill:#FFFFFF;" d="M396,382.6H109c-1.2,0-2.2-1-2.2-2.2V183.6c0-1.2,1-2.2,2.2-2.2h286.9c1.2,0,2.2,1,2.2,2.2v196.7 C398.2,381.6,397.2,382.6,396,382.6z"/>
                        <circle style="fill:#FFFFFF;" cx="252.5" cy="96.7" r="30.3"/>
                    </g>
                    <circle style="fill:#FFD05B;" cx="252.5" cy="96.7" r="17.6"/>
                    <g>
                        <path style="fill:#FF7058;" d="M171.5,295.6c4.8,0,8.8-1.9,11.9-5.7l6.3,6.5c-5,5.6-10.9,8.4-17.7,8.4s-12.4-2.1-16.8-6.4 c-4.4-4.3-6.6-9.7-6.6-16.2s2.2-12,6.7-16.4s9.9-6.6,16.4-6.6c7.2,0,13.3,2.8,18.2,8.3l-6.1,6.9c-3.1-3.9-7-5.8-11.6-5.8 c-3.7,0-6.9,1.2-9.5,3.6s-3.9,5.7-3.9,9.8c0,4.1,1.2,7.4,3.7,9.9C164.9,294.4,167.9,295.6,171.5,295.6z"/>
                        <path style="fill:#FF7058;" d="M197.4,304.3v-44.1h9.8v35.3H226v8.8H197.4z"/>
                        <path style="fill:#FF7058;" d="M269.1,298.2c-4.5,4.4-9.9,6.5-16.5,6.5c-6.5,0-12-2.2-16.5-6.5c-4.5-4.4-6.7-9.8-6.7-16.2 c0-6.5,2.2-11.9,6.7-16.2c4.5-4.4,9.9-6.5,16.5-6.5c6.5,0,12,2.2,16.5,6.5c4.5,4.4,6.7,9.8,6.7,16.2 C275.8,288.5,273.5,293.9,269.1,298.2z M265.7,282c0-3.9-1.3-7.3-3.8-10.1c-2.5-2.8-5.6-4.2-9.3-4.2c-3.7,0-6.8,1.4-9.3,4.2 c-2.5,2.8-3.8,6.1-3.8,10.1c0,3.9,1.3,7.3,3.8,10c2.5,2.8,5.6,4.1,9.3,4.1c3.7,0,6.8-1.4,9.3-4.1 C264.5,289.3,265.7,285.9,265.7,282z"/>
                        <path style="fill:#FF7058;" d="M294,269c-0.9,0.8-1.4,1.8-1.4,3.1c0,1.3,0.6,2.3,1.7,3.1c1.2,0.8,3.8,1.7,8,2.7s7.4,2.6,9.7,4.6 c2.3,2.1,3.5,5.1,3.5,9c0,4-1.5,7.2-4.4,9.6c-3,2.5-6.9,3.7-11.7,3.7c-7,0-13.3-2.6-18.9-7.8l5.9-7.2c4.8,4.2,9.1,6.2,13.2,6.2 c1.8,0,3.2-0.4,4.3-1.2c1-0.8,1.5-1.8,1.5-3.2c0-1.3-0.5-2.4-1.6-3.2c-1.1-0.8-3.3-1.6-6.5-2.4c-5.1-1.2-8.9-2.8-11.3-4.8 s-3.6-5-3.6-9.2s1.5-7.4,4.5-9.7c3-2.3,6.8-3.4,11.3-3.4c2.9,0,5.9,0.5,8.8,1.5s5.5,2.4,7.7,4.3l-5,7.2c-3.8-2.9-7.8-4.3-11.9-4.3 C296.3,267.9,295,268.2,294,269z"/>
                        <path style="fill:#FF7058;" d="M355.7,260.2v8.8h-21.9v9.1h19.7v8.4h-19.7v9.1h22.6v8.7h-32.5v-44.1H355.7z"/>
                    </g>
                </svg>
            </button>
        </div>
        ', 
        record_id
        );
    ELSE
        RAISE NOTICE 'Status does not match Open - Showing OPEN button';
        -- For any other status (NULL, empty, or 'Closed'), show OPEN icon
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
                    lo6eyr1nmnhm2c: ''Open''
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
            })()" class="btn-icon" title="Open Claim">
                <svg xmlns="http://www.w3.org/2000/svg" width="80" height="80" viewBox="0 0 200 200">
                    <!-- Background square -->
                    <rect width="200" height="200" fill="#F8E192" rx="10" ry="10"/>
                    
                    <!-- Shadow -->
                    <polygon points="180,80 180,180 130,180" fill="#DBAE40" opacity="0.5"/>
                    
                    <!-- String/Hanger -->
                    <path d="M100,40 L70,60 L130,60 Z" fill="none" stroke="#333333" stroke-width="2"/>
                    
                    <!-- Open Sign -->
                    <rect x="50" y="70" width="100" height="50" rx="5" ry="5" fill="#F04D34"/>
                    <rect x="54" y="74" width="92" height="42" rx="3" ry="3" fill="#F04D34" stroke="#FFFFFF" stroke-width="2"/>
                    
                    <!-- OPEN text -->
                    <text x="100" y="105" font-family="Arial, sans-serif" font-size="30" font-weight="bold" text-anchor="middle" fill="#FFFFFF">OPEN</text>
                </svg>
            </button>
        </div>
        ', 
        record_id
        );
    END IF;
END;

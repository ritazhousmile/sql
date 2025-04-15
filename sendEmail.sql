CREATE OR REPLACE FUNCTION send_email()
RETURNS TEXT AS $$
DECLARE
    subject TEXT := 'Claim Information';
    body TEXT := 'Please review the attached claim information.%0D%0A%0D%0AThank you,%0D%0AThe Claims Team';
BEGIN
    -- Simple button with an inline SVG icon and correct mailto format
    RETURN '<a href="mailto:Katie.V.Alexander@erac.com?cc=lucas.l.thornton@em.com; Michelle.M.Tarafa@em.com; Sara.Sheppard@em.com&subject=' || subject || '&body=' || body || '" style="display:inline-flex; align-items:center; background-color:#507C5C; color:white; padding:8px 12px; border-radius:4px; text-decoration:none; font-family:Arial, sans-serif;">' ||
           '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" style="margin-right:6px; fill:white;"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"/></svg>' ||
           'Email Claim</a>';
END;
$$ LANGUAGE plpgsql;

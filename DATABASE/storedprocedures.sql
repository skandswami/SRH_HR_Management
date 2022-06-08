-- PROCEDURE: public.sp_create_hruser(character varying, character varying, character varying)

DROP PROCEDURE IF EXISTS public.sp_create_hruser(character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.sp_create_hruser(
	IN username character varying,
	IN password character varying,
	IN email character varying)
LANGUAGE 'plpgsql'
AS $BODY$
begin
    insert into "HR_user" ("username", "email", "password")
    values (username, email, password); 
end;
$BODY$;

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

-- PROCEDURE: public.sp_emp_appraisal(integer,integer,integer,integer,character varying)

DROP PROCEDURE IF EXISTS public.sp_emp_appraisal(integer,integer,integer,integer,character varying);

CREATE OR REPLACE PROCEDURE public.sp_emp_appraisal(
	IN Emp_perfomance_id integer,
	IN Employee_Id integer,
	IN Emp_rating integer,
    IN Manager_rating integer,
    IN Remarks character varying)

LANGUAGE 'plpgsql'
AS $BODY$
begin
    insert into "Employee_Performance_table" ("Emp_Performance_ID", "Employee_ID", "Emp_rating","Manager_rating","Remarks")
    values (Emp_perfomance_id, Employee_Id, Emp_rating,Manager_rating,Remarks); 
end;
$BODY$;


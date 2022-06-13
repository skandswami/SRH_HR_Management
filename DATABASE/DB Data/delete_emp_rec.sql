-- PROCEDURE: public.delete_emp_rec(integer)

DROP PROCEDURE IF EXISTS public.delete_emp_rec(integer);

CREATE OR REPLACE PROCEDURE public.delete_emp_rec(
	IN employee_id integer)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
	DELETE FROM public."Employee_table" 
	UPDATE public"Employee_table"
           SET "JOB_ID" =NULL;
		   
	WHERE Employee_table.Employee_ID = employee_id;
END; 
$BODY$;
ALTER PROCEDURE public.delete_emp_rec(integer)
    OWNER TO postgres;

-- PROCEDURE: public.cr_new_emp(integer, text, character varying, character varying, character varying, character varying, text, character varying, integer, character varying, character varying)

-- DROP PROCEDURE IF EXISTS public.cr_new_emp(integer, text, character varying, character varying, character varying, character varying, text, character varying, integer, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.cr_new_emp(
	IN employee_id integer,
	IN Job_id int,
	IN First_Name character varying,
	IN Middle_Name character varying,
	IN Last_Name character varying,
	IN email character varying,
	IN mobile text,
	IN date_of_joining date,
	IN date_of_leaving date,
	IN Manager_id int
	IN Gender character varying,
	IN Accrued_leaves int,
	IN shift_code int,
	IN dept_no int,
	IN emp_type"_id int
)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	INSERT into "Employee_table"(
		    "Employee_ID","Job_ID","First_Name",
		    "Middle_Name","Last_Name","Email",
		    "Mobile","Date_of_joining","Date_of_leaving",
            "Manager_ID","Gender","Accrued_leaves",
            "Shift_code","Dept_no.","Emp_Type_ID ")
			
values (Employee_ID,Job_ID,First_Name,
		    Middle_Name,Last_Name,Email,
		    Mobile,Date_of_joining,Date_of_leaving,
            Manager_ID,Gender,Accrued_leaves,
            Shift_code,Dept_no.,Emp_Type_ID);
		
end;
$BODY$;
ALTER PROCEDURE public.personal_data_emp(integer, text, character varying, character varying, character varying, character varying, text, character varying, integer, character varying, character varying)
    OWNER TO postgres;

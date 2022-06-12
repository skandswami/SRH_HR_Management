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


-- PROCEDURE: public.sp_create_employeeuser(character varying, character varying, character varying, integer)

-- DROP PROCEDURE IF EXISTS public.sp_create_employeeuser(character varying, character varying, character varying, integer);

CREATE OR REPLACE PROCEDURE public.sp_create_employeeuser(
	IN username character varying,
	IN password character varying,
	IN email character varying,
	IN empid integer)
LANGUAGE 'plpgsql'
AS $BODY$
begin
    insert into "Employee_Login" ("username", "email", "password", "Employee_Id")
    values (username, email, password, empid); 
end;
$BODY$;

CREATE OR REPLACE PROCEDURE public.add_leave_type(
	IN leave_code character varying,
	IN leave_description character varying,
	IN maxleaves integer)
LANGUAGE 'plpgsql'
AS $BODY$
begin
    insert into "Employee_Login" ("Leaves_code", "Leaves_Type_Desct", "Total_Applicable")
    values (leave_code, leave_description, maxleaves); 
end;
$BODY$;
-- PROCEDURE: public.sp_emp_appraisal_view(integer,integer,integer,integer,character varying)

CREATE OR REPLACE PROCEDURE public.sp_emp_appraisal_view(
	IN Employee_Id integer,
	OUT Emp_perfomance_id integer,
	OUT Emp_rating integer,
    OUT Manager_rating integer,
    OUT Remarks character varying)

LANGUAGE 'plpgsql'
AS $BODY$
begin
    select  "Emp_Performance_ID", 
			"Emp_rating",
			"Manager_rating",
			"Remarks"
	from public."Employee_Performance_table" 
	INTO Emp_perfomance_id, Emp_rating, Manager_rating, Remarks
	where "Employee_Performance_table"."Employee_ID"= Employee_Id;

end;
$BODY$;  

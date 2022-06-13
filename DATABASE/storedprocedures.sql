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

-- PROCEDURE: public.sp_edit_employee(character varying, character varying, character varying)

CREATE OR REPLACE PROCEDURE public.sp_edit_employee(
	IN employeeid integer,
	IN firstname character varying,
	IN middlename character varying,
	IN lastname character varying,
	IN gender character varying,
	IN emptype integer)
LANGUAGE 'plpgsql'
AS $BODY$
begin
update "Employee_table"
Set "First_Name" = firstname, "Middle_Name" = middlename, "Last_Name" = lastname, "Gender" = gender, "Emp_Type_ID" = emptype
where "Employee_ID" = employeeid;
    --insert into "Employee_table" ("First_Name", "Middle_Name", "Last_Name","Gender","Emp_Type")
    --values (firstname, middlename, lastname, gender, emptype); 
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

-- PROCEDURE: public.add_leave_type(character varying, character varying, integer)

-- DROP PROCEDURE IF EXISTS public.add_leave_type(character varying, character varying, integer);

CREATE OR REPLACE PROCEDURE public.add_leave_type(
	IN leave_code character varying,
	IN leave_description character varying,
	IN maxleaves integer)
LANGUAGE 'plpgsql'
AS $BODY$
begin
    insert into "Leaves_table" ("Leave_code", "Leave_Type_Desct", "Total_Applicable")
    values (leave_code, leave_description, maxleaves); 
end;
$BODY$;
ALTER PROCEDURE public.add_leave_type(character varying, character varying, integer)
    OWNER TO skand;

-- PROCEDURE: public.view_empinfo(integer, integer, character varying, character varying, character varying, character varying, character varying, date, integer, character varying, integer, integer, integer, integer, character varying, character varying, character varying, integer, character varying, character varying, date, character varying, character varying, character varying, integer, character varying, integer, character varying)

-- DROP PROCEDURE IF EXISTS public.view_empinfo(integer, integer, character varying, character varying, character varying, character varying, character varying, date, integer, character varying, integer, integer, integer, integer, character varying, character varying, character varying, integer, character varying, character varying, date, character varying, character varying, character varying, integer, character varying, integer, character varying);

CREATE OR REPLACE PROCEDURE public.view_empinfo(
	INOUT employee_id integer DEFAULT NULL::integer,
	INOUT job_id integer DEFAULT NULL::integer,
	INOUT first_name character varying DEFAULT NULL::character varying,
	INOUT middle_name character varying DEFAULT NULL::character varying,
	INOUT last_name character varying DEFAULT NULL::character varying,
	INOUT email character varying DEFAULT NULL::character varying,
	INOUT mobile character varying DEFAULT NULL::character varying,
	INOUT date_of_joining date DEFAULT NULL::date,
	INOUT manager_id integer DEFAULT NULL::integer,
	INOUT gender character varying DEFAULT NULL::character varying,
	INOUT accrued_leaves integer DEFAULT NULL::integer,
	INOUT shift_code integer DEFAULT NULL::integer,
	INOUT dept_no integer DEFAULT NULL::integer,
	INOUT emp_type_id integer DEFAULT NULL::integer,
	INOUT marital_status character varying DEFAULT NULL::character varying,
	INOUT qualification character varying DEFAULT NULL::character varying,
	INOUT last_employer_address character varying DEFAULT NULL::character varying,
	INOUT last_employer_contact integer DEFAULT NULL::integer,
	INOUT previous_role character varying DEFAULT NULL::character varying,
	INOUT tax_id character varying DEFAULT NULL::character varying,
	INOUT date_of_birth date DEFAULT NULL::date,
	INOUT nationality character varying DEFAULT NULL::character varying,
	INOUT blood_group character varying DEFAULT NULL::character varying,
	INOUT addr1_street_name character varying DEFAULT NULL::character varying,
	INOUT addr1_house_no integer DEFAULT NULL::integer,
	INOUT addr1_city character varying DEFAULT NULL::character varying,
	INOUT postcode integer DEFAULT NULL::integer,
	INOUT country character varying DEFAULT NULL::character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
SELECT emp."Employee_ID",
emp."Job_ID",
emp."First_Name",
emp."Middle_Name",
emp."Last_Name",
emp."Email",
emp."Mobile",
emp."Date_of_joining",
emp."Manager_ID",
emp."Gender",
emp."Accrued_leaves",
emp."Shift_code",
emp."Emp_Type_ID ",
per."Marital_status",
per."Qualification",
per."Last_employer_address",
per."Last_employer_contact",
per."Previous_role",
per."Tax_ID",per."Date_of_birth",
per."Nationality",
per."Blood_group",
addr."Addr1_Street_Name",
addr."Addr1_House_No",
addr."Addr1_City",
addr."Addr1_Postcode",
addr."Addr1_Country"

INTO
employee_id,
job_id,
first_name,
middle_name,
last_name,
email,
mobile,
date_of_joining,
manager_ID,
gender,
accrued_leaves,
shift_code,
emp_type_id,
marital_status,
qualification,
last_employer_address,
last_employer_contact,
previous_role,
tax_ID,
date_of_birth,
nationality,
blood_group,
addr1_street_name,
addr1_house_no,
addr1_city,
postcode,
country

FROM public."Employee_table" as emp,
public."Employee_Personal_table" as per,
public."Emp_address_table" as addr

WHERE emp."Employee_ID" = per."Employee_ID"
AND emp."Employee_ID" = addr."Employee_ID";

END;
$BODY$;
ALTER PROCEDURE public.view_empinfo(integer, integer, character varying, character varying, character varying, character varying, character varying, date, integer, character varying, integer, integer, integer, integer, character varying, character varying, character varying, integer, character varying, character varying, date, character varying, character varying, character varying, integer, character varying, integer, character varying)
    OWNER TO skand;



-- PROCEDURE: public.personal_data_emp(integer, integer, character varying, character varying, character varying, character varying, character varying, text, character varying, date, character varying, character varying)

DROP PROCEDURE IF EXISTS public.personal_data_emp(integer, integer,character varying, character varying, character varying, character varying, character varying, text, character varying, date, character varying, character varying);

CREATE OR REPLACE PROCEDURE public.personal_data_emp(
	IN emp_personal_id integer,
	IN empid integer,
	IN marital_status character varying,
	IN qualification character varying,
	IN last_employer character varying,
	IN last_employer_address character varying,
	IN last_employer_contact character varying,
	IN previous_role text,
	IN tax_id character varying,
	IN date_of_birth date,
	IN nationality character varying,
	IN blood_group character varying)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN

	INSERT into "Employee_Personal_table"("Emp_personal_ID",
	"Employee_ID","Marital_status","Qualification",
    "Last_employer","Last_employer_address",
    "Last_employer_contact","Previous_role",
	"Tax_ID","Date_of_birth","Nationality",
	"Blood_group")
values (Emp_personal_ID,Employee_ID,
     Marital_status,Qualification,
    Last_employer,Last_employer_address,
    Last_employer_contact,Previous_role,
	Tax_ID,Date_of_birth,Nationality,
	Blood_group);
		
end;
$BODY$;
ALTER PROCEDURE public.personal_data_emp(integer, integer,character varying, character varying, character varying, character varying, character varying, text, character varying, date, character varying, character varying)
    OWNER TO postgres;

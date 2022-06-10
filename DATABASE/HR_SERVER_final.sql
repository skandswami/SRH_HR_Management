-- DROP DATABASE IF EXISTS "HR_SERVER";

CREATE DATABASE "HR_SERVER"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


    

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Bank_Account_table"
    OWNER to postgres;
-- Index: fki_fk_bankacc_empsal

-- DROP INDEX IF EXISTS public.fki_fk_bankacc_empsal;

CREATE INDEX IF NOT EXISTS fki_fk_bankacc_empsal
    ON public."Bank_Account_table" USING btree
    ("Salary_ID" ASC NULLS LAST)
    TABLESPACE pg_default;



-- DROP TABLE IF EXISTS public."Countries_table";

CREATE TABLE IF NOT EXISTS public."Countries_table"
(
    "Country_ID	" integer NOT NULL,
    "Country_name	" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Countries_pkey" PRIMARY KEY ("Country_ID	"),
    CONSTRAINT uk_counid UNIQUE ("Country_ID	")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Countries_table"
    OWNER to postgres;



-- Table: public.Department_Recruitment_Applications

-- DROP TABLE IF EXISTS public."Department_Recruitment_Applications";

CREATE TABLE IF NOT EXISTS public."Department_Recruitment_Applications"
(
    "Dep_Recruitment_App_ID" integer NOT NULL,
    "Application_ID" integer,
    "Dept_no." integer,
    "Job_Posting_ID" integer,
    "Application_creation_Timestamp" timestamp without time zone,
    CONSTRAINT "Department_Recruitment_Applications_pkey" PRIMARY KEY ("Dep_Recruitment_App_ID"),
    CONSTRAINT fk_deptrecapp_dept FOREIGN KEY ("Dept_no.")
        REFERENCES public."Department_table" ("Dept_no.") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_deptrecapp_jobposrec FOREIGN KEY ("Job_Posting_ID")
        REFERENCES public."Job_Postings_Recruitment_table" ("Job_Posting_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_deptrecapp_newapptra FOREIGN KEY ("Application_ID")
        REFERENCES public."New_Applicant_Track_table" ("Application_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Department_Recruitment_Applications"
    OWNER to postgres;
-- Index: fki_fk_deptrecapp_dept

-- DROP INDEX IF EXISTS public.fki_fk_deptrecapp_dept;

CREATE INDEX IF NOT EXISTS fki_fk_deptrecapp_dept
    ON public."Department_Recruitment_Applications" USING btree
    ("Dept_no." ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_deptrecapp_jobposrec

-- DROP INDEX IF EXISTS public.fki_fk_deptrecapp_jobposrec;

CREATE INDEX IF NOT EXISTS fki_fk_deptrecapp_jobposrec
    ON public."Department_Recruitment_Applications" USING btree
    ("Job_Posting_ID" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_deptrecapp_newapptra

-- DROP INDEX IF EXISTS public.fki_fk_deptrecapp_newapptra;

CREATE INDEX IF NOT EXISTS fki_fk_deptrecapp_newapptra
    ON public."Department_Recruitment_Applications" USING btree
    ("Application_ID" ASC NULLS LAST)
    TABLESPACE pg_default;


-- DROP TABLE IF EXISTS public."Department_table";

CREATE TABLE IF NOT EXISTS public."Department_table"
(
    "Dept_no." integer NOT NULL,
    "Dept_Name" text COLLATE pg_catalog."default" NOT NULL,
    "Org_ID" integer,
    "Dept_contact_no" character varying COLLATE pg_catalog."default" NOT NULL,
    "Location_ID" integer,
    "Creation_Timestamp" timestamp without time zone,
    CONSTRAINT "Department_table_pkey" PRIMARY KEY ("Dept_no.")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Department_table"
    OWNER to postgres;


-- DROP TABLE IF EXISTS public."Emp_Achievements_table";

CREATE TABLE IF NOT EXISTS public."Emp_Achievements_table"
(
    "Emp_Achievement_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Date_of_Certification" date,
    "Certifications_desc" character varying COLLATE pg_catalog."default",
    "Certification_validity" date,
    CONSTRAINT "Emp_Achievements_table_pkey" PRIMARY KEY ("Emp_Achievement_ID"),
    CONSTRAINT fk_achie_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Achievements_table"
    OWNER to postgres;
-- Index: fki_fk_achie_emp

-- DROP INDEX IF EXISTS public.fki_fk_achie_emp;

CREATE INDEX IF NOT EXISTS fki_fk_achie_emp
    ON public."Emp_Achievements_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;






-- DROP TABLE IF EXISTS public."Emp_Dept_table";

CREATE TABLE IF NOT EXISTS public."Emp_Dept_table"
(
    "Emp_Dept_ID" integer NOT NULL,
    "Dept_no." integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Emp_dept_joining_date" date NOT NULL,
    "Emp_dept_leaving_date" date,
    CONSTRAINT "Emp_Dept_table_pkey" PRIMARY KEY ("Emp_Dept_ID"),
    CONSTRAINT fk_empdept_dept FOREIGN KEY ("Dept_no.")
        REFERENCES public."Department_table" ("Dept_no.") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_empdept_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Dept_table"
    OWNER to postgres;
-- Index: fki_fk_empdept_dept

-- DROP INDEX IF EXISTS public.fki_fk_empdept_dept;

CREATE INDEX IF NOT EXISTS fki_fk_empdept_dept
    ON public."Emp_Dept_table" USING btree
    ("Dept_no." ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_empdept_emp

-- DROP INDEX IF EXISTS public.fki_fk_empdept_emp;

CREATE INDEX IF NOT EXISTS fki_fk_empdept_emp
    ON public."Emp_Dept_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




-- DROP TABLE IF EXISTS public."Emp_Equip_Info_table";

CREATE TABLE IF NOT EXISTS public."Emp_Equip_Info_table"
(
    "Emp_Equip_ID" character varying COLLATE pg_catalog."default" NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Type_of_system" character varying COLLATE pg_catalog."default" NOT NULL,
    "Location" character varying COLLATE pg_catalog."default",
    "Equip_info_creation_Timestamp" timestamp without time zone NOT NULL,
    CONSTRAINT "Emp_Equip_Info_table_pkey" PRIMARY KEY ("Emp_Equip_ID"),
    CONSTRAINT uk_empequip UNIQUE ("Emp_Equip_ID"),
    CONSTRAINT fk_equip_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Equip_Info_table"
    OWNER to postgres;

COMMENT ON TABLE public."Emp_Equip_Info_table"
    IS 'Employee system information table';
-- Index: fki_fk_equip_emp

-- DROP INDEX IF EXISTS public.fki_fk_equip_emp;

CREATE INDEX IF NOT EXISTS fki_fk_equip_emp
    ON public."Emp_Equip_Info_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;



-- DROP TABLE IF EXISTS public."Emp_Job_table";

CREATE TABLE IF NOT EXISTS public."Emp_Job_table"
(
    "Job_emp_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Job_ID" integer NOT NULL,
    "Job_start_date" date NOT NULL,
    "Job_end_date" date,
    CONSTRAINT "Emp_Job_table_pkey" PRIMARY KEY ("Job_emp_ID"),
    CONSTRAINT fk_empjob_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_empjob_job FOREIGN KEY ("Job_ID")
        REFERENCES public."Job_table" ("Job_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Job_table"
    OWNER to postgres;
-- Index: fki_fk_empjob_emp

-- DROP INDEX IF EXISTS public.fki_fk_empjob_emp;

CREATE INDEX IF NOT EXISTS fki_fk_empjob_emp
    ON public."Emp_Job_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_empjob_job

-- DROP INDEX IF EXISTS public.fki_fk_empjob_job;

CREATE INDEX IF NOT EXISTS fki_fk_empjob_job
    ON public."Emp_Job_table" USING btree
    ("Job_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




-- DROP TABLE IF EXISTS public."Emp_Leaves_table";

CREATE TABLE IF NOT EXISTS public."Emp_Leaves_table"
(
    "Leave_code" character varying COLLATE pg_catalog."default" NOT NULL,
    "Leave_Type_Desct" text COLLATE pg_catalog."default",
    "No_of_Leaves_applicable" character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Emp_Leaves_table_pkey" PRIMARY KEY ("Leave_code")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Leaves_table"
    OWNER to postgres;





-- DROP TABLE IF EXISTS public."Emp_Location_table";

CREATE TABLE IF NOT EXISTS public."Emp_Location_table"
(
    "Location_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Country_ID" integer NOT NULL,
    "Address_ID" integer NOT NULL,
    CONSTRAINT "Emp_Location_table_pkey" PRIMARY KEY ("Location_ID"),
    CONSTRAINT uk_loc UNIQUE ("Location_ID"),
    CONSTRAINT fk_emploc_coun FOREIGN KEY ("Country_ID")
        REFERENCES public."Countries_table" ("Country_ID	") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emploc_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emploc_empadd FOREIGN KEY ("Address_ID")
        REFERENCES public."Emp_address_table" ("Address_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Location_table"
    OWNER to postgres;
-- Index: fki_fk_emploc_coun

-- DROP INDEX IF EXISTS public.fki_fk_emploc_coun;

CREATE INDEX IF NOT EXISTS fki_fk_emploc_coun
    ON public."Emp_Location_table" USING btree
    ("Country_ID" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_emploc_emp

-- DROP INDEX IF EXISTS public.fki_fk_emploc_emp;

CREATE INDEX IF NOT EXISTS fki_fk_emploc_emp
    ON public."Emp_Location_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_emploc_empadd

-- DROP INDEX IF EXISTS public.fki_fk_emploc_empadd;

CREATE INDEX IF NOT EXISTS fki_fk_emploc_empadd
    ON public."Emp_Location_table" USING btree
    ("Address_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




    -- DROP TABLE IF EXISTS public."Emp_Salary_table";

CREATE TABLE IF NOT EXISTS public."Emp_Salary_table"
(
    "Salary_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Bonus" character varying COLLATE pg_catalog."default",
    "Salary_Band" character varying COLLATE pg_catalog."default" NOT NULL,
    "Monthly_Salary" character varying COLLATE pg_catalog."default",
    "Annual_Salary" character varying COLLATE pg_catalog."default" NOT NULL,
    "Monthly_Tax _deduction" character varying COLLATE pg_catalog."default" NOT NULL,
    "Monthly_Insurance_deductions" character varying COLLATE pg_catalog."default" NOT NULL,
    "Monthly_Pension_deductions" character varying COLLATE pg_catalog."default" NOT NULL,
    "PF_contribution" character varying COLLATE pg_catalog."default",
    "Salary_creation_timestamp" timestamp without time zone NOT NULL,
    CONSTRAINT "Emp_Salary_table_pkey" PRIMARY KEY ("Salary_ID"),
    CONSTRAINT uk_salaryid UNIQUE ("Salary_ID"),
    CONSTRAINT fk_sal_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Salary_table"
    OWNER to postgres;
-- Index: fki_fk_sal_emp

-- DROP INDEX IF EXISTS public.fki_fk_sal_emp;

CREATE INDEX IF NOT EXISTS fki_fk_sal_emp
    ON public."Emp_Salary_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




    -- DROP TABLE IF EXISTS public."Emp_Timesheet_table";

CREATE TABLE IF NOT EXISTS public."Emp_Timesheet_table"
(
    "Timesheet_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Timesheet_code" character varying COLLATE pg_catalog."default",
    "Project_ID" integer,
    "Shift_code" integer NOT NULL,
    "Billable_hours" character varying COLLATE pg_catalog."default",
    "Leave_hours" character varying COLLATE pg_catalog."default",
    "Timesheet_creation_timestamp" timestamp without time zone,
    "Leave_code" character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT "Emp_Timesheet_table_pkey" PRIMARY KEY ("Timesheet_ID"),
    CONSTRAINT uk_timesheetid UNIQUE ("Timesheet_ID"),
    CONSTRAINT fk_emptimesh_empleav FOREIGN KEY ("Leave_code")
        REFERENCES public."Emp_Leaves_table" ("Leave_code") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_timesheet_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Timesheet_table"
    OWNER to postgres;
-- Index: fki_fk_emptimesh_empleav

-- DROP INDEX IF EXISTS public.fki_fk_emptimesh_empleav;

CREATE INDEX IF NOT EXISTS fki_fk_emptimesh_empleav
    ON public."Emp_Timesheet_table" USING btree
    ("Leave_code" COLLATE pg_catalog."default" ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_timesheet_emp

-- DROP INDEX IF EXISTS public.fki_fk_timesheet_emp;

CREATE INDEX IF NOT EXISTS fki_fk_timesheet_emp
    ON public."Emp_Timesheet_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




-- DROP TABLE IF EXISTS public."Emp_address_table";

CREATE TABLE IF NOT EXISTS public."Emp_address_table"
(
    "Address_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Addr1_Street Name" character varying COLLATE pg_catalog."default" NOT NULL,
    "Addr1_Building Name" character varying COLLATE pg_catalog."default" NOT NULL,
    "Addr1_House No." character varying COLLATE pg_catalog."default" NOT NULL,
    "Addr1_City" text COLLATE pg_catalog."default" NOT NULL,
    "Addr1_Postcode" integer NOT NULL,
    "Addr1_Country" text COLLATE pg_catalog."default" NOT NULL,
    "Addr2_Street Name" character varying COLLATE pg_catalog."default",
    "Addr2_Building Name" character varying COLLATE pg_catalog."default",
    "Addr2_House No." character varying COLLATE pg_catalog."default",
    "Addr2_City" text COLLATE pg_catalog."default",
    "Addr2_Postcode" integer,
    "Addr2_Country" text COLLATE pg_catalog."default",
    CONSTRAINT "Emp_address_table_pkey" PRIMARY KEY ("Address_ID"),
    CONSTRAINT fk_add_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_address_table"
    OWNER to postgres;
-- Index: fki_fk_add_emp

-- DROP INDEX IF EXISTS public.fki_fk_add_emp;

CREATE INDEX IF NOT EXISTS fki_fk_add_emp
    ON public."Emp_address_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;





-- DROP TABLE IF EXISTS public."Emp_type";

CREATE TABLE IF NOT EXISTS public."Emp_type"
(
    "Emp_Type_ID" integer NOT NULL,
    "Type_of_employee " text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Emp_type_pkey" PRIMARY KEY ("Emp_Type_ID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_type"
    OWNER to postgres;





-- DROP TABLE IF EXISTS public."Employee_Performance_table";

CREATE TABLE IF NOT EXISTS public."Employee_Performance_table"
(
    "Emp_Performance_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Emp_rating" character varying COLLATE pg_catalog."default",
    "Job_Role" text COLLATE pg_catalog."default",
    "Last_Promotion" date,
    "Remarks" text COLLATE pg_catalog."default",
    "Manager_rating" character varying COLLATE pg_catalog."default",
    "Performance_creation_Timestamp" time without time zone,
    CONSTRAINT "Employee_Performance_table_pkey" PRIMARY KEY ("Emp_Performance_ID"),
    CONSTRAINT fk_perfor_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Employee_Performance_table"
    OWNER to postgres;
-- Index: fki_fk_perfor_emp

-- DROP INDEX IF EXISTS public.fki_fk_perfor_emp;

CREATE INDEX IF NOT EXISTS fki_fk_perfor_emp
    ON public."Employee_Performance_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




    -- DROP TABLE IF EXISTS public."Employee_Personal_table";

CREATE TABLE IF NOT EXISTS public."Employee_Personal_table"
(
    "Emp_personal_ID" integer NOT NULL,
    "Employee_ID" integer NOT NULL,
    "Marital_status" text COLLATE pg_catalog."default",
    "Qualification" character varying COLLATE pg_catalog."default" NOT NULL,
    "Last_employer" character varying COLLATE pg_catalog."default" NOT NULL,
    "Last_employer_address" character varying COLLATE pg_catalog."default",
    "Last_employer_contact" character varying COLLATE pg_catalog."default",
    "Previous_role" text COLLATE pg_catalog."default" NOT NULL,
    "Tax_ID" character varying COLLATE pg_catalog."default" NOT NULL,
    "Date_of_birth" date NOT NULL,
    "Nationality" character varying COLLATE pg_catalog."default" NOT NULL,
    "Blood_group" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Employee_Personal_table_pkey" PRIMARY KEY ("Emp_personal_ID"),
    CONSTRAINT uk_taxid UNIQUE ("Tax_ID"),
    CONSTRAINT fk_personal_emp FOREIGN KEY ("Employee_ID")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Employee_Personal_table"
    OWNER to postgres;
-- Index: fki_fk_personal_emp

-- DROP INDEX IF EXISTS public.fki_fk_personal_emp;

CREATE INDEX IF NOT EXISTS fki_fk_personal_emp
    ON public."Employee_Personal_table" USING btree
    ("Employee_ID" ASC NULLS LAST)
    TABLESPACE pg_default;
    

 -- ALTER TABLE IF EXISTS public."Employee_Personal_table" DROP CONSTRAINT IF EXISTS uk_emppersid;

ALTER TABLE IF EXISTS public."Employee_Personal_table"
    ADD CONSTRAINT uk_emppersid UNIQUE ("Emp_personal_ID");





    -- DROP TABLE IF EXISTS public."Employee_table";

CREATE TABLE IF NOT EXISTS public."Employee_table"
(
    "Employee_ID" integer NOT NULL,
    "Job_ID" integer NOT NULL,
    "First_Name" text COLLATE pg_catalog."default" NOT NULL,
    "Middle_Name" text COLLATE pg_catalog."default",
    "Last_Name" text COLLATE pg_catalog."default" NOT NULL,
    "Email" character varying COLLATE pg_catalog."default" NOT NULL,
    "Mobile" character varying COLLATE pg_catalog."default" NOT NULL,
    "Date_of_joining" date NOT NULL,
    "Date_of_leaving" date,
    "Manager_ID" integer NOT NULL,
    "Gender" text COLLATE pg_catalog."default" NOT NULL,
    "Accrued_leaves" integer NOT NULL,
    "Shift_code" integer NOT NULL,
    "Dept_no." integer NOT NULL,
    "Emp_Type_ID " integer,
    CONSTRAINT "Employee_table_pkey" PRIMARY KEY ("Employee_ID"),
    CONSTRAINT uk_emp_email UNIQUE ("Email"),
    CONSTRAINT uk_empid UNIQUE ("Employee_ID")
        INCLUDE("Employee_ID"),
    CONSTRAINT fk_emp_emptype FOREIGN KEY ("Emp_Type_ID ")
        REFERENCES public."Emp_type" ("Emp_Type_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_emp_job FOREIGN KEY ("Job_ID")
        REFERENCES public."Job_table" ("Job_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Employee_table"
    OWNER to postgres;
-- Index: fki_fk_emp_emptype

-- DROP INDEX IF EXISTS public.fki_fk_emp_emptype;

CREATE INDEX IF NOT EXISTS fki_fk_emp_emptype
    ON public."Employee_table" USING btree
    ("Emp_Type_ID " ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_emp_job

-- DROP INDEX IF EXISTS public.fki_fk_emp_job;

CREATE INDEX IF NOT EXISTS fki_fk_emp_job
    ON public."Employee_table" USING btree
    ("Job_ID" ASC NULLS LAST)
    TABLESPACE pg_default;





-- DROP TABLE IF EXISTS public."Job_Postings_Recruitment_table";

CREATE TABLE IF NOT EXISTS public."Job_Postings_Recruitment_table"
(
    "Dept_no." integer NOT NULL,
    "Job_dept." character varying COLLATE pg_catalog."default" NOT NULL,
    "Job_Role" character varying COLLATE pg_catalog."default" NOT NULL,
    "Job_Desc" text COLLATE pg_catalog."default",
    "Min_salary" character varying COLLATE pg_catalog."default",
    "Max_salary" character varying COLLATE pg_catalog."default",
    "Job_Posting_ID" integer NOT NULL,
    CONSTRAINT "Job_Postings_Recruitment_table_pkey" PRIMARY KEY ("Job_Posting_ID"),
    CONSTRAINT fk_jobpostrecr_dept FOREIGN KEY ("Dept_no.")
        REFERENCES public."Department_table" ("Dept_no.") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Job_Postings_Recruitment_table"
    OWNER to postgres;
-- Index: fki_fk_jobpostrecr_dept

-- DROP INDEX IF EXISTS public.fki_fk_jobpostrecr_dept;

CREATE INDEX IF NOT EXISTS fki_fk_jobpostrecr_dept
    ON public."Job_Postings_Recruitment_table" USING btree
    ("Dept_no." ASC NULLS LAST)
    TABLESPACE pg_default;




-- DROP TABLE IF EXISTS public."Job_table";

CREATE TABLE IF NOT EXISTS public."Job_table"
(
    "Job_ID" integer NOT NULL,
    "Job_creation_timestamp" timestamp without time zone NOT NULL,
    "Job_updated_on" date NOT NULL,
    "Job_description" text COLLATE pg_catalog."default",
    "Dept_no." integer NOT NULL,
    "Active/Inactive" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "Job_table_pkey" PRIMARY KEY ("Job_ID"),
    CONSTRAINT fk_job_dept FOREIGN KEY ("Dept_no.")
        REFERENCES public."Department_table" ("Dept_no.") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Job_table"
    OWNER to postgres;
-- Index: fki_fk_job_dept

-- DROP INDEX IF EXISTS public.fki_fk_job_dept;

CREATE INDEX IF NOT EXISTS fki_fk_job_dept
    ON public."Job_table" USING btree
    ("Dept_no." ASC NULLS LAST)
    TABLESPACE pg_default;






-- DROP TABLE IF EXISTS public."New_Applicant_Track_table";

CREATE TABLE IF NOT EXISTS public."New_Applicant_Track_table"
(
    "Application_ID" integer NOT NULL,
    "Applicant_FirstName" text COLLATE pg_catalog."default" NOT NULL,
    "Applicant_MiddleName" text COLLATE pg_catalog."default",
    "Applicant_LastName" text COLLATE pg_catalog."default" NOT NULL,
    "Applicant_email" character varying COLLATE pg_catalog."default" NOT NULL,
    "Applicant_Years_of_Exp" character varying COLLATE pg_catalog."default",
    CONSTRAINT "New_Applicant_Track_table_pkey" PRIMARY KEY ("Application_ID")
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."New_Applicant_Track_table"
    OWNER to postgres;




-- DROP TABLE IF EXISTS public."HR_user";

CREATE TABLE IF NOT EXISTS public."HR_user"
(
    userid integer NOT NULL DEFAULT nextval('hr_user_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default",
    email character varying(50) COLLATE pg_catalog."default",
    password character varying(1000) COLLATE pg_catalog."default",
    CONSTRAINT "HR__user_pkey" PRIMARY KEY (userid),
    CONSTRAINT "HR__user_email_key" UNIQUE (email),
    CONSTRAINT "HR__user_username_key" UNIQUE (username)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."HR_user"
    OWNER to postgres;




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


-- DROP TABLE IF EXISTS public."Bank_Account_table";

CREATE TABLE IF NOT EXISTS public."Bank_Account_table"
(
    "Bank_acc_ID" integer NOT NULL,
    "Bank_Account_No" character varying COLLATE pg_catalog."default" NOT NULL,
    "Salary_ID" integer NOT NULL,
    "Bank_Name" text COLLATE pg_catalog."default" NOT NULL,
    "Bank_IBAN" character varying COLLATE pg_catalog."default" NOT NULL,
    "Bank_Location" character varying COLLATE pg_catalog."default",
    CONSTRAINT "Bank_Account_pkey" PRIMARY KEY ("Bank_acc_ID"),
    CONSTRAINT uk_bankaccid UNIQUE ("Bank_acc_ID"),
    CONSTRAINT fk_bankacc_empsal FOREIGN KEY ("Salary_ID")
        REFERENCES public."Emp_Salary_table" ("Salary_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)


-- ALTER TABLE IF EXISTS public."Bank_Account_table" DROP CONSTRAINT IF EXISTS fk_bankacc_empsal;

ALTER TABLE IF EXISTS public."Bank_Account_table"
    DROP CONSTRAINT fk_bankacc_empsal FOREIGN KEY ("Salary_ID")
    REFERENCES public."Emp_Salary_table" ("Salary_ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


-- ALTER TABLE IF EXISTS public."Bank_Account_table" DROP COLUMN IF EXISTS "Salary_ID";

ALTER TABLE IF EXISTS public."Bank_Account_table"
  DROP COLUMN IF EXISTS "Salary_ID" integer NOT NULL;




-- DROP TABLE IF EXISTS public."Emp_Bank_table";

CREATE TABLE IF NOT EXISTS public."Emp_Bank_table"
(
    "Emp_Bank_ID" integer NOT NULL,
    "Employee_ID " integer NOT NULL,
    "Bank_acc_ID" integer NOT NULL,
    "Bank_acc_start_date" date NOT NULL,
    "Bank_acc_end_date" date,
    CONSTRAINT "Emp_Bank_table_pkey" PRIMARY KEY ("Emp_Bank_ID"),
    CONSTRAINT fk_empbank_bankacc FOREIGN KEY ("Bank_acc_ID")
        REFERENCES public."Bank_Account_table" ("Bank_acc_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_empbank_emp FOREIGN KEY ("Employee_ID ")
        REFERENCES public."Employee_table" ("Employee_ID") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public."Emp_Bank_table"
    OWNER to postgres;
-- Index: fki_e

-- DROP INDEX IF EXISTS public.fki_e;

CREATE INDEX IF NOT EXISTS fki_e
    ON public."Emp_Bank_table" USING btree
    ("Employee_ID " ASC NULLS LAST)
    TABLESPACE pg_default;
-- Index: fki_fk_empbank_bankacc

-- DROP INDEX IF EXISTS public.fki_fk_empbank_bankacc;

CREATE INDEX IF NOT EXISTS fki_fk_empbank_bankacc
    ON public."Emp_Bank_table" USING btree
    ("Bank_acc_ID" ASC NULLS LAST)
    TABLESPACE pg_default;




  -- ALTER TABLE IF EXISTS public."Emp_Bank_table" DROP CONSTRAINT IF EXISTS fk_empbank_empsalary;

ALTER TABLE IF EXISTS public."Emp_Bank_table"
    ADD CONSTRAINT fk_empbank_empsalary FOREIGN KEY ("Salary_ID")
    REFERENCES public."Emp_Salary_table" ("Salary_ID") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;



   

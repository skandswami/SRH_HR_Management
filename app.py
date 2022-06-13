from types import EllipsisType
from flask import jsonify
from flask_sqlalchemy import SQLAlchemy
from enum import unique
from threading import local
from flask import Flask,render_template,request,session,redirect,url_for,flash
from flask_login import  UserMixin
import psycopg2
from flask_login import LoginManager,login_manager
from sqlalchemy import Table, Column, Integer, ForeignKey, exists
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
import hashlib
import os

Base = declarative_base()

app = Flask(__name__)
app.secret_key = "super secret key"
globalEmployeeId = 0
login_manager=LoginManager(app)
login_manager.login_view='HRLogin'

@login_manager.user_loader
def load_user(user_userid):
    return HR_User.query.get(int(user_userid))

# postgresql://<username>:<userpassword>@localhost:5433/<databasename>
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://HR_SERVER:HR_SERVER@localhost:5432/HR_SERVER'
#app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:shweta@localhost:5432/HR_Server'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
db=SQLAlchemy(app)

# global functions
def DatabaseConnection():
      return psycopg2.connect(host="localhost", database ="HR_SERVER", user="HR_SERVER", password="HR_SERVER")

def HashFromPassword(password):
    salt = os.urandom(32) 
    hash_object = hashlib.sha256(password.encode('utf-8'))
    hex_dig = hash_object.hexdigest()
    return hex_dig

class HR_User(UserMixin, db.Model):
    __table__ = Table('HR_user', Base.metadata,
                    autoload=True, autoload_with=db.engine)

class EmployeeLogin(db.Model):
    __table__ = Table('Employee_Login', Base.metadata,
                    autoload=True, autoload_with=db.engine)

class Employee(db.Model):
    __table__ = Table('Employee_table', Base.metadata,
                    autoload=True, autoload_with=db.engine)

class EmployeeLeaves(db.Model):
    __table__ = Table('Emp_Leaves', Base.metadata,
                    autoload=True, autoload_with=db.engine)

class Leaves(db.Model):
    __table__ = Table('Leaves_table', Base.metadata,
                    autoload=True, autoload_with=db.engine)

@app.route("/")
def index():
    return render_template("index.html")


@app.route("/HRLogin",methods=['POST','GET'])
def HRLog():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user=HR_User.query.filter_by(email=email).first()
        password_check=HR_User.query.filter_by(password=HashFromPassword(password)).first()
        if user and password_check:
            flash("Successful Login")
            return redirect(url_for("HRDashboard"))
        else:
            flash("Invalid email or password","danger")
            return render_template("HRLog.html")
    return render_template("HRLog.html")

@app.route("/EmployeeLogin",methods=['POST','GET'])
def EmployeeLog():
    if request.method == "POST":
        email=request.form.get('email')
        password=request.form.get('password')
        user= EmployeeLogin.query.filter_by(email=email).first()
        password_check=EmployeeLogin.query.filter_by(password=HashFromPassword(password)).first()
        if user and password_check:
            flash("Successful Login")
            globalEmployeeId = user.Employee_Id
            return redirect(url_for("EmployeeDashboard"))
        else:
            flash("Invalid email or password","danger")
            return render_template("EmployeeLogin.html")
    return render_template("EmployeeLogin.html")

@app.route("/HRReg",methods=['POST','GET'])
def HRReg():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        user = HR_User.query.filter_by(email=email).first()
        if user:
            flash("Email Already exists")
            return render_template("HRReg.html")
        user = HR_User.query.filter_by(username=username).first()
        if user:
            flash("Email Already exists")
            return render_template("HRReg.html")
        conn = DatabaseConnection()
        cur = conn.cursor()
        hashpassword = HashFromPassword(password)
        print(hashpassword)
        cur.execute(f"Call public.sp_create_hruser('{username}', '{hashpassword}', '{email}')")
        conn.commit()
        flash("New user created")
        return render_template("HRLog.html")
    return render_template("HRReg.html")

@app.route("/main")
def main():
    return render_template("main.html")

@app.route("/EmployeeReg",methods=['POST','GET'])
def EmployeeReg():
    if request.method == "POST":
        username=request.form.get('username')
        email=request.form.get('email')
        password=request.form.get('password')
        employee = Employee.query.filter_by(Email=email).first()
        print(employee)
        if employee is None:
            flash("Not a registered employee")
            print("Not a registered employee")
            return render_template("EmployeeReg.html")
        print(employee)
        employeeId = employee.Employee_ID
        print(employeeId)
        user = EmployeeLogin.query.filter_by(email=email).first()
        if user:
            flash("Email Already exists")
            return render_template("EmployeeReg.html")
        user = EmployeeLogin.query.filter_by(username=username).first()
        if user:
            flash("Username Already exists")
            return render_template("EmployeeReg.html")
        conn = DatabaseConnection()
        cur = conn.cursor()
        hashpassword = HashFromPassword(password)
        print(hashpassword)
        cur.execute(f"Call public.sp_create_employeeuser('{username}', '{hashpassword}', '{email}','{employeeId}')")
        conn.commit()
        flash("New user created")
        return render_template("EmployeeLogin.html")
    return render_template("EmployeeReg.html")

# @app.route('/CreateEmpRecord')
# def create_employee1():
#     return render_template('CreateEmpRecord.html')

@app.route("/CreateEmpRecord", methods=['GET', 'POST'])
def create_employee():
    if request.method == 'POST':
        employee_id=request.form.get('employee_id')
        job_id=request.form.get('job_id')
        first_name=request.form.get('fname')
        middle_name=request.form.get('mname')
        last_name=request.form.get('lname')
        email=request.form.get('empemail')
        mobile=request.form.get('mobileno')
        date_of_joining=request.form.get('doj')
        date_of_leaving=request.form.get('dol')
        manager_id=request.form.get('managerid')
        gender=request.form.get('gender')
        accrued_leaves=request.form.get("Accleaves")
        shift_code=request.form.get('shiftcd')
        dept_no=request.form.get('deptno')
        emp_type_id=request.form.get('emptypid')
        conn = DatabaseConnection()
        cur = conn.cursor()
        cur.execute(f"Call public.cr_new_emp({employee_id}','{job_id}','{first_name}','{middle_name}','{last_name}','{email}','{mobile}','{date_of_joining}','{date_of_leaving}','{manager_id}','{gender}','{accrued_leaves}','{shift_code}','{dept_no}','{emp_type_id}')")
        conn.commit()
        flash("Employee Information created Successully")
        return redirect('/CreateEmpRecord')
    return render_template("CreateEmpRecord.html")


@app.route("/CreateEmpPersonaldata", methods=['GET', 'POST'])
def CreateEmpPersonaldata():
    if request.method == 'POST':
        emp_personal_id=request.form.get('emp_pid')
        empid=request.form.get('empid')
        marital_status=request.form.get('maritalstat')
        qualification=request.form.get('qualification')
        last_employer=request.form.get('lastemployer')
        last_employer_address=request.form.get('lastempadd')
        last_employer_contact=request.form.get('lastempcont')
        previous_role=request.form.get('prevrole')
        tax_id=request.form.get('taxid')
        date_of_birth=request.form.get("DOB")
        nationality=request.form.get("nationality")
        blood_group=request.form.get('bloddgrp')
        conn = DatabaseConnection()
        cur = conn.cursor()    
        cur.execute(f"Call public.personal_data_emp (`{emp_personal_id}`,`{empid}`,`{marital_status}`,`{qualification}`,`{last_employer}`,`{last_employer_address}`,`{last_employer_contact}`,`{tax_id}`,'{date_of_birth}','{nationality}','{blood_group}')")
        conn.commit()
        flash("Employee personal Information created Successully")
        return redirect('/CreateEmpPersonaldata')
    return render_template("CreateEmpPersonaldata.html")

@app.route("/edit/<string:employee_id>", methods=['GET', 'POST'])
#def editpersonaldata(employee_id):
#     post=Personaldata.query.filter_by(employee_id=employee_id).first()
#     if request.method == 'POST':
#         employee_id=request.form.get('employee_id')
#         fname=request.form.get('fname')
#         lname=request.form.get('lname')
#         DOB=request.form.get('DOB')
#         gender=request.form.get('gender')
#         SSN=request.form.get('SSnumber')
#         Nationality=request.form.get("nationality")
#         job_type=request.form.get('job_title')
#         db.engine.execute(f"UPDATE `personaldata` SET `employee_id` = '{employee_id}', `fname` = '{fname}',`lname` = '{lname}', `DOB` = '{DOB}',`gender` = '{gender}', `SSN` = '{SSN}', `Nationality` = '{Nationality}',`job_type` = '{job_type}' WHERE `personaldata`.`employee_id` = {employee_id}")
#         flash("Personal details updated successfully")
#         return redirect('/displayinfo')
#    return render_template("edit.html",post=post)

@app.route("/employeeddetailsedit", methods=['GET', 'POST'])
def employeedashboard():
    if request.method == 'POST':
        Employee_ID=request.form.get('Employee_ID')
        print(Employee_ID)
        First_Name=request.form.get('First_Name')
        Middle_Name=request.form.get('Middle_Name')
        Last_Name=request.form.get('Last_Name')
        #DOB=request.form.get('DOB')
        Gender=request.form.get('Gender')
        Emp_Type=request.form.get('Emp_Type')
        conn = DatabaseConnection()
        cur = conn.cursor()    
        cur.execute(f"Call public.sp_edit_employee (`{Employee_ID}`,`{First_Name}`,`{Middle_Name}`,`{Last_Name}`,`{Gender}`,`{Emp_Type}`)")
        conn.commit()
        #personal_data=db.engine.execute(f"INSERT INTO `Employee_table` (`Employee_ID`,`First_Name`,`Middle_Name`,`Last_Name`,`Gender`,`Emp_Type`) VALUES ('{Employee_ID}','{First_Name}','{Middle_Name}','{Last_Name}','{Gender}','{Emp_Type}')")
        flash("Successfully Updated User Information")
        print("Successfully Updated User Information")
    return render_template("Emp_Details_Editable.html")

@app.route("/contactdata", methods=['GET', 'POST'])
def contactdata():
#     if request.method == 'POST':
#         email=request.form.get('email')
#         employee_id=request.form.get('employee_id')
#         address=request.form.get('address')
#         city=request.form.get('city')
#         state=request.form.get('state')
#         plz=request.form.get('plz')
#         country=request.form.get('country')
#         phone_number=request.form.get("phone_number")
#         contact_data=db.engine.execute(f"INSERT INTO `contactdata` (`email`,`employee_id`,`address`,`city`,`state`,`plz`,`country`,`phone_number`) VALUES ('{email}','{employee_id}','{address}','{city}','{state}','{plz}','{country}','{phone_number}')")
#         flash("Employee contact Information created Successully")
#         return redirect('/CreateEmployee')
    return render_template("contactdata.html")

@app.route("/EmployeeDashboard", methods=['GET'])
def EmployeeDashboard():
    return render_template("EmployeeDashboard.html")

@app.route("/HRDashboard", methods=['GET'])
def HRDashboard():
    return render_template("HRDashboard.html")

@app.route("/editcontact/<string:employee_id>", methods=['GET', 'POST'])
#def editcontactdata(employee_id):
#     posts=Contactdata.query.filter_by(employee_id=employee_id).first()
#     if request.method == 'POST':
#         email=request.form.get('email')
#         employee_id=request.form.get('employee_id')
#         address=request.form.get('address')
#         city=request.form.get('city')
#         state=request.form.get('state')
#         plz=request.form.get('plz')
#         country=request.form.get('country')
#         phone_number=request.form.get("phone_number")
#         db.engine.execute(f"UPDATE `contactdata` SET `email` = '{email}',`employee_id` = '{employee_id}', `address` = '{address}',`city` = '{city}', `state` = '{state}',`plz` = '{plz}', `country` = '{country}', `phone_number` = '{phone_number}' WHERE `contactdata`.`employee_id` = {employee_id}")
#         flash("Personal details updated successfully")
#         return redirect('/displayinfo')
#    return render_template("editcontact.html",posts=posts)

@app.route("/skills", methods=['GET', 'POST'])
def skills():
#     if request.method == 'POST':
#         employee_id=request.form.get('EmployeeId')
#         highest_education=request.form.get('education')
#         skillset=request.form.get('skillset')
#         work_exp=request.form.get('wexp')
#         wexp_details=request.form.get('fexp')
#         finance_data=db.engine.execute(f"INSERT INTO `skills` (`employee_id`,`highest_education`,`skillset`,`work_exp`,`wexp_details`) VALUES ('{employee_id}','{highest_education}','{skillset}','{work_exp}','{wexp_details}')")
#         flash("Employee skillset Information created Successully")
#         return redirect('/CreateEmployee')
    return render_template("skills.html")

@app.route("/financedata", methods=['GET', 'POST'])
def financedata():
#     if request.method == 'POST':
#         employee_id=request.form.get('employee_id')
#         bankname=request.form.get('bankname')
#         iban=request.form.get('iban')
#         taxid=request.form.get('taxid')
#         finance_data=db.engine.execute(f"INSERT INTO `financedata` (`employee_id`,`bankname`,`iban`,`taxid`) VALUES ('{employee_id}','{bankname}','{iban}','{taxid}')")
#         flash("Employee finance Information created Successully")
#         return redirect('/CreateEmployee')
    return render_template("financedata.html")

# @app.route("/organisationdata", methods=['GET', 'POST'])
# def organisationdata():
#     if request.method == 'POST':
#         employee_id=request.form.get('employee_id')
#         department_id=request.form.get('deptid')
#         department_name=request.form.get('deptname')
#         manager_name=request.form.get('managername')
#         office_building=request.form.get('building')
#         office_location=request.form.get('location')
#         basecontractor=request.form.get('contractor')
#         contractordetails=request.form.get("contractordetails")
#         organisation_data=db.engine.execute(f"INSERT INTO `organisationdata` (`employee_id`,`department_id`,`depatment_name`,`manager_name`,`office_building`,`office_location`,`basecontractor`,`contractordetails`) VALUES ('{employee_id}','{department_id}','{department_name}','{manager_name}','{office_building}','{office_location}','{basecontractor}','{contractordetails}')")
#         flash("Employee organisation Information created Successully")
#         return redirect('/CreateEmployee')
#     return render_template("organisationdata.html")

@app.route('/LeaveType', methods=['GET', 'POST'])
def LeaveType():
    if request.method == 'POST':
        leave_Code=request.form.get('leave_code')
        leaves_description=request.form.get('leaves_description')
        maximum_leaves_txt = request.form.get('maximum_leaves_txt')
        maximum_leaves=int(maximum_leaves_txt)
        leavetype = Leaves.query.filter_by(Leave_code=leave_Code).first()
        if leavetype:
            flash("type of leave already exist")
            return render_template("LeaveType.html")
        conn = DatabaseConnection()
        cur = conn.cursor()    
        cur.execute(f"Call public.add_leave_type('{leave_Code}','{leaves_description}', '{maximum_leaves}')")
        conn.commit()
        flash("Successfully created new leave type")
        return render_template("LeaveType.html")
    return render_template("LeaveType.html")

@app.route('/EmployeeLeaveApplication', methods=['GET', 'POST'])
def EmployeeLeaveApplication():
    leave_type=Leaves.query.with_entities(Leaves.Leave_code)
    if request.method == 'POST':
        leave_date=request.form.get('leave_date')
        leave_Type=request.form.get('leave_type')
        # TODO: Add check for whether the type of leaves aren't aready consumed.
        conn = DatabaseConnection()
        cur = conn.cursor()    
        cur.execute(f"Call public.apply_leave('{leave_date}','{leave_Type}')")
        conn.commit()
        flash("Leave Successfully applied")
        return render_template("EmployeeLeaveApplication.html")
    return render_template("EmployeeLeaveApplication.html", data=leave_type)



# @app.route('/Salary', methods=['GET', 'POST'])
# def Salary():
#     if request.method == 'POST':
#         salary_id=request.form.get('salaryid')
#         employee_id=request.form.get('EmployeeId')
#         salary=request.form.get('salary')
#         bonus=request.form.get('bonus')
#         benefits=request.form.get('benefits')
#         salary_data=db.engine.execute(f"INSERT INTO `salary` (`salary_id`,`employee_id`,`salary`,`bonus`,`benefits`) VALUES ('{salary_id}','{employee_id}','{salary}','{bonus}','{benefits}')")
#         flash("salary info updated Successully")
#         return redirect('/CreateEmployee') 
#     return render_template("Salary.html")


# @app.route('/Equipment', methods=['GET', 'POST'])
# def Equipment():
#     if request.method == 'POST':
#         employee_id=request.form.get('EmployeeId')
#         equip_num_data=request.form.get('Equipment')
#         equipment_data=db.engine.execute(f"INSERT INTO `equipment` (`employee_id`,`equip_num_data`) VALUES ('{employee_id}','{equip_num_data}')")
#         flash("Equipment info updated Successully")
#         return redirect('/CreateEmployee') 
#     return render_template("Equipment.html")

# @app.route('/DisplayEmpInfo', methods=['GET', 'POST'])
# def DisplayEmpInfo():
#     if request.method == 'POST':
#         eid=request.form.get('eid')
#         exists = Personaldata.query.filter_by(employee_id=eid).first()
#         if exists:
#             session ['eid'] = eid
#             return redirect(url_for("displayinfo"))
#         else:
#             flash("eid doesnot exist")
#             return redirect('/DisplayEmpInfo') 
#     return render_template("DisplayEmpInfo.html")

# # @app.route('/displayinfo')
# # def displayinfo():
# #     cur = mysql.connection.cursor()
# #     eid=session.get('eid', None)
# #     cur.execute("""SELECT * FROM personaldata WHERE employee_id='%s' """ %(eid))
# #     emps=cur.fetchall()
# #     cur.execute("""SELECT * FROM skills WHERE employee_id='%s' """ %(eid))
# #     emp_skill=cur.fetchall()
# #     cur.execute("""SELECT * FROM contactdata WHERE employee_id='%s' """ %(eid))
# #     emp_contact=cur.fetchall()
# #     cur.execute("""SELECT * FROM financedata WHERE employee_id='%s' """ %(eid))
# #     emp_finance=cur.fetchall()
# #     cur.execute("""SELECT * FROM organisationdata WHERE employee_id='%s' """ %(eid))
# #     emp_organisation=cur.fetchall()
# #     cur.execute("""SELECT * FROM salary WHERE employee_id='%s' """ %(eid))
# #     emp_salary=cur.fetchall()
# #     cur.execute("""SELECT * FROM leaves WHERE employee_id='%s' """ %(eid))
# #     emp_leaves=cur.fetchall()
# #     cur.execute("""SELECT * FROM equipment WHERE employee_id='%s' """ %(eid))
# #     emp_equipment=cur.fetchall()
# #     return render_template("displayinfo.html",emps=emps,emp_skill=emp_skill,
# #     emp_contact=emp_contact,emp_finance=emp_finance,emp_organisation=emp_organisation,
# #     emp_salary=emp_salary,emp_leaves=emp_leaves,emp_equipment=emp_equipment)

# @app.route('/delete')
# def delete():
#     eid=session.get('eid', None)
#     db.engine.execute(f"DELETE FROM `personaldata` WHERE `personaldata`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `contactdata` WHERE `contactdata`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `financedata` WHERE `financedata`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `skills` WHERE `skills`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `organisationdata` WHERE `organisationdata`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `salary` WHERE `salary`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `leaves` WHERE `leaves`.`employee_id`={eid}")
#     db.engine.execute(f"DELETE FROM `equipment` WHERE `equipment`.`employee_id`={eid}")
#     flash("all the data deleted successfully")
#     return redirect("/DisplayEmpInfo") 

@app.route("/EmployeeAppraisal",methods=['POST','GET'])
def EmployeeAppraisal():
    if request.method == "POST":
        Emp_perfomance_id=request.form.get('Emp_perfomance_id')
        Employee_Id=request.form.get('Employee_id')
        Emp_rating=request.form.get('Emp_rating')
        Manager_rating=request.form.get('Manager_rating')
        Remarks=request.form.get('Remarks')
        conn = DatabaseConnection()
        cur = conn.cursor()
        cur.execute(f"Call public.sp_emp_appraisal('{Emp_perfomance_id}', '{Employee_Id}', '{Emp_rating}', '{Manager_rating}', '{Remarks}')")
        conn.commit()
        flash("Perfomrance Review recorded")
    return render_template("EmployeeAppraisal.html")

@app.route("/EmpAppraisalView",methods=['POST','GET'])
def EmpAppraisalView():
    db_data=[('None','None','None','None')]
    if request.method == "POST":
        Employee_Id=request.form.get('Employee_Id')
        print (Employee_Id)
        if Employee_Id is not None:
            conn = DatabaseConnection()
            cur = conn.cursor()
            cur.execute(f"Call public.sp_emp_appraisal_view('{Employee_Id}', NULL, NULL, NULL, NULL)")
            db_data = cur.fetchall()
            print (db_data[0][0])
            #conn.commit()
            flash("Performance Review recalled")
    return render_template("EmpAppraisalView.html", appraisal_data = db_data)

@app.route('/employeelist')
def employeelist():
    # cur = mysql.connection.cursor()
    # eid=session.get('eid', None)
    # cur.execute("""SELECT * FROM personaldata""")
    # emps=cur.fetchall()
    # return render_template("employeelist.html",emps=emps)
    return "Employee List"

@app.route('/logout')
def logout():
    return render_template("index.html")

if __name__ == '__main__':
 app.run(debug=True)

 # class HR_User(UserMixin,db.Model):
#     userid=db.Column(db.Integer,primary_key=True, autoincrement=True)
#     username=db.Column(db.String(50), unique= True)
#     email=db.Column(db.String(50),unique=True)
#     password=db.Column(db.String(1000))
#     def get_id(self):
#            return (self.userid)


# class Personaldata(UserMixin,db.Model):
#     __tablename__='Emp_Personal_Data'
#     employee_id=db.Column(db.Integer,primary_key=True)
#     fname=db.Column(db.String(255))
#     lname=db.Column(db.String(255))
#     DOB=db.Column(db.String(50),nullable=False)
#     gender=db.Column(db.String(50))
#     SSN=db.Column(db.Integer)
#     Nationality=db.Column(db.String(255))
#     job_type=db.Column(db.String(255))
#     def get_eid(self):
#            return (self.employee_id)

# class Contactdata(db.Model):
#     __tablename__='contactdata'
#     email=db.Column(db.String(255),primary_key=True)
#     employee_id=db.Column(db.Integer)
#     address=db.Column(db.String(255))
#     city=db.Column(db.String(255))
#     state=db.Column(db.String(255))
#     plz=db.Column(db.Integer)
#     country=db.Column(db.String(255))
#     phone_number=db.Column(db.Integer)

# class Skills(db.Model):
#     __tablename__='skills'
#     employee_id=db.Column(db.Integer,primary_key=True)
#     highest_education=db.Column(db.String(255))
#     skillset=db.Column(db.String(255))
#     work_exp=db.Column(db.Integer)
#     wexp_details=db.Column(db.String(255))

# class Financedata(db.Model):
#     __tablename__='financedata'
#     employee_id=db.Column(db.Integer)
#     bankname=db.Column(db.String(255))
#     iban=db.Column(db.String(255),primary_key=True)
#     taxid=db.Column(db.Integer)

# class Organisationdata(db.Model):
#     __tablename__='organisationdata'
#     employee_id=db.Column(db.Integer,primary_key=True)
#     department_id=db.Column(db.Integer)
#     depatment_name=db.Column(db.String(255))
#     manager_name=db.Column(db.String(255))
#     office_building=db.Column(db.Integer)
#     office_location=db.Column(db.String(255))
#     basecontractor=db.Column(db.String(255))
#     contractordetails=db.Column(db.String(255))

# class Leaves(db.Model):
#     __tablename__='leaves'
#     SNo=db.Column(db.Integer,primary_key=True)
#     employee_id=db.Column(db.Integer,unique=True)
#     leaves_allocated=db.Column(db.Integer)
#     leaves_utilised=db.Column(db.Integer)
#     leaves_remaining=db.Column(db.Integer)

# class Salary(db.Model):
#     __tablename__='salary'
#     salary_id=db.Column(db.Integer,primary_key=True)
#     employee_id = db.Column(db.Integer,unique=True)
#     salary=db.Column(db.Integer)
#     bonus=db.Column(db.Integer)
#     benefits=db.Column(db.String(255))

# class Equipment(db.Model):
#     employee_id=db.Column(db.Integer,primary_key=True)
#     equip_num_data=db.Column(db.String(255))
#Main Page - Login Page
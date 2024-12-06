-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
);

--Part – A
--1. Department, Designation & Person Table’s INSERT, UPDATE & DELETE Procedures.
--PROCEDURE FOR INSERT
-----DEPARTMENT
	CREATE OR ALTER PROCEDURE PR_Department_Insert
	@deptId int,
	@deptName VARCHAR(100)
	AS 
	Begin
		Insert Into Department 
		Values (@deptId , @deptName)
	END

	PR_Department_Insert 1 , 'Admin'
	PR_Department_Insert 2 , 'IT'
	PR_Department_Insert 3 , 'HR'
	PR_Department_Insert 4 , 'Account'
	Select * from Department 
	

----- DESIGNATION 
	CREATE OR ALTER PROCEDURE PR_Designation_Insert
	@DesignationID int,
	@DesignationName VARCHAR(100)
	AS 
	Begin
		Insert Into Designation 
		Values (@DesignationID , @DesignationName)
	END


	PR_Designation_Insert 11 , 'Jobber'
	PR_Designation_Insert 12 , 'Welder'
	PR_Designation_Insert 13 , 'Clerk'
	PR_Designation_Insert 14 , 'Manager'
	PR_Designation_Insert 15 , 'CEO'
	Select * from Designation



-----PERSON 
	CREATE OR ALTER PROCEDURE PR_Person_Insert
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary DECIMAL(8, 2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT
	AS 
	Begin
		Insert Into Person 
		Values (@FirstName , @LastName, @Salary ,  @JoiningDate , @DepartmentID, @DesignationID )
	END

	
	PR_Person_Insert 'Rahul', 'Anshu' , 56000 , '1990-01-01' , 1 , 12
	PR_Person_Insert 'Hardik', 'Hinshu' , 18000 , '1990-09-25' , 2 , 11
	PR_Person_Insert 'Bhavin', 'Kamani' , 25000 , '1991-05-14' , NULL , 11
	PR_Person_Insert 'Bhoomi', 'Patel' , 39000 , '2014-02-20' , 1 , 13
	PR_Person_Insert 'Rohit', 'Rajgor' , 17000 , '1990-07-23' , 2 , 15
	PR_Person_Insert 'Priya', 'Mehta' , 25000 , '1990-10-18' , 2 , NULL
	PR_Person_Insert 'Neha', 'Trivedi' , 18000 , '2014-02-20' , 3 , 15
	Select * from Person

------------ UPDATE --------------------
-----Department  
	CREATE OR ALTER PROCEDURE PR_Department_Update
	@deptId int,
	@deptName VARCHAR(100)
	AS 
	Begin
		Update Department 
		Set DepartmentName = @deptName 
		Where DepartmentID = @deptId 
	END

-----Designation   
	CREATE OR ALTER PROCEDURE PR_Designation_Update
		@DesignationID int,
		@DesignationName VARCHAR(100)
	AS 
	Begin
		Update Designation 
		Set DesignationName = @DesignationName 
		Where DesignationID = @DesignationID 
	END

----Person
	CREATE OR ALTER PROCEDURE PR_Person_Update
		@PersonId int,
		@FirstName VARCHAR(100),
		@LastName VARCHAR(100),
		@Salary DECIMAL(8, 2),
		@JoiningDate DATETIME,
		@DepartmentID INT,
		@DesignationID INT
	AS 
	Begin
		Update Person
		Set FirstName = @FirstName,
			LastName = @LastName,
			Salary = @Salary,
			JoiningDate = @JoiningDate,
			DepartmentID = @DepartmentID,
			DesignationID = @DesignationID
		Where PersonId = @PersonId
	END


--------------------- DELETE -------------------------
---DEPARTMENT 
	CREATE OR ALTER PROCEDURE PR_Department_Delete
		@deptId int,
		@deptName VARCHAR(100)
	AS 
	Begin
		Delete From Department
		Where DepartmentId = @deptId
	END

-----Designation 
	CREATE OR ALTER PROCEDURE PR_Designation_Delete
		@DesignationID int,
		@DesignationName VARCHAR(100)
	AS 
	Begin
		Delete From Designation 
		Where DesignationID = @DesignationID
	END


-----Person
	CREATE OR ALTER PROCEDURE PR_Person_Update
		@PersonId int,
		@FirstName VARCHAR(100),
		@LastName VARCHAR(100),
		@Salary DECIMAL(8, 2),
		@JoiningDate DATETIME,
		@DepartmentID INT,
		@DesignationID INT
	AS 
	Begin
		Delete From Person 
		Where PersonId = @PersonId
	END
--2. Department, Designation & Person Table’s SELECTBYPRIMARYKEY
	
--Department  
	CREATE OR ALTER PROCEDURE PR_Department_Select
		@deptId int,
		@deptName VARCHAR(100)
	AS 
	Begin
		Select * from Department 
	END

--Designation 
	CREATE OR ALTER PROCEDURE PR_Designation_Select
		@DesignationID int,
		@DesignationName VARCHAR(100)
	AS 
	Begin
		Select * from Designation
	END

-- Person
	CREATE OR ALTER PROCEDURE PR_Person_Select
		@PersonId int,
		@FirstName VARCHAR(100),
		@LastName VARCHAR(100),
		@Salary DECIMAL(8, 2),
		@JoiningDate DATETIME,
		@DepartmentID INT,
		@DesignationID INT
	AS 
	Begin
		Select * from Person 
	END
--3. Department, Designation & Person Table’s (If foreign key is available then do write join and take
--columns on select list)

--Department
	CREATE OR ALTER PROCEDURE PR_Department_Select
		@deptId int,
		@deptName VARCHAR(100)
	AS 
	Begin
		Select * from Department 
	END

--Designation 
	CREATE OR ALTER PROCEDURE PR_Designation_Select
		@DesignationID int,
		@DesignationName VARCHAR(100)
	AS 
	Begin
		Select * from Designation
	END

--Person 
	CREATE OR ALTER PROCEDURE PR_Person_Select
		@PersonId int,
		@FirstName VARCHAR(100),
		@LastName VARCHAR(100),
		@Salary DECIMAL(8, 2),
		@JoiningDate DATETIME,
		@DepartmentID INT,
		@DesignationID INT
	AS 
	Begin
		Select * from Person p
		Join Department d 
		on p.DepartmentId = d.DepartmentId
		Join Designation de 
		on p.DesignationId = de.DesignationId 
	END
--4. Create a Procedure that shows details of the first 3 persons.
--Department
	CREATE OR ALTER PROCEDURE PR_Department_Top3
		@deptId int,
		@deptName VARCHAR(100)
	AS 
	Begin
		Select Top 3 * from Department 
	END

--Designation 
	CREATE OR ALTER PROCEDURE PR_Designation_Top3
		@DesignationID int,
		@DesignationName VARCHAR(100)
	AS 
	Begin
		Select Top 3 *  from Designation
	END

--Person 
	CREATE OR ALTER PROCEDURE PR_Person_Top3
		@PersonId int,
		@FirstName VARCHAR(100),
		@LastName VARCHAR(100),
		@Salary DECIMAL(8, 2),
		@JoiningDate DATETIME,
		@DepartmentID INT,
		@DesignationID INT
	AS 
	Begin
		Select Top 3 P.* from Person p
	END

	
--Part – B
--5. Create a Procedure that takes the department name as input and returns a table with all workers
--working in that department.
	CREATE OR ALTER PROCEDURE PR_Department_Workers 
		@deptName VARCHAR(100)
	AS 
	Begin
		Select * from Department d 
		Join Person p
		on d.DepartmentId = p.DepartmentId 
		Where d.DepartmentName = @deptName
	END

PR_Department_Workers 'HR'
--6. Create Procedure that takes department name & designation name as input and returns a table with
--worker’s first name, salary, joining date & department name.
	
--7. Create a Procedure that takes the first name as an input parameter and display all the details of the
--worker with their department & designation name.
--8. Create Procedure which displays department wise maximum, minimum & total salaries.
--9. Create Procedure which displays designation wise average & total salaries.

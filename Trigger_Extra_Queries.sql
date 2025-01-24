--AFTER Trigger
CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
);

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
    EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);

--1)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message "Employee record inserted", "Employee record updated", "Employee record deleted"
	--After Insert
	Create or Alter Trigger Tr_After_Insert
	On EmployeeDetails
	After Insert 
	As 
	Begin
		Print 'Employee Record Inserted'
	End;

	--After Update
	Create or Alter Trigger Tr_After_Update
	On PersonInfo
	After Update
	As 
	Begin
		Print 'Employee record updated'
	End;


	--After Delete
	Create or Alter Trigger Tr_After_Delete
	On PersonInfo
	After Delete
	As 
	Begin
		Print 'Employee record deleted'
	End;

--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the EmployeeLog table.
	--After Insert
	Create or Alter Trigger Tr_After_InsertLog
	On EmployeeDetails
	After Insert 
	As 
	Begin
		Declare @Eid Int,@Ename varchar(50)

		Select @Eid = EmployeeId from inserted
		Select @Ename = EmployeeName from inserted

		Insert Into EmployeeLogs Values 
		(@Eid,@Ename,'Data Is Inserted',GETDATE())
	End;

	--After Update
	Create or Alter Trigger Tr_After_InsertLog
	On EmployeeDetails
	After Update 
	As 
	Begin
		Declare @Eid Int,@Ename varchar(50)

		Select @Eid = EmployeeId from inserted
		Select @Ename = EmployeeName from inserted

		Insert Into EmployeeLogs Values 
		(@Eid,@Ename,'Data Is Updated',GETDATE())
	End;



	--After Delete
	Create or Alter Trigger Tr_After_InsertLog
	On EmployeeDetails
	After Delete 
	As 
	Begin
		Declare @Eid Int,@Ename varchar(50)

		Select @Eid = EmployeeId from inserted
		Select @Ename = EmployeeName from inserted

		Insert Into EmployeeLogs Values 
		(@Eid,@Ename,'Data Is Deleted',GETDATE())
	End;

--3)	Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and update a bonus column in the EmployeeDetails table.
	Create Or Alter Trigger Tr_Calculate_Bonus
	On EmployeeDetails
	After Insert
	As 
	Begin
		Declare @Eid Int

		Select @Eid = EmployeeId from inserted 

		Update EmployeeDetails 
		Set Salary = Salary * 0.1 + Salary
		Where EmployeeID = @Eid
	End;
--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.
	Create Or Alter Trigger Tr_Update_JoiningDate
	On EmployeeDetails
	After Insert
	As 
	Begin
		Declare @EId Int, @jDate Datetime, @currentDate Datetime, @Ename Varchar(50), @Salary DECIMAL(8,2),  @Cno Varchar(20) , @dept Varchar(10)  
		Set @currentDate = GETDATE()
		
		Select @Eid = EmployeeID from inserted
		Select @jDate = JoiningDate from inserted
		Select @Ename = EmployeeName from inserted
		Select @Salary = Salary from inserted
		Select @Cno = ContactNo from inserted
		Select @dept = Department from inserted
		
		If @jDate is NULL
		Begin
			Update EMPLOYEEDETAILS 
			Set JoiningDate = @currentDate
			Where EmployeeId = @EId
		End
	End

--5)	Create a trigger that ensure that ContactNo is valid during insert (Like ContactNo length is 10)
	Create Or Alter Trigger Tr_Validate_ContactNo
	On EmployeeDetails 
	After Insert 
	As
	Begin
		Declare @cno Varchar(100),@EId Int

		Select @cno = ContactNo from inserted 

		Select @EId = EmployeeId from inserted
		Where LEN(@cno) != 10
		
		Delete From EmployeeDetails
		Where EmployeeId = @Eid	
	End;

	Select * from EMPLOYEEDETAILS
	Insert into EMPLOYEEDETAILS values 
	(2 ,'abc','1564664642532532543524','ce',2533,'1-1-2000')

--Instead of Trigger
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLog
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);


--1.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed on the Movies table into MoviesLog.
	--Instead Of Insert
	Create or Alter Trigger Tr_After_InsertLog
	On Movies
	Instead Of Insert 
	As 
	Begin
		Declare @Mid Int,@MTitle varchar(50)

		Select @Mid = MovieId from inserted
		Select @MTitle = MovieTitle from inserted

		Insert Into EmployeeLogs Values 
		(@Mid,@MTitle,'Data Is Inserted',GETDATE())
	End;

	--Instead Of Update
	Create or Alter Trigger Tr_After_InsertLog
	On Movies
	Instead Of Update 
	As 
	Begin
		Declare @Mid Int,@MTitle varchar(50)

		Select @Mid = MovieId from inserted
		Select @MTitle = MovieTitle from inserted

		Insert Into EmployeeLogs Values 
		(@Mid,@MTitle,'Data Is Updated',GETDATE())
	End;


	--Instead Of Delete
	Create or Alter Trigger Tr_After_InsertLog
	On Movies
	Instead Of Delete 
	As 
	Begin
		Declare @Mid Int,@MTitle varchar(50)

		Select @Mid = MovieId from inserted
		Select @MTitle = MovieTitle from inserted

		Insert Into EmployeeLogs Values 
		(@Mid,@MTitle,'Data Is Deleted',GETDATE())
	End;
--2.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .
	Create or Alter Trigger Tr_After_InsertLog
	On Movies
	Instead Of Insert 
	As 
	Begin
		Declare @Mid Int,@rating decimal(3,1)

		Select @Mid = MovieId from inserted
		Select @rating = Rating from inserted


		
	End;
--3.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.

--4.	Create trigger that prevents to insert pre-release movies.

--5.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours) to prevent unrealistic entries.

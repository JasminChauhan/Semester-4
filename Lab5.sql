-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);
-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
);

--Part – A
--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
--a message “Record is Affected.”
	CREATE OR ALTER TRIGGER TR_DISPLAY_MESSAGE
	ON PersonInfo
	After INSERT , UPDATE , DELETE
	As
	Begin
		Print 'Record Is Affected'
	End;

--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--log all operations performed on the person table into PersonLog.
	
	--After Insert
	Create or Alter Trigger Tr_After_Insert
	On PersonInfo
	After Insert 
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Inserted' , GETDATE())
	End;

	--After Update
	Create or Alter Trigger Tr_After_Update
	On PersonInfo
	After Update
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Updated' , GETDATE())
	End;


	--After Delete
	Create or Alter Trigger Tr_After_Delete
	On PersonInfo
	After Delete
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Deleted' , GETDATE())
	End;

--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo
--table. For that, log all operations performed on the person table into PersonLog.
	--Instead Of Insert
	Create or Alter Trigger Tr_Instead_Of_Insert
	On PersonInfo
	Instead Of Insert 
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Inserted' , GETDATE())
	End;
	Drop Trigger Tr_Instead_Of_Insert
	--Instead Of Update
	Create or Alter Trigger Tr_Instead_Of_Update
	On PersonInfo
	Instead Of Update
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Updated' , GETDATE())
	End;


	--Instead Of Delete
	Create or Alter Trigger Tr_Instead_Of_Delete
	On PersonInfo
	Instead Of Delete 
	As 
	Begin
		Declare @Pid INT, @Pname VARCHAR(250)

		Select @Pid = PersonId from inserted
		Select @Pname = PersonName from inserted 

		Insert Into PersonLog Values 
		(@Pid , @Pname , 'Deleted' , GETDATE())
	End;

--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into
--uppercase whenever the record is inserted.
	Create Or Alter Trigger Tr_Convert_UpeerCase
	On PersonInfo
	After Insert
	As
	Begin
		Declare @PersonName VARCHAR(50) , @PersonId INT

		Select @PersonId = PersonId from inserted
		Select @PersonName = PersonName from inserted

		Update PersonInfo
		Set PersonName = UPPER(@PersonName)
		Where PersonId = @PersonId
	End;


	INSERT INTO PersonInfo Values (9,'ffc',464646,'2000-1-1','gsg',4,'2222-2-2')
	Select * from personinfo
	Select * from personlog

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.
	Create Trigger Tr_Prevent_DuplicateName 
	On PersonInfo
	Instead Of Insert
	As
	Begin
		Declare @PersonId INT , @PersonName VARCHAR(250)

		Select @PersonId = PersonId from inserted
		Select @PersonName = PersonName from inserted
		
		Insert Into PersonInfo(PersonId , PersonName , Salary , JoiningDate , City , Age , BirthDate)
		Select PersonId , PersonName , Salary , JoiningDate , City , Age , BirthDate
		from inserted 
		Where PersonName NOT In (Select PersonName from PersonInfo)
	End;
	drop trigger Tr_Prevent_DuplicateName
--6. Create trigger that prevent Age below 18 years.
	Create Or Alter Trigger Tr_Prevent_Age_Below18 
	On PersonInfo
	Instead Of Insert
	As
	Begin
		Declare @PersonId INT , @PersonName VARCHAR(250)

		Select @PersonId = PersonId from inserted
		Select @PersonName = PersonName from inserted
		
		Insert Into PersonInfo(PersonId , PersonName , Salary , JoiningDate , City , Age , BirthDate)
		Select PersonId , PersonName , Salary , JoiningDate , City , Age , BirthDate
		from inserted 
		Where Age > 18
	End;
--Part – B
--7. Create a trigger that fires on INSERT operation on person table, which calculates the age and update
--that age in Person table.
--8. Create a Trigger to Limit Salary Decrease by a 10%.
--Part – C
--9. Create Trigger to Automatically Update JoiningDate to Current Date on INSERT if JoiningDate is NULL
--during an INSERT.
--10. Create DELETE trigger on PersonLog table, when we delete any record of PersonLog table it prints
--‘Record deleted successfully from PersonLog’.
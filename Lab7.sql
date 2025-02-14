-- Create the Customers table
CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY,
 Customer_Name VARCHAR(250) NOT NULL,
 Email VARCHAR(50) UNIQUE
);
-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY,
 Customer_id INT,
 Order_date DATE NOT NULL,
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
)



--Part – A
--1. Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.
	Begin Try
		Declare @num1 INT = 8, @num2 INT = 0 , @ans Int
		Set @ans = @num1 / @num2 
		Print @ans
	End Try
	Begin Catch
		Print 'Error occurs that is - Divide by zero error.'
	End Catch

--2. Try to convert string to integer and handle the error using try…catch block.
	Begin Try
		Declare @string VARCHAR(50)
		Set @string = CAST('Jasmin' as INT)
		Print @string
	End Try
	Begin Catch
		Print 'Can not convert string to integer'
	End Catch

--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.
	Create Or Alter Procedure Pr_Sum
	@n1 Varchar(20),@n2 Varchar(20)
	AS
	Begin
		Begin Try
			Declare @ans INT
			Set @ans = CAST(@n1 As INT) + CAST(@n2 AS INT)
			Print @ans
		End Try
		Begin Catch
			Print 'Can Not Do Sum Because You Given String'
		End Catch
	End
	Exec Pr_Sum '10' , '20'
	Exec Pr_Sum 'Jasmin','8'

--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
--such as the error message, error number, severity, and state.
	Begin Try
		Insert Into Customers Values(1 , 'ABC' , 'abc@darshan.ac.in')
	End Try
	Begin Catch
		Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
		Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
		Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
		Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
	End Catch

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
--Error like no Customer_id is available in database.
	Create Or Alter Procedure Pr_CheckId
	@cId Int
	As
	Begin
		Begin Try
			IF NOT EXISTS (Select 1 from Customers Where Customer_id = @cId)
			Begin
				Throw 50000 , 'Id Not found', 1 
			End
		End Try
		Begin Catch
			Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
			Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
			Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
			Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
		End Catch
	End
	Pr_CheckId 3

--Part – B
--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error
--message.
	Begin Try
		Insert Into Orders Values(1 , 2 ,'2006-08-08')
	End Try
	Begin Catch
		Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
		Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
		Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
		Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
	End Catch

--7. Throw custom exception that throws error if the data is invalid.
	Create Or Alter Procedure Pr_Check_Details
	@name Varchar(20)
	As
	Begin
		Begin Try
			IF @name <> (Select Customer_name from Customers)
			Begin
				Throw 50001 , 'Data Is Not Same', 1 
			End
			Else 
			Begin
				Print 'Data Is Same'
			End
		End Try
		Begin Catch
			Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
			Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
			Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
			Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
		End Catch
	End
	Pr_Check_Details 'JAsmin'
	Select * from Customers

--Part – C
--9. Create a procedure which prints the error message that “The Customer_id is already taken. Try another
--one”.
	Create Or Alter Procedure Pr_CheckCustomer_Id
	@cId Int
	As
	Begin
		Begin Try
			IF EXISTS (Select 1 from Customers Where Customer_id = @cId)
			Begin
				Throw 50000 , 'Id is Already Taken, Try Another One...', 1 
			End
		End Try
		Begin Catch
			Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
			Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
			Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
			Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
		End Catch
	End
	Pr_CheckCustomer_Id 1
	
--10. Handle Duplicate Email Insertion in Customers Table.
	Create Or Alter procedure Pr_CheckEmail
	@cid Int, @name VArchar(56),@email VArchar(30)
	AS
	Begin
		Begin Try
			IF EXISTS (Select 1 from Customers Where Email = @email)
			Begin
				Throw 88888 , 'Email Id Is Already Occupied Try Another One..' , 1
			End
			Else 
			Begin
				Insert Into Customers values(@cid , @name , @email)
			End
		End Try
		Begin Catch
			Print 'Error Message : ' + CAST(Error_Message() AS NVARCHAR(50))
			Print 'Error Number : ' + CAST(Error_Number() AS NVARCHAR(50))
			Print 'Error Severity : ' + CAST(Error_Severity() AS NVARCHAR(50))
			Print 'Error State : ' + CAST(Error_State() AS NVARCHAR(50))
		End Catch
	End
	Pr_CheckEmail 2,'def','abc@darshan.ac.in'
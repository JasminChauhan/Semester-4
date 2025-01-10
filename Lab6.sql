-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);
-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000), 
(5, 'Gaming Console', 32000);

--Part - A
--1. Create a cursor Product_Cursor to fetch all the rows from a products table.
	Declare @ProductId Int, @ProductName VARCHAR(250), @Price DECIMAL(10, 2)
	Declare Product_Cursor Cursor 
	For 
		Select * From Products

	Open Product_Cursor 

	Fetch Next From Product_Cursor  Into @ProductId, @ProductName, @Price

	WHILE @@FETCH_STATUS = 0
	Begin
		Print('Product Id: '+CAST(@ProductId as VARCHAR) + 'Product Name: '+@ProductName + 'Product Price: '+CAST(@Price as VARCHAR));

		Fetch Next From Product_Cursor  Into @ProductId, @ProductName, @Price
	End

	Close Product_Cursor 
	Deallocate Product_Cursor 

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.
--(Example: 1_Smartphone)
	Declare @PId Int, @PName VARCHAR(250)
	Declare Product_Cursor_Fetch Cursor 
	For 
		Select Product_id, Product_Name
		From 
		Products

	Open Product_Cursor_Fetch 

	Fetch Next From Product_Cursor_Fetch  Into  @PId, @PName

	WHILE @@FETCH_STATUS = 0
	Begin
		Print(CAST(@PId as VARCHAR) + '_' + @PName);

		Fetch Next From Product_Cursor_Fetch  Into @PId, @PName
	End

	Close Product_Cursor_Fetch 
	Deallocate Product_Cursor_Fetch
	
--3. Create a Cursor to Find and Display Products Above Price 30,000.
	Declare @Pro_Name VARCHAR(250), @Pro_Price DECIMAL(10, 2)
	Declare Product_Above_30000 Cursor
	For 
		Select Product_Name, Price
		From
		Products 
		Where Price > 30000
	
	Open Product_Above_30000

	Fetch Next From Product_Above_30000 Into @Pro_Name , @Pro_Price

	WHILE @@FETCH_STATUS = 0
	Begin
		Select @Pro_Name,@Pro_Price

		Fetch Next From Product_Above_30000 Into @Pro_Name , @Pro_Price
	End 

	Close Product_Above_30000
	Deallocate Product_Above_30000
	
--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.
	Declare @Pro_Id Int 
	Declare Product_CursorDelete Cursor 
	For 
		Select Product_Id 
		From Products
	
	Open Product_CursorDelete

	Fetch Next From Product_CursorDelete Into @Pro_Id 

	WHILE @@FETCH_STATUS = 0
	Begin
		Delete From Products 
		Where Product_id = @Pro_Id

		Fetch Next From Product_CursorDelete Into @Pro_Id 
	End

	Close Product_CursorDelete 
	Deallocate Product_CursorDelete

--Part – B
--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases
--the price by 10%.
	Declare @P_id Int, @Product_Price Decimal(10,2)
	Declare Product_CursorUpdate Cursor 
	For 
		Select Product_id, Price From Products 

	Open Product_CursorUpdate

	Fetch Next From Product_CursorUpdate Into @P_id , @Product_Price

	WHILE @@FETCH_STATUS = 0
	Begin
		Update Products 
		Set Price = @Product_Price + (@Product_Price * 0.1) 
		Where Product_id = @P_id

		Fetch Next From Product_CursorUpdate Into @P_id , @Product_Price
	End 

	Close Product_CursorUpdate 
	Deallocate Product_CursorUpdate 
	
--6. Create a Cursor to Rounds the price of each product to the nearest whole number.
	Declare @Prod_id Int, @Pr_Price Decimal(10,2)
	Declare Product_CursorRound Cursor 
	For 
		Select Product_id, Price From Products 

	Open Product_CursorRound

	Fetch Next From Product_CursorRound Into @Prod_id , @Pr_Price

	WHILE @@FETCH_STATUS = 0
	Begin
		Update Products 
		Set Price =	ROUND(@Pr_Price , 0)
		Where Product_id = @Prod_id

		Fetch Next From Product_CursorRound Into @Prod_id , @Pr_Price
	End 

	Close Product_CursorRound 
	Deallocate Product_CursorRound 

--Part – C
--7. Create a cursor to insert details of Products into the NewProducts table if the product is “Laptop”
--(Note: Create NewProducts table first with same fields as Products table)
	CREATE TABLE NewProducts (
		Product_id INT PRIMARY KEY,
		Product_Name VARCHAR(250) NOT NULL,
		Price DECIMAL(10, 2) NOT NULL
	);

	Declare @Pr_id Int, @P_name Varchar(250),@pprice Decimal(10,2)
	Declare Cursor_Laptop Cursor
	For 
		Select * from Products 

	Open Cursor_Laptop

	Fetch Next From Cursor_Laptop Into  @Pr_id, @P_name, @pprice




--8. Create a Cursor to Archive High-Price Products in a New Table (ArchivedProducts), Moves products
--with a price above 50000 to an archive table, removing them from the original Products table.
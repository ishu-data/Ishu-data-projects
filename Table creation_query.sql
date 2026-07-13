CREATE TABLE IF NOT EXISTS Books(
     Book_ID SERIAL PRIMARY KEY,
	 Title VARCHAR (100),
	 Author VARCHAR (100),
	 Genre VARCHAR(50),
	 Published_Year INT,
	 Price NUMERIC(10,2),
	 Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers(
    Customer_ID SERIAL PRIMARY KEY,
	Name VARCHAR (100),
	Email VARCHAR(100),
	Phone VARCHAR (15),
	City  VARCHAR (50),
	Country VARCHAR (150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders(
   Order_ID SERIAL PRIMARY KEY,
   Customer_ID INT REFERENCES Customers(Customer_ID),
   Book_ID INT REFERENCES Books(Book_ID),
   Order_date DATE,
   Quantity INT,
   Total_Amount NUMERIC(10,2)
);
SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

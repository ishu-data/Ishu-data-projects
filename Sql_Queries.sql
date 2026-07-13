SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

--List all customers from the cannada
SELECT customer_id, name,city FROM Customers
WHERE city='Canada';

--Show orders placed in November 2023
SELECT order_id,order_date FROM Orders 
WHERE order_date>='2023-11-01'AND order_date<='2023-12-01';

--Retrieve the total stock of books available
SELECT SUM(stock) as total_stock FROM Books; 

--Find the details of the most expensive book
	SELECT B.book_id,B.title,B.author,O.order_id,O.total_amount
	FROM Books as B
	Inner join Orders as O
	on B.book_id=O.book_id
	WHERE O.total_amount=(
              SELECT MAX(O.total_amount) FROM Orders as O 
	);

--Show all customers who ordered more than 1 quantity of boook
SELECT C.customer_id, C.name ,O.quantity
FROM Customers as C
INNER JOIN Orders as O
ON C.customer_id=O.customer_id
WHERE O.quantity>1;

--Retrieve all orders where the total amount exceeds $20
SELECT order_id,book_id ,total_amount 
FROM Orders WHERE total_amount>20;

--List all genres available in the books table
SELECT genre FROM Books ;

--Find the book with the lowest stock
SELECT book_id, title,(stock) FROM Books
WHERE stock=(SELECT MIN(stock) from Books);

--Calculate the total revenue generated from all orders
SELECT SUM(total_amount) as total_revenue FROM Orders;

--Retrieve all the books from fiction genre
SELECT * FROM Books 
WHERE genre = 'Fiction';

--Find Books published after the year 1958
SELECT title ,published_year FROM Books
WHERE published_year> 1958;

--Find the average price of the books in fanatasy genre
SELECT title,AVG(price)OVER(PARTITION BY genre='Fantasy')as avg_price FROM Books;

--Find  customers placed atleast 2 orders
SELECT C.name, O.order_id
From Customers as C
INNER JOIN Orders as O
On C.customer_id=O.order_id;

--Find the most frequently ordered book
SELECT B.book_id,B.title ,COUNT(B.book_id)
FROM Books as B
INNER JOIN Orders as O
On B.book_id=O.book_id
GROUP BY B.book_id, B.title;

--TOP 3 MOST EXPENSIVE BOOKS OF FANTASY GENRE
SELECT book_id, total_amount,DENSE_RANK()OVER(ORDER BY total_amount desc)as rank_books
FROM Orders LIMIT 4;

--Retrieve the total quantity of book sold by each author
WITH CTE_Table2 AS (
   SELECT book_id, SUM(quantity) as Total_quantity
   FROM Orders
   GROUP BY book_id
)
SELECT * FROM CTE_Table2;
--2nd way
SELECT B.author,SUM(O.quantity)
FROM Books as B
INNER JOIN Orders as O
ON B.book_id=O.Order_id
GROUP BY B.author;

--TO find the customer who spent the ,most on orders
WITH CTE_Table3 AS (
    SELECT c.name ,SUM(O.Total_amount) AS Total_price
    FROM Customers as c
	Inner join Orders as O
    On c.customer_id=O.customer_id
    GROUP BY c.name 
)
SELECT * From CTE_Table3
WHERE Total_price=(
      Select max(Total_price) 
	  from CTE_Table3
);

--Calculate the stock remaining after fulfilling all orders
SELECT B.stock, B.stock-O.quantity as remain_stock 
From Books as B
Inner join Orders as O
on B.book_id =O.book_id;
--2nd method
WITH CTE_Table4 as (
   SELECT B.stock, B.stock-O.quantity as remain_stock 
   From Books as B
   Inner join Orders as O
   on B.book_id =O.book_id
)
SELECT remain_stock, c.book_id FROM CTE_Table4
CROSS JOIN Book as c;

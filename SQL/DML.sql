SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- READ ---------------------------------------------------------------------------------------------------------------

-- Basic Selects:

-- get all Customers for the List Customers page
SELECT * FROM Customers
ORDER BY name ASC;

-- get all Employees for the List Employees page
SELECT * FROM Employees
ORDER BY name ASC;

-- get all Products for the List Products page
SELECT * FROM Products
ORDER BY type ASC;

-- get all Orders for the List Orders page
SELECT Orders.orderID, Orders.orderedDateTime, Orders.pickUpDateTime, 
       Orders.orderStatus, Customers.name AS Customer, 
       COALESCE(SUM(ProductsInOrders.qty * Products.price), 0) AS totalCost,
       Employees.name AS Employee
FROM Orders
INNER JOIN Customers ON Orders.customerID = Customers.customerID
LEFT JOIN ProductsInOrders ON Orders.orderID = ProductsInOrders.orderID
LEFT JOIN Products ON ProductsInOrders.productID = Products.productID
LEFT JOIN Employees ON Orders.employeeID = Employees.employeeID
GROUP BY Orders.orderID, Orders.orderedDateTime, Orders.pickUpDateTime, 
         Orders.orderStatus, Customers.name, Employees.name
ORDER BY Orders.pickUpDateTime DESC, Orders.orderedDateTime DESC;

-- get all the Products in an order for the ProductsInOrder pop up page
-- this page will be accessed from the List Orders page, can edit products in the order from this page.
SELECT ProductsInOrders.qty, Products.type, Products.flavor, Products.size, Products.price
FROM Orders 
INNER JOIN ProductsInOrders ON Orders.orderID = ProductsInOrders.orderID
INNER JOIN Products ON ProductsInOrders.productID = Products.productID
WHERE Orders.orderID = :orderIDFromOrdersPage
ORDER BY Orders.pickUpDateTime DESC;

-- SELECTS for populating Update Forms: (NOTE: don't get the IDs, user shou;dn't be able to edit those!)
SELECT * FROM Customers WHERE customerID = :customerIDFromCustomersPage;
SELECT * FROM Employees WHERE employeeID = :employeeIDFromEmployeesPage;
SELECT * FROM Products WHERE productID = :productIDFromProductsPage;
SELECT * FROM Orders WHERE orderID = :orderIDFromOrdersPage;

-- SELECTs for drop downs:
SELECT name, employeeID 
FROM Employees 
ORDER BY name;

SELECT Orders.orderedDateTime, Orders.pickUpDateTime, Customers.name, Orders.orderID 
FROM Orders INNER JOIN Customers ON Orders.customerID = Customers.customerID
ORDER BY orderedDateTime;

SELECT type, size, flavor, price, productID 
FROM Products 
ORDER BY type;


-- CREATE --------------------------------------------------------------------------------------------

-- add a new Customer
INSERT INTO Customers (name, email, phone) 
VALUES (:nameInput, :emailInput, :phoneInput);

-- add a new Employee
INSERT INTO Employees (name, position, email, phone) 
VALUES (:nameInput, :positionInput, :emailInput, :phoneInput);

-- add a new Product
INSERT INTO Products (type, size, flavor, price) 
VALUES (:typeInput, :sizeInput, :flavorInput, :priceInput);

-- add a new Order
INSERT INTO Orders (orderedDateTime, pickUpDateTime, orderStatus, customerID, employeeID) 
VALUES (:currentDateTime, :pickUpDateTimeInput, :orderStatusInput, 
        :customerIDFromDropDown, :employeeIDFromDropDown);


-- associate a Product with an Order
INSERT INTO ProductsInOrders (orderID, productID, qty)
VALUES (:orderIDFromDropDown, :productIDfromDropDown, :qtyInput);

-- UPDATE----------------------------------------------------------------------------------------------------------------------

UPDATE Customers
SET name = :nameInput, email = :emailInput, phone = :phoneInput
WHERE customerId = :customerIDFromUpdateForm; -- id of selected Customer

UPDATE Employees
SET name=: nameInput, position = :positionInput, email = :emailInput, phone = :phoneInput
WHERE employeeID = :employeeIDFromUpdateForm; -- id of selected Employee

UPDATE Products
SET type = :typeInput, size = :sizeInput, flavor = :flavorInput, price = :priceInput
WHERE productID=:productIDFromUpdateForm; -- id of selected Product

UPDATE Orders
SET orderedDateTime =:orderedDateTimeInput, pickUpDateTime =:pickUpDateTimeInput 
    orderStatus =:orderStatusInput, customerID =:customerIDInput, employeeID =:employeeIDInput
WHERE orderID = :orderIDFromUpdateForm

UPDATE ProductsInOrders
SET orderID = :orderIDInput, productID = :productIDInput, qty = :qtyInput
WHERE ProductsInOrdersID = :ProductsInOrdersIDFromUpdateForm;

-- DELETE ------------------------------------------------------------------------------------------------------------------------
-- DELETE FROM table_name WHERE condition;

DELETE FROM Customers 
WHERE customerID = :customerIDFromCustomersPage;

DELETE FROM Employees 
WHERE employeeID = :employeeIDFromEmployeesPage; 

DELETE FROM Products 
WHERE productID = :productIDFromProductsPage; 

DELETE FROM Orders 
WHERE orderID = :orderIDFromOrdersPage 

DELETE FROM ProductsInOrders 
WHERE productID = :productIDFromOrdersAndProductsPage AND orderID = :orderIDFromOrdersAndProductsPage




SET FOREIGN_KEY_CHECKS=1;
COMMIT;
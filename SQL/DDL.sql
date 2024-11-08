SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;

-- may be a problem
DROP TABLE IF EXISTS Customers, Orders, Employees, Products, ProductsInOrders;

----- Base Tables --------------------------------------------------
CREATE OR REPLACE Table Customers (
    customerID int NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    email varchar(255),
    phone varchar(45),
    PRIMARY KEY (customerID)
);

CREATE OR REPLACE Table Orders (
    orderID int NOT NULL AUTO_INCREMENT,
    orderedDateTime DATETIME NOT NULL,
    pickUpDateTime DATETIME NOT NULL,
    orderStatus varchar(45),
    customerID int,
    employeeID int,
    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES Customers(customerID)
    ON DELETE CASCADE,
    FOREIGN KEY (employeeID) REFERENCES Employees(employeeID)
    ON DELETE SET NULL
);

CREATE OR REPLACE Table Employees (
    employeeID int NOT NULL AUTO_INCREMENT,
    name varchar(50) NOT NULL,
    position varchar(50) NOT NULL,
    email varchar(255), 
    phone varchar(45),
    PRIMARY KEY (employeeID)
);

-- Restrict size attribute to 6 and 9 with CHECK (size in (6, 9))
CREATE OR REPLACE Table Products (
    productID int NOT NULL AUTO_INCREMENT,
    type varchar(45) NOT NULL,
    size varchar(45),
    flavor varchar(45) NOT NULL,
    price decimal(18,2) NOT NULL,
    PRIMARY KEY (productID)
);

-------- Intersection Tables --------------------

CREATE OR REPLACE Table ProductsInOrders (
    ProductsInOrdersID int NOT NULL AUTO_INCREMENT,
    orderID int,
    productID int,
    qty int,
    PRIMARY KEY (ProductsInOrdersID),
    FOREIGN KEY (orderID) REFERENCES Orders(orderID)
        ON DELETE CASCADE,
    FOREIGN KEY (productID) REFERENCES Products(productID)
        ON DELETE CASCADE
);


--- Inserting the data----------
INSERT INTO Employees (name, position, email, phone)
VALUES ('Emily Emerson', 'Manager', 'eemerson@email.com', '916-555-1234'),
('Sarah Smith', 'Decorator', 'ssmith@email.com', '916-555-5678'),
('John Mayfield', 'Baker', 'jmayfield@email.com', '530-555-9101'),
('Sally Johnson', 'Clerk', 'sjohnson@email.com', '530-525-9201');

INSERT INTO Products (type, size, flavor, price)
VALUES ('Cake', '9', 'Chocolate', 55),
('Cake', '9', 'Vanilla', 55),
('Cookie', NULL, 'Chocolate Chip', 2.75);

INSERT INTO Customers (name, email, phone)
VALUES ('Party inc', 'partyinc@email.com', '916-444-2535'),
('The Corner Bakery', 'cornerbakery@email.com', '539-444-3434'),
('Cookie Cutters', 'cookiecutters@email.com', '530-444-1212');

INSERT INTO Orders (customerID, employeeID, orderedDateTime, pickUpDateTime, orderStatus)
VALUES (1, 4, '2024-10-10 08:00:00', '2024-10-12 15:00:00', 'Complete'),
(2, 4, '2024-10-11 09:30:00', '2024-10-13 14:00:00', 'Complete'),
(3, 4, '2024-10-12 10:00:00', '2024-10-13 10:00:00', 'Finished. Pending Pick Up.'),
(1, 1, '2024-10-12 11:00:00', '2024-10-12 10:00:00', 'In Progress');

INSERT INTO ProductsInOrders (orderID, productID, qty)
VALUES (1, 2, 2),
(2, 3, 12),
(2, 1, 1),
(3, 3, 54);



SET FOREIGN_KEY_CHECKS=1;
COMMIT;
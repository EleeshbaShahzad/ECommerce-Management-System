USE ecommercedb
##Add Customer
DELIMITER $$
CREATE PROCEDURE usp_AddCustomer(
    IN p_FullName VARCHAR(100),
    IN p_Email VARCHAR(100),
    IN p_Phone VARCHAR(20),
    IN p_City VARCHAR(100)
)
BEGIN
INSERT INTO Customers
(
    FullName,
    Email,
    Phone,
    City
)
VALUES
(
    p_FullName,
    p_Email,
    p_Phone,
    p_City
);
END $$
DELIMITER ;
CALL usp_AddCustomer(
    'Hassan Raza',
    'hassan@gmail.com',
    '03005551234',
    'Karachi'
);
SELECT * FROM Customers;

## Create Order
DELIMITER $$
CREATE PROCEDURE usp_CreateOrder(
    IN p_CustomerID INT,
    IN p_TotalAmount DECIMAL(10,2)
)
BEGIN
INSERT INTO Orders
(
    CustomerID,
    TotalAmount
)
VALUES
(
    p_CustomerID,
    p_TotalAmount
);
END $$
DELIMITER ;
CALL usp_CreateOrder(
    1,
    150000
);
Select * FROM orders
##Create payment
DELIMITER $$
CREATE PROCEDURE usp_AddPayment(
    IN p_OrderID INT,
    IN p_PaymentMethod VARCHAR(50),
    IN p_PaymentAmount DECIMAL(10,2)
)
BEGIN
INSERT INTO Payments
(
    OrderID,
    PaymentMethod,
    PaymentAmount
)
VALUES
(
    p_OrderID,
    p_PaymentMethod,
    p_PaymentAmount
);
END $$
DELIMITER ;
CALL usp_AddPayment(
    1,
    'Credit Card',
    150000
);
SELECT * FROM payments
##UPDATE customers
DELIMITER $$
CREATE PROCEDURE usp_UpdateStock(
    IN p_ProductID INT,
    IN p_NewStock INT
)
BEGIN
UPDATE Products
SET StockQuantity = p_NewStock
WHERE ProductID = p_ProductID;
END $$
DELIMITER ;
CALL usp_UpdateStock(
    1,
    50
);
## ADD REVIEW 
DELIMITER $$
CREATE PROCEDURE usp_AddReview(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Rating INT,
    IN p_ReviewText VARCHAR(500)
)
BEGIN
INSERT INTO Reviews
(
    CustomerID,
    ProductID,
    Rating,
    ReviewText
)
VALUES
(
    p_CustomerID,
    p_ProductID,
    p_Rating,
    p_ReviewText
);
END $$
DELIMITER ;
CALL usp_AddReview(
    2,
    1,
    5,
    'Amazing premium quality product'
);

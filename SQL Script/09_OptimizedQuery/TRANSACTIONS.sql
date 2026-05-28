##SAFE LOAD
START TRANSACTION;
-- Create Order
INSERT INTO Orders
(
    CustomerID,
    OrderDate,
    OrderStatus,
    TotalAmount
)
VALUES
(
    1,
    NOW(),
    'Pending',
    250000
);
-- Create Payment
INSERT INTO Payments
(
    OrderID,
    PaymentMethod,
    PaymentAmount,
    PaymentStatus
)
VALUES
(
    LAST_INSERT_ID(),
    'Credit Card',
    250000,
    'Paid'
);
COMMIT;

##ROLLBACK
START TRANSACTION;
UPDATE Products
SET StockQuantity = StockQuantity - 1000
WHERE ProductID = 1;
ROLLBACK;

##CONDITIONAL STOCK CHECK
START TRANSACTION;
UPDATE Products
SET StockQuantity = StockQuantity - 2
WHERE ProductID = 1
AND StockQuantity >= 2;
COMMIT;

##
DELIMITER $$
CREATE PROCEDURE usp_SafeOrderPlacement()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
ROLLBACK;
SELECT 'Transaction Failed' AS Message;
END;
START TRANSACTION;
INSERT INTO Orders
(
    CustomerID,
    OrderDate,
    OrderStatus,
    TotalAmount
)
VALUES
(
    1,
    NOW(),
    'Confirmed',
    50000
);
UPDATE Products
SET StockQuantity = StockQuantity - 1
WHERE ProductID = 1;
COMMIT;
SELECT 'Transaction Successful' AS Message;
END $$
DELIMITER ;
CALL usp_SafeOrderPlacement();
##

START TRANSACTION;
INSERT INTO Orders
(
    CustomerID,
    OrderDate,
    OrderStatus,
    TotalAmount
)
VALUES
(
    2,
    NOW(),
    'Pending',
    75000
);
SAVEPOINT OrderCreated;
UPDATE Products
SET StockQuantity = StockQuantity - 9999
WHERE ProductID = 1;
ROLLBACK TO OrderCreatEd;
COMMIT;
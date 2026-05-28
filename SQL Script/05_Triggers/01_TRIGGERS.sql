##REDUCE STOCK QUANTITY
DELIMITER $$
CREATE TRIGGER trg_UpdateStockAfterOrder
AFTER INSERT
ON OrderDetails
FOR EACH ROW
BEGIN
UPDATE Products
SET StockQuantity = StockQuantity - NEW.Quantity
WHERE ProductID = NEW.ProductID;
END $$
DELIMITER ;
INSERT INTO OrderDetails
(OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 2, 350000);
SELECT ProductName, StockQuantity
FROM Products
WHERE ProductID = 1;

##PREVENT NEGAIVE STOCK
DELIMITER $$
CREATE TRIGGER trg_PreventNegativeStock
BEFORE UPDATE
ON Products
FOR EACH ROW
BEGIN
IF NEW.StockQuantity < 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Stock cannot be negative';
END IF;
END $$
DELIMITER ;
UPDATE Products
SET StockQuantity = -5
WHERE ProductID = 1;
##AUTO SHIPPING STATUS
DELIMITER $$
CREATE TRIGGER trg_AutoShippingStatus
AFTER INSERT
ON Payments
FOR EACH ROW
BEGIN
UPDATE Shipping
SET ShippingStatus = 'Processing'
WHERE OrderID = NEW.OrderID;
END $$
DELIMITER ;
INSERT INTO Payments
(OrderID, PaymentMethod, PaymentAmount, PaymentStatus)
VALUES
(2, 'Credit Card', 280000, 'Paid');
SELECT *
FROM Shipping
WHERE OrderID = 2;
#ADUIT TABLE
CREATE TABLE ProductAuditLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    ProductID INT,
    OldStock INT,
    NewStock INT,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP
);
#PRODUCT STOCK AUDIT
DELIMITER $$
CREATE TRIGGER trg_ProductStockAudit
AFTER UPDATE
ON Products
FOR EACH ROW
BEGIN
INSERT INTO ProductAuditLog
(
    ProductID,
    OldStock,
    NewStock
)
VALUES
(
    OLD.ProductID,
    OLD.StockQuantity,
    NEW.StockQuantity
);
END $$
DELIMITER ;
UPDATE Products
SET StockQuantity = 25
WHERE ProductID = 1;
SELECT *
FROM ProductAuditLog;

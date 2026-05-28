USE ECommerceDB;
CREATE VIEW vw_CustomerOrderSummary AS
SELECT
    c.CustomerID,
    c.FullName,
    o.OrderID,
    o.OrderDate,
    o.OrderStatus,
    o.TotalAmount
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID;
SELECT *
FROM vw_CustomerOrderSummary;


CREATE VIEW vw_ProductSalesAnalytics AS

SELECT
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold,
    SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Products p
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY
    p.ProductID,
    p.ProductName;
   SELECT *
FROM vw_ProductSalesAnalytics;

CREATE VIEW vw_MonthlyRevenue AS
SELECT
    DATE_FORMAT(OrderDate, '%Y-%m') AS RevenueMonth,
    SUM(TotalAmount) AS MonthlyRevenue
FROM Orders
GROUP BY DATE_FORMAT(OrderDate, '%Y-%m');
SELECT *
FROM vw_MonthlyRevenue;

 CREATE VIEW vw_TopSellingProducts AS

SELECT
    p.ProductName,
    SUM(od.Quantity) AS UnitsSold
FROM Products p
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY UnitsSold DESC;
SELECT *
FROM vw_TopSellingProducts;

CREATE VIEW vw_InventoryStatus AS
SELECT
    ProductID,
    ProductName,
    StockQuantity,
    CASE
        WHEN StockQuantity = 0 THEN 'Out Of Stock'
        WHEN StockQuantity < 10 THEN 'Low Stock'
        ELSE 'In Stock'
    END AS InventoryStatus
FROM Products;
SELECT *
FROM vw_InventoryStatus;

CREATE VIEW vw_PaymentAnalytics AS

SELECT
    PaymentMethod,
    COUNT(*) AS TotalTransactions,
    SUM(PaymentAmount) AS TotalCollected
FROM Payments
GROUP BY PaymentMethod;





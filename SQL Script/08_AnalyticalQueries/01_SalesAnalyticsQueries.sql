USE ECommerceDB;
##Total Revenue
SELECT
    SUM(PaymentAmount) AS TotalRevenue
FROM Payments
WHERE PaymentStatus = 'Paid';
##Montly Revenue
SELECT
    DATE_FORMAT(PaymentDate, '%Y-%m') AS Month,
    SUM(PaymentAmount) AS MonthlyRevenue
FROM Payments
WHERE PaymentStatus = 'Paid'
GROUP BY DATE_FORMAT(PaymentDate, '%Y-%m')
ORDER BY Month;
##Top selling Product
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;
#Best Customer
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalSold
FROM OrderDetails od
JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSold DESC;
##Payment Methiod Analysis 
SELECT
    PaymentMethod,
    COUNT(*) AS TotalTransactions,
    SUM(PaymentAmount) AS TotalCollected
FROM Payments
GROUP BY PaymentMethod
ORDER BY TotalCollected DESC;
##Low stock product
SELECT
    ProductName,
    StockQuantity
FROM Products
WHERE StockQuantity < 20
ORDER BY StockQuantity ASC;
## customer by city
SELECT
    City,
    COUNT(CustomerID) AS TotalCustomers
FROM Customers
GROUP BY City
ORDER BY TotalCustomers DESC;
##Product rating
SELECT 
p.ProductName,
AVG(r.Review) AS AVERAGERATING
FROM Review r
JOIN Product p
WHERE r.ProductID = p.ProductID
ORDER BY AVERAGERATING DESC;
##Order Status Analysis
SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY OrderStatus;
##Running Revenue
SELECT
    PaymentDate,
    PaymentAmount,
    SUM(PaymentAmount)
    OVER (ORDER BY PaymentDate) AS RunningRevenue
FROM Payments
WHERE PaymentStatus = 'Paid';


USE ECommerceDB;
##RANK
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalSold,
    RANK() OVER(
        ORDER BY SUM(od.Quantity) DESC
    ) AS ProductRank
FROM Products p
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName;
##DENSE RANK
SELECT
    p.ProductName,
    SUM(od.Quantity) AS TotalSold,
    DENSE_RANK() OVER(
        ORDER BY SUM(od.Quantity) DESC
    ) AS DenseRankValue
FROM Products p
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY p.ProductName;
##RUNNING REVENUE
SELECT
    OrderDate,
    TotalAmount,
    SUM(TotalAmount)
    OVER(
        ORDER BY OrderDate
    ) AS RunningRevenue
FROM Orders;
##CUSTOMER SEGMENTATION
SELECT
    c.CustomerID,
    c.FullName,
    SUM(o.TotalAmount) AS TotalSpent,
    CASE
        WHEN SUM(o.TotalAmount) >= 500000
        THEN 'Premium Customer'
        WHEN SUM(o.TotalAmount) >= 200000
        THEN 'Gold Customer'
        ELSE 'Regular Customer'
    END AS CustomerSegment
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.FullName;
    
    ##MONTH BY MONTH SALES 
    WITH MonthlySales AS (
    SELECT
        DATE_FORMAT(OrderDate, '%Y-%m') AS SalesMonth,
        SUM(TotalAmount) AS MonthlyRevenue
    FROM Orders
    GROUP BY DATE_FORMAT(OrderDate, '%Y-%m')
)
SELECT *
FROM MonthlySales;
##TOP CUSTOMER
SELECT
    c.FullName,
    SUM(o.TotalAmount) AS TotalSpent,

    ROW_NUMBER() OVER(
        ORDER BY SUM(o.TotalAmount) DESC
    ) AS CustomerPosition
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.FullName;

##SALES BY CATEGORY
SELECT
    cat.CategoryName,
    SUM(od.Quantity * od.UnitPrice) AS CategoryRevenue
FROM Categories cat
JOIN Products p
ON cat.CategoryID = p.CategoryID
JOIN OrderDetails od
ON p.ProductID = od.ProductID
GROUP BY cat.CategoryName
ORDER BY CategoryRevenue DESC;
#AVERAGE ORDER CUSTOMER
SELECT
    AVG(TotalAmount) AS AverageOrderValue
FROM Orders;

##REPEAT CUSTOMER
SELECT
    c.FullName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.FullName
HAVING COUNT(o.OrderID) > 1;

##DAILY SALES TRENDS 
SELECT
    DATE(OrderDate) AS SalesDate,
    SUM(TotalAmount) AS DailyRevenue
FROM Orders
GROUP BY DATE(OrderDate)
ORDER BY SalesDate;
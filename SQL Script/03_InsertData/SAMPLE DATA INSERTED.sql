USE ECommerceDB;
INSERT INTO Customers
(FullName, Email, Phone, City)
VALUES
('Ali Ahmed', 'ali@gmail.com', '03001234567', 'Karachi'),
('Sara Khan', 'sara@gmail.com', '03111234567', 'Lahore'),
('Usman Tariq', 'usman@gmail.com', '03211234567', 'Islamabad'),
('Ayesha Noor', 'ayesha@gmail.com', '03331234567', 'Karachi'),
('Hamza Ali', 'hamza@gmail.com', '03451234567', 'Faisalabad');

INSERT INTO Categories
(CategoryName, Description)
VALUES
('Electronics', 'Electronic gadgets and devices'),
('Fashion', 'Clothing and fashion products'),
('Home Appliances', 'Home usage appliances'),
('Books', 'Educational and story books');

INSERT INTO Products
(ProductName, CategoryID, Brand, Price, StockQuantity)
VALUES
('iPhone 15', 1, 'Apple', 350000, 20),
('Samsung Galaxy S24', 1, 'Samsung', 280000, 15),
('Men T-Shirt', 2, 'Outfitters', 2500, 100),
('Microwave Oven', 3, 'Haier', 45000, 10),
('Atomic Habits', 4, 'Penguin', 1800, 50),
('Dell Laptop', 1, 'Dell', 220000, 8),
('Women Handbag', 2, 'J.', 5500, 40);

INSERT INTO Orders
(CustomerID, OrderStatus, TotalAmount)
VALUES
(1, 'Delivered', 352500),
(2, 'Pending', 280000),
(3, 'Delivered', 46800),
(4, 'Shipped', 225500),
(5, 'Delivered', 5500);

INSERT INTO OrderDetails
(OrderID, ProductID, Quantity, UnitPrice)
VALUES
(1, 1, 1, 350000),
(1, 3, 1, 2500),
(2, 2, 1, 280000),
(3, 4, 1, 45000),
(3, 5, 1, 1800),
(4, 6, 1, 220000),
(4, 5, 3, 1800),
(5, 7, 1, 5500);

INSERT INTO Payments
(OrderID, PaymentMethod, PaymentAmount, PaymentStatus)
VALUES
(1, 'Credit Card', 352500, 'Paid'),
(2, 'Bank Transfer', 280000, 'Pending'),
(3, 'Cash on Delivery', 46800, 'Paid'),
(4, 'Debit Card', 225500, 'Paid'),
(5, 'JazzCash', 5500, 'Paid');

INSERT INTO Shipping
(OrderID, ShippingAddress, ShippingCity, ShippingStatus)
VALUES
(1, 'DHA Phase 5', 'Karachi', 'Delivered'),
(2, 'Johar Town', 'Lahore', 'Processing'),
(3, 'F-10 Sector', 'Islamabad', 'Delivered'),
(4, 'Gulshan-e-Iqbal', 'Karachi', 'Shipped'),
(5, 'People Colony', 'Faisalabad', 'Delivered');

INSERT INTO Reviews
(CustomerID, ProductID, Rating, ReviewText)
VALUES
(1, 1, 5, 'Excellent phone and performance'),
(2, 2, 4, 'Very good Android device'),
(3, 4, 5, 'Microwave quality is amazing'),
(4, 6, 5, 'Laptop performance is outstanding'),
(5, 7, 4, 'Handbag quality is good');



SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM Payments;


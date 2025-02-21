-- Create a table for customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    CreatedDate DATE
);

-- Insert sample data into Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, CreatedDate)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '2025-01-01'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '2025-01-15'),
    (3, 'Alice', 'Johnson', 'alice.johnson@example.com', '2025-02-01');

-- Create a table for orders with a foreign key reference to Customers
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
    (101, 1, '2025-02-10', 150.00),
    (102, 2, '2025-02-15', 200.00),
    (103, 1, '2025-03-01', 100.00);

-- Query 1: Join Customers and Orders to list each customer's orders
SELECT
    c.FirstName,
    c.LastName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY c.LastName, o.OrderDate;

-- Query 2: Aggregate orders by customer to get order count and total spent per customer
SELECT
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS OrderCount,
    SUM(o.TotalAmount) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSpent DESC;

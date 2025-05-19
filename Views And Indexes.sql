USE shophere;

CREATE OR REPLACE VIEW Employees AS
SELECT 
    FirstName,
    LastName,
    Phone
FROM Employee
ORDER BY EmployeeID;

CREATE OR REPLACE VIEW Supplier_Details AS
SELECT
    s.FirstName,
    s.LastName,
    i.ItemName,
    s.Country
FROM SupplierDetails s
JOIN ItemDetails i
USING (SupplierID)
ORDER BY SupplierID;
    
CREATE OR REPLACE VIEW Item_Order_Details AS 
SELECT 
    i.ItemName,
    i.QuantityInHand,
    o.QuantityOrdered,
    o.QuantityRecieved,
    o.OrderDate
FROM orderdetails o
JOIN itemdetails i
USING (ItemID);

CREATE OR REPLACE VIEW Total_cost_for_order AS
SELECT
    PurchaseOrderID,
    OrderDate,
    SUM(QuantityOrdered * UnitPrice) AS Total_Cost
FROM orderdetails
GROUP BY PurchaseOrderID, OrderDate;

CREATE OR REPLACE VIEW Cost_for_employee_order AS 
SELECT
    EmployeeID,
    MONTH(OrderDate) AS OrderMonth,
    YEAR(OrderDate) AS OrderYear,
    SUM(QuantityOrdered * UnitPrice) AS TotalOrderCost
FROM OrderDetails
GROUP BY EmployeeID, Month(OrderDate), Year(OrderDate);

CREATE INDEX Idx_OrderDetails_OrderDate
ON OrderDetails(OrderDate);

CREATE INDEX idx_itemdetails_supplierid
ON ItemDetails(SupplierID);








    
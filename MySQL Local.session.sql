
SELECT * FROM orderdetails;
SELECT * FROM itemdetails;

CREATE TABLE IF NOT EXISTS Employee(
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName  VARCHAR(50) NOT NULL,
    LastName   VARCHAR(50) NOT NULL,
    City       VARCHAR(50) NOT NULL,
    Phone      VARCHAR(25) CHECK(Phone REGEXP '[0-9]{2}-[0-9]{3}-[0-9]{4}-[0-9]{3}-[0-9]{3}') NOT NULL
);

CREATE TABLE IF NOT EXISTS SupplierDetails(SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50)  NOT NULL,
    LastName  VARCHAR(50)  NOT NULL,
    Address   VARCHAR(100) NOT NULL,
    Country   VARCHAR(50)  NOT NULL,
    Phone     VARCHAR(25)  CHECK(Phone REGEXP '[0-9]{2}-[0-9]{3}-[0-9]{4}-[0-9]{3}-[0-9]{3}') NOT NULL
);

CREATE TABLE IF NOT EXISTS ProductCategory(CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName        VARCHAR(20) CHECK(CategoryName IN('Household','Accessories','Sports','Clothings')) NOT NULL,
    CategoryDescription VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS ItemDetails(ItemID INT PRIMARY KEY AUTO_INCREMENT,
    ItemName        VARCHAR(70) NOT NULL,
    ItemDescription VARCHAR(200) NOT NULL,
    QuantityInHand  INT CHECK(QuantityInHand > 0),
    UnitPrice       INT CHECK(UnitPrice > 0),
    ReorderQuantity INT CHECK(ReorderQuantity > 0),
    ReorderLevel    INT CHECK(ReorderLevel > 0),
    CategoryID      INT,
    FOREIGN KEY(CategoryID) REFERENCES ProductCategory(CategoryID),
    SupplierID INT,
    FOREIGN KEY(SupplierID) REFERENCES SupplierDetails(SupplierID)
);






CREATE TABLE IF NOT EXISTS OrderDetails(
    PurchaseOrderID  INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID       INT,
    OrderDate        DATE 
DEFAULT (CURRENT_DATE),
    RecievingDate    DATE,
    ItemID           INT,
    QuantityOrdered  INT CHECK(QuantityOrdered > 0) NOT NULL,
    QuantityRecieved INT CHECK(QuantityRecieved > 0),
    UnitPrice        INT CHECK(UnitPrice > 0) NOT NULL,
    ShipMethod VARCHAR(25),
    OrderStatus  VARCHAR(12) CHECK(OrderStatus IN ('InTransit', 'Recieved', 'Cancelled')) NOT NULL,
    FOREIGN KEY(EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY(ItemID) REFERENCES ItemDetails(ItemID)
    );




SHOW TRIGGERS;





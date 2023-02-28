-- Exercise 1

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customersNames;
DROP TABLE IF EXISTS item_quantity;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS dataOrder;

CREATE TABLE IF NOT EXISTS orders
	(orderId INT,
	date DATE,
	customerId INT,
	customerName VARCHAR(15),
	city VARCHAR(15),
	itemId INT,
	itemName VARCHAR(15),
	quantity INT,
	price REAL,
	PRIMARY KEY (orderId, customerId, itemId)
	);

INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '3786', 'Net', '3', '35.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '4011', 'Racket', '6', '65.00');
INSERT INTO orders VALUES ('2301', '2011-02-23', '101', 'Martin', 'Prague', '9132', 'Pack-3', '8', '4.75');
INSERT INTO orders VALUES ('2302', '2012-02-25', '107', 'Herman', 'Madrid', '5794', 'Pack-6', '4', '5.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '4011', 'Racket', '2', '65.00');
INSERT INTO orders VALUES ('2303', '2011-11-27', '110', 'Pedro', 'Moscow', '3141', 'Cover', '2', '10.00');

CREATE TABLE IF NOT EXISTS customersNames
(
 customerId INT,
 customerName VARCHAR(15),
 city VARCHAR(15),
 PRIMARY KEY (customerId)
);

CREATE TABLE IF NOT EXISTS item_quantity
(
    orderID INT,
    itemID INT,
    quantity REAL,
    PRIMARY KEY (orderID, itemID)
);

CREATE TABLE IF NOT EXISTS items
(
    itemID INT,
    itemName VARCHAR(15),
    price REAL,
    PRIMARY KEY (itemID)
);

CREATE TABLE IF NOT EXISTS dataOrder
(
    orderID INT,
    customerId INT,
    date DATE,
    PRIMARY KEY (orderID)
);

INSERT INTO customersNames (customerId, customerName, city) SELECT distinct customerId, customerName, city FROM orders;
INSERT INTO item_quantity (orderID, itemID, quantity)  SELECT distinct orderID, itemID, quantity FROM orders;
INSERT INTO items (itemID, itemName, price)  SELECT distinct itemID, itemName, price FROM orders;
INSERT INTO dataOrder (orderID, customerId, date) SELECT distinct orderID, customerId, date FROM orders;

select min(sum)
    from (select sum(item_quantity.quantity * items.price) as sum
          from item_quantity join items on item_quantity.itemID = items.itemID
          group by item_quantity.orderID
          ) as qis;

select customersNames.customerName, customersNames.city from customersNames inner join dataOrder on dataOrder.customerId = customersNames.customerId
inner join (with order_quantity as (
    select item_quantity.orderID as orderID, sum(item_quantity.quantity) as sum
    from item_quantity
    group by item_quantity.orderID
)

select order_quantity.orderID, order_quantity.sum
from order_quantity
where order_quantity.sum = (
    select max(order_quantity.sum)
    from order_quantity)
) as order_quantity on order_quantity.orderID = dataOrder.orderID;

-- Exercise 2

CREATE TABLE loan_books
	(school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    grade VARCHAR(15),
    book VARCHAR(60),
    publisher VARCHAR(30),
    loanDate DATE
	--,
--	PRIMARY KEY (???)
	);

INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1st grade', 'Preschool, N56', 'Taylor & Francis Publishing', '2010-05-05');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', 2010-05-05);
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1st grade', 'Early Childhood Education N9', 'Prentice Hall', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2nd grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2nd grade', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-05-05');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1st grade', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-12-18');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');

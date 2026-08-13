create database user2;
use user2;
create table Restaurants(restaurant_id tinyint primary key ,restaurant_name varchar(30),loaction varchar(20),cuisine varchar(15));
select * from Restaurants;
create table Menu (menu_id int primary key , restaurant_id tinyint, item_name varchar(100), price decimal(10,2), availability 
varchar(20),Foreign key (restaurant_id) references Restaurants(restaurant_id));
select * from Menu;
create table Customers (customer_id int primary key,customer_name varchar(100),phone varchar(15),city varchar(50));
select * from Customers;
create table Orders (order_id int primary key,customer_id int,menu_id int,quantity int,order_date DATE,order_status VARCHAR(30),FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),FOREIGN KEY (menu_id) REFERENCES Menu(menu_id));
select * from Orders;
create table Payments (payment_id int primary key,order_id int,payment_method varchar(30),amount decimal(10,2),payment_status varchar(30),payment_date date,foreign key (order_id) references Orders(order_id));
select * from Payments;
# insert values 
INSERT INTO restaurants VALUES
(101,'Spicy Kitchen', 'Hyderabad', 'Indian'),
(102,'Pizza Hub', 'Bengaluru', 'Italian'),
(103,'Dragon Bowl', 'Chennai', 'Chinese'),
(104,'Burger World', 'Vijayawada', 'Fast Food'),
(105,'Ocean Grill', 'Visakhapatnam', 'Seafood');
select * from Restaurants;
INSERT INTO Menu VALUES
(201,101,'Chicken Biryani',250,'Available'), (202,101,'Paneer Curry',180,'Available'),
(203,102,'Veg Pizza',350,'Available'), (204,102,'Cheese Pasta',280,'Available'),
(205,103,'Noodles',220,'Available'), (206,103,'Fried Rice',240,'Unavailable'), (207,104,'Chicken
Burger',180,'Available'), (208,104,'French Fries',120,'Available'), (209,105,'Grilled
Fish',450,'Available'), (210,105,'Prawn Curry',500,'Available');
select * from Menu;
INSERT INTO Customers VALUES
(301,'Aarav','9876500001','Hyderabad'), (302,'Bhavya','9876500002','Vijayawada'),
(303,'Charan','9876500003','Vizag'), (304,'Divya','9876500004','Bengaluru'),
(305,'Esha','9876500005','Chennai'), (306,'Farhan','9876500006','Mumbai'),
(307,'Gopi','9876500007','Warangal'), (308,'Harini','9876500008','Guntur'),
(309,'Ishaan','9876500009','Pune'), (310,'John','9876500010','Kochi');
select * from Customers;
INSERT INTO Orders VALUES
(401,301,201,2,'2026-07-01','Delivered'), (402,302,203,1,'2026-07-02','Delivered'),
(403,303,205,3,'2026-07-03','Preparing'), (404,304,207,2,'2026-07-04','Delivered'),
(405,305,210,1,'2026-07-05','Cancelled'), (406,306,202,2,'2026-07-06','Delivered'),
(407,307,208,4,'2026-07-07','Delivered'), (408,308,209,1,'2026-07-08','Preparing'),
(409,309,204,2,'2026-07-09','Delivered'), (410,310,201,1,'2026-07-10','Delivered'),
(411,301,210,2,'2026-07-11','Preparing'), (412,303,203,1,'2026-07-12','Delivered');
select * from Orders;
INSERT INTO Payments VALUES
(501,401,'UPI',500,'Paid','2026-07-01'),
(502,402,'Card',350,'Paid','2026-07-02'),
(503,403,'UPI',660,'Paid','2026-07-03'),
(504,404,'Cash',360,'Paid','2026-07-04'),
(505,405,'Card',500,'Refunded','2026-07-05'),
(506,406,'UPI',360,'Paid','2026-07-06'),
(507,407,'Cash',480,'Paid','2026-07-07'),
(508,408,'UPI',450,'Pending','2026-07-08'),
(509,409,'Card',560,'Paid','2026-07-09'),
(510,410,'UPI',250,'Paid','2026-07-10'),
(511,411,'Card',1000,'Pending','2026-07-11'),
(512,412,'Cash',350,'Paid','2026-07-12');
select * from Payments;
#____________________________________________________________________QUESTIONS___________________________________________________________________________
# 1. Display all restaurants and their cuisine types
select restaurant_name,cuisine from Restaurants;
# 2. Update the order status from Preparing to Delivered.
update orders set order_status='Delivered' where order_status='Preparing';
set sql_safe_updates=0;
select * from Orders;
# 3. Increase the price of all food items in a specific restaurant by 10%.
update Menu set price=price*1.10 where restaurant_id =101;
select * from Menu;
# 4. Delete a cancelled order.
delete from  Orders where order_status = 'Cancelled';
# 5. Display all restaurant names in uppercase
select upper(restaurant_name) as Restaurant_name from Restaurants;
# 6. Display all menu item names in lowercase.
select lower(item_name) as Menu_Item_Name from Menu;
# 7. Display the first five characters of each menu item.
select left(item_name,5) as  first_five_characters from Menu;
# 8. Concatenate the customer name and city.
select concat(customer_name, ' ',city) as name_city from customers;
# 9. Replace the word Chicken with Grilled in product names.
select replace(item_name,'Chicken','Grilled') as new_item from Menu;
# 10. Display last week orders
select * from Orders where order_date >= '2026-07-12' - interval 7 day;
# 11. Display the day name for every order date.
select  order_date,dayname(order_date) as  day_name from Orders;
# 12. Find the number of days since each order was placed.
select order_date, datediff(curdate(), order_date) as  days_since_order from  Orders;
# 13. Display the payment date in DD-Monday-YYYY format.
select payment_date, date_format(payment_date, '%d-%W-%Y') as  formated_date from  payments;
# 14. Display the month and year of each payment.
select payment_date,date_format(payment_date,'%M-%Y') as month_year from payments;
# 15. Count the total number of menu items available in each restaurant.
select r.restaurant_name,count(m.menu_id) as  available_items from  Restaurants r left join Menu m on  r.restaurant_id = m.restaurant_id and  m.availability = 'Available' group by  r.restaurant_name;
# 16. Display the average product of menu items for every restaurant.
select r.restaurant_name,avg (m.price) as  average_price from  Restaurants r join  Menu m on  r.restaurant_id = m.restaurant_id group by  r.restaurant_name;
# 17. Find the highest payment amount received.
select  max(amount) as highest_payment from Payments;
# 18. Display the total revenue generated by each restaurant.
select r.restaurant_name,sum(p.amount) AS total_revenue from Restaurants r join Menu m on r.restaurant_id = m.restaurant_id join Orders o on m.menu_id = o.menu_id join Payments p on o.order_id = p.order_id where p.payment_status = 'Paid' group by r.restaurant_id, r.restaurant_name;
# 19. Find the total quantity ordered for each menu item.
select m.item_name,sum(o.quantity) as total_quantity from Menu m join Orders o on m.menu_id=o.menu_id group by m.menu_id,m.item_name;
# 20. Display customer names along with the food items they ordered.
select c.customer_name, m.item_name from Customers c join Orders o on c.customer_id = o.customer_id join Menu m on o.menu_id = m.menu_id;
# 21.Display restaurant names with their menu items.
select * from restaurants;
select * from menu;
select  r.restaurant_name,m.item_name from Restaurants r join  Menu m on  r.restaurant_id = m.restaurant_id; 
# 22.Display customer names, ordered food items, and order status.
select c.customer_name,m.item_name,o.order_status from Customers c join Orders o on c.customer_id=o.customer_id join Menu m on m.menu_id=o.menu_id;
# 23.Display restaurant names, menu items, quantity ordered, and payment amount.
select r.restaurant_name,m.item_name,o.quantity,p.amount from Restaurants r join Menu m on r.restaurant_id = m.restaurant_id join Orders o on m.menu_id = o.menu_id join Payments p on o.order_id = p.order_id;
# 24.Display all restaurants and their menu items, even if no orders have been placed.
select r.restaurant_name,m.item_name,o.quantity,p.amount from Restaurants r join Menu m on r.restaurant_id = m.restaurant_id join Orders o on m.menu_id = o.menu_id join Payments p on o.order_id = p.order_id;
#24. Display all restaurants and their menu items, even if no orders have been placed 
select r.restaurant_name,m.item_name from Restaurants r left join Menu m on r.restaurant_id = m.restaurant_id;
#25. Display customer names, restaurant names, ordered food items, and order dates in a single result.
select c.customer_name,r.restaurant_name,m.item_name,o.order_date from Customers c join Orders o on c.customer_id = o.customer_id join Menu m on o.menu_id = m.menu_id join Restaurants r on m.restaurant_id = r.restaurant_id;
#26. Find customers whose payment amount is greater than the average payment amount
select distinct c.customer_name,p.amount from Customers c join Orders o on c.customer_id = o.customer_id join Payments p on o.order_id = p.order_id where p.amount > (select avg(amount)from Payments);
#27 .Display the restaurant that serves the most expensive food item                                                                                       
select r.restaurant_name,m.item_name, m.price from Restaurants r join Menu m on r.restaurant_id = m.restaurant_id where m.price = (select max(price) from Menu);
# 28 Find customers who ordered the highest-priced menu item.                                                                                             
select c.customer_name from Customers c join Orders o on c.customer_id = o.customer_id join Menu m on o.menu_id = m.menu_id where m.price = (select  max(price) from menu);
#29. Display restaurants that have never received an order
select * from restaurants;
select * from orders;
select r.restaurant_name from Restaurants r left join Orders o on  r.restaurant_id = o.customer_id where o.order_id is null;
#30. Create a view named Customer_Order_History displaying customer name, restaurant name, menu item, quantity, and order status.
create view Customer_Order_History as select c.customer_name,r.restaurant_name,m.item_name,o.quantity,o.order_status from Customers c join Orders o on c.customer_id = o.customer_id join Menu m on o.menu_id = m.menu_id join Restaurants r on m.restaurant_id = r.restaurant_id;
select * from Customer_Order_History;
# 31. Create a view named Restaurant_Revenue displaying restaurant name, total orders, and total revenue.
create view Restaurant_Revenue as select r.restaurant_name,count(o.order_id) as total_orders,sum(p.amount) as total_revenue from Restaurants r join Menu m on r.restaurant_id = m.restaurant_id join Orders o on m.menu_id = o.menu_id join Payments p on o.order_id = p.order_id where p.payment_status = 'Paid' group by r.restaurant_id, r.restaurant_name;
select * from restaurant_revenue;
#32. Retrieve records from both views.
select * from Customer_Order_History;
select * from Restaurant_Revenue;
#33. Start a transaction Update the price of a menu item. Create a SAVEPOINT. Then update the payment status of an order. Roll back to the savepoint. Commit the transaction.
start transaction;
#1. Update the price of a menu item
update Menu set price = 300 where menu_id = 201;
#2. Create a SAVEPOINT
savepoint price_update;
#3. Update the payment status of an order
update Payments set payment_status = 'Paid' where order_id = 411;
#4. Roll back only the payment status update
rollback to savepoint price_update;
#5. Commit the price update
commit;
# 34. Create a stored procedure to display all orders placed by a particular customer.
call GetCustomerOrders(301); 
# 35. create a store procedure to calculate the  total amount spent by a customer.
call  GetTotalAmountSpent(302);
# 36. create a before delete trigger on orders table whenever order is deleted store the delete order details in orders achieve.
CREATE TABLE Order_Archive (
    order_id INT,
    customer_id INT,
    menu_id INT,
    quantity INT,
    order_date DATE,
    order_status VARCHAR(30),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
select * from Order_Archive;
SELECT * FROM Orders;
set sql_safe_updates=0;
SHOW TRIGGERS;
SELECT * FROM Orders WHERE order_id = 406;
SELECT * FROM Payments WHERE order_id = 410;
delete from Payments where order_id=410;
DELETE FROM Orders WHERE order_id = 410;
# 37.Create a after update trigger an orders table whenever the order status changes automatically store the old status,new status and order id in order status history table
CREATE TABLE Order_Status_History (history_id INT AUTO_INCREMENT PRIMARY KEY,order_id INT, old_status VARCHAR(30),new_status VARCHAR(30),changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
select * from Order_Status_History;
UPDATE Orders SET order_status = 'Preparing' WHERE order_id = 411;
SELECT * FROM Order_Status_History; 
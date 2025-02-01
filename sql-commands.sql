insert into demo.products(code,name,price,release_date) 
values
(
3,'Air pad',1300.5,STR_TO_DATE('15-09-2021','%d-%m-%Y'));
select * from demo.products;

select a.code,a.price,a.release_date from demo.products as a
where a.price >1000;

select a.code,a.price,a.release_date from demo.products as a
 where  year(a.release_date) > 2020;
 
 select extract( YEAR FROM date_format(release_date , '%y-%m-%d'))
 from demo.products;
 
 #aggregate functions
 select count(*) from demo.products;
 
 select count(*) from demo.products
 where price >1000 ; 
 
 select sum(price) from demo.products
 where price >1000 ;
 
 select avg(price) from demo.products
 where price >1000 ;
 
 #modify data with update
 update products
 set price = 900
 where products.name = 'iphone16';
 
  update products
 set price = 500
 where products.name like 'Air%';
 ##remove 
# delete from products
 #where count(select * from products where name like "Air%");
 
 #create a backup table
 create table products_bkp
 as 
 select * from products;
 
 #copy just a structure of table with out data
 create table products_pkp2
 as 
 select * from products
 where 1=2;
 
 select * from demo.products_pkp2;
 ########################################
 drop table if exists products;
  create table products(
  code int, 
  name varchar(50),
  price float,
  release_date date,
  constraint pk_prod primary key(code, name)
  );
  ##we could not have two primary key at line definition thefore we use constraint 
create table products(
  code int primary key, 
  name varchar(50) primary key, #error because of multiple primary key
  price float,
  release_date date,
  constraint pk_prod primary key(code, name) #composite primary key
  );
 
  select * from products;
  
  create table products(
  code int not null auto_increment, #generated as identity
  name varchar(50),
  price float,
  release_date date,
  constraint pk_prod primary key(code)
  );
insert into demo.products(code,name,price,release_date) 
values
(default,'iphone 16',1300.5,STR_TO_DATE('15-09-2024','%d-%m-%Y')),
(default,'iphone 13',800,STR_TO_DATE('15-09-2021','%d-%m-%Y')),
(default,'Air pad',1300.5,STR_TO_DATE('15-09-2021','%d-%m-%Y'));
create table sales_order
(
order_id int not null auto_increment primary key,
order_date date,
quantity int,
product_id int ,
customer_id int,
emp_id int,
status varchar(30),
constraint FK_Prods_Sales_Order  foreign key(product_id) references products(code) ,
constraint FK_Sales_CUST_Order  foreign key(customer_id) references customers(customer_id) ,
constraint FK_emp_Sales_Order  foreign key(emp_id) references employee(id) 
);

insert into demo.sales_order
(
order_id,
order_date,
quantity,
product_id,
customer_id,
emp_id,
status
) 
values
(default,STR_TO_DATE('15-09-2024','%d-%m-%Y'), 1,2,1,1,'completed'),
(default,STR_TO_DATE('12-05-2021','%d-%m-%Y'), 3,3,2,2,'completed'),
(default,STR_TO_DATE('15-09-2022','%d-%m-%Y'), 2,1,3,2,'completed');
 
 select * from sales_order;
 drop table if exists sales_order;
 
 drop table if exists customers;
 create table customers
 (
  customer_id int not null auto_increment primary key,
  name varchar(100),
  email varchar(30),
  order_id int 
 );
 
insert into demo.customers(customer_id,name,email) 
values
(default,'Daniel', 'dgustrow@gmail.com'),
(default,'Petra', 'petra123@gmail.com'),
(default,'Uwe', 'Uwe79@gmail.com');

create table employee
(
id int not null auto_increment primary key,
name varchar(30)
);

insert into employee values(default,'Nina Kumari');
insert into employee values(default,'Abrar Khan');
insert into employee values(default,'Irene Costa');

 select sal.order_id,sal.quantity,sal.status,sal.order_date,
 prod.code,prod.name,prod.price, prod.release_date
 from sales_order as sal
 inner join products as prod
 on sal.product_id = prod.code
 where sal.status like '%completed%';
 
 #wie viele produkte wurden verkauf 
 select sum(quantity) as total_sold_products from sales_order;
insert into demo.sales_order
(
order_id,
order_date,
quantity,
product_id,
customer_id,
emp_id,
status
) 
values
(default,STR_TO_DATE('15-09-2024','%d-%m-%Y'), 3,2,2,3,'Pending');

insert into demo.sales_order
(
order_id,
order_date,
quantity,
product_id,
customer_id,
emp_id,
status
) 
values
(default,STR_TO_DATE('15-09-2024','%d-%m-%Y'), 1,3,3,1,'pending');
select * 
from sales_order
where status not in ('Pending');

select * 
from sales_order
where lower(status)='pending';

select so.order_date,so.quantity,so.product_id,po.name,po.price,
cus.name, so.quantity*po.price as total_FEE from 
sales_order as so inner join 
customers as cus 
on so.customer_id = cus.customer_id
inner join products as po
on so.product_id = po.code
where lower(so.status)='completed'
order by so.order_date;

select status, count(*) as total from sales_order
group by status;
select * from sales_order;
####case when subQuery
select status, case status when 'pending'
				then 'Pending'
                else status
                end  as updated_status 
from sales_order;

select status, count(*) as total 
from (select status, case status when 'pending'
				then 'Pending'
                else status
                end  as updated_status 
from sales_order) ql
group by status;

#find total product purchased by each customer
select cus.name,sum(sa.quantity) from sales_order as sa
join customers as cus 
on sa.customer_id=cus.customer_id
group by cus.name;


##winodow function or analytic function






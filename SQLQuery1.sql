
--sql is not case sensitive and two hyphen is how you add comments to SQL server

/*
everything in the middle is comment YAY! 
or you do not want to run specific queries
*/

create table AMAZON_CUSTOMER(
customer_id varchar(10), --primary key
first_name varchar(30),
last_name varchar(30),
dob date, --not null
join_date date default GetDate(), --if customer does not put date, it will put today's date as a default
constraint amazon_customer_pk primary key (customer_id)
);--last line where constraint is, cannot put comment

drop table AMAZON_CUSTOMER;

create table AMAZON_PRODUCT(
product_id varchar(11),
product_description varchar(90),
manufacturer varchar(60),
product_type int check(product_type in (10, 22, 29, 49, 69, 89)),
msrp decimal(5,2), --hightest allowed value? 99999.99
list_price decimal(5,2),
constraint amazon_product_pk primary key (product_id)
);

insert into AMAZON_PRODUCT(product_id, product_description, product_type)
values('8383354', 'some cool product', 15) --it is termintated since 15 is not in check(in())

insert into AMAZON_PRODUCT(product_id, product_description, product_type)
values('8383354', 'some cool product', 22)

create table AMAZON_SHOPPING_CART(
shopping_id int,
customer_id varchar(10),
product_id varchar(11),
purchase_price decimal(5,2),
shopping_date date default GetDate()-1,
constraint amazon_shopping_pk primary key (shopping_id),
constraint amazon_shopping_fk1 foreign key (customer_id) references AMAZON_CUSTOMER (customer_id),
constraint amazon_shopping_fk2 foreign key (product_id) references AMAZON_PRODUCT (product_id)
);
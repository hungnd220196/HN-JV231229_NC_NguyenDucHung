
create database QUANLYBANHANG;
use QUANLYBANHANG;


-- Tạo bảng customers
create table customers
(
    customer_id varchar(4) primary key,
    name        varchar(100) not null,
    email       varchar(100) not null unique,
    phone       varchar(25)  not null unique,
    address     varchar(255) not null

);

-- Tạo bảng orders
create table orders
(
    order_id     varchar(4) primary key,
    customer_id  varchar(4) not null,
    order_date   date       not null,
    total_amount double     not null

);

-- Tạo bảng products
create table products
(
    product_id  varchar(4) primary key,
    name        varchar(255) not null,
    description text,
    price       double       not null,
    status      bit(1)       not null
);


-- Tạo bảng orders_details
create table orders_details
(
    order_id   varchar(4) not null,
    product_id varchar(4) not null,
    quantity   int(11)    not null,
    price      double     not null,
    primary key (order_id, product_id),
    foreign key (order_id) references orders (order_id),
    foreign key (product_id) references products (product_id)

);


# Bài 2: Thêm dữ liệu

# Thêm dữ liệu vào Bảng CUSTOMERS:
insert into CUSTOMERS (customer_id, name, email, phone, address)
values ('C001', 'Nguyễn Trung Mạnh', 'manhnt@gmail.com', '984756322', 'Cầu Giấy, Hà Nội'),
       ('C002', 'Hồ Hải Nam', 'namhh@gmail.com', '984875926', 'Ba Vì, Hà Nội'),
       ('C003', 'Tô Ngọc Vũ', 'vutn@gmail.com', '904725784', 'Mộc Châu, Sơn La'),
       ('C004', 'Phạm Ngọc Anh', 'anhpn@gmail.com', '984635365', 'Vinh, Nghệ An'),
       ('C005', 'Trương Minh Cường', 'cuongtm@gmail.com', '989735624', 'Hai Bà Trưng, Hà Nội');

# Thêm dữ liệu vào Bảng PRODUCTS:
insert into PRODUCTS (product_id, name, description, price, status)
values ('P001', 'Iphone 13 ProMax', 'Bản 512 GB, xanh lá', 22999999, 1),
       ('P002', 'Dell Vostro V3510', 'Core i5, RAM 8GB', 14999999, 1),
       ('P003', 'Macbook Pro M2', '8CPU 10GPU 8GB 256GB', 28999999, 1),
       ('P004', 'Apple Watch Ultra', 'Titanium Alpine Loop Small', 18999999, 1),
       ('P005', 'Airpods 2 2022', 'Spatial Audio', 4090000, 1);

# Thêm dữ liệu vào Bảng ORDERS:
insert into ORDERS (order_id, customer_id, total_amount, order_date)
values ('H001', 'C001', 52999997, '2023-02-22'),
       ('H002', 'C001', 80999997, '2023-03-11'),
       ('H003', 'C002', 54359998, '2023-01-22'),
       ('H004', 'C003', 102999995, '2023-03-14'),
       ('H005', 'C003', 80999997, '2022-03-12'),
       ('H006', 'C004', 110449994, '2023-02-01'),
       ('H007', 'C004', 79999996, '2023-03-29'),
       ('H008', 'C005', 29999998, '2023-02-14'),
       ('H009', 'C005', 28999999, '2023-01-10'),
       ('H010', 'C005', 149999994, '2023-04-01');

# Thêm dữ liệu vào Bảng ORDERS_DETAILS:
insert into ORDERS_DETAILS (order_id, product_id, quantity, price)
values ('H001', 'P002', 1, 14999999),
       ('H001', 'P004', 2, 18999999),
       ('H002', 'P001', 1, 22999999),
       ('H002', 'P003', 2, 28999999),
       ('H003', 'P004', 2, 18999999),
       ('H003', 'P005', 4, 4090000),
       ('H004', 'P002', 3, 14999999),
       ('H004', 'P003', 2, 28999999),
       ('H005', 'P001', 1, 22999999),
       ('H005', 'P003', 2, 28999999),
       ('H006', 'P005', 5, 4090000),
       ('H006', 'P002', 6, 14999999),
       ('H007', 'P004', 3, 18999999),
       ('H007', 'P001', 1, 22999999),
       ('H008', 'P002', 2, 14999999),
       ('H009', 'P003', 1, 28999999),
       ('H010', 'P003', 2, 28999999),
       ('H010', 'P001', 4, 22999999);

# Bài 3: Truy vấn dữ liệu [30 điểm]:
# 1. Lấy ra tất cả thông tin gồm: tên, email, số điện thoại và địa chỉ trong bảng Customers .
# [4 điểm]
select name, email, phone, address
from customers;

# 2. Thống kê những khách hàng mua hàng trong tháng 3/2023 (thông tin bao gồm tên, số điện
# thoại và địa chỉ khách hàng). [4 điểm]
select name, phone, address
from orders
         join customers c on orders.customer_id = c.customer_id
where order_date >= '2023-3-1'
  and order_date <= '2023-3-31';

# 3. Thống kê doanh thu theo từng tháng của cửa hàng trong năm 2023 (thông tin bao gồm
# tháng và tổng doanh thu ). [4 điểm]
select month(order_date) as Month,
       sum(total_amount) as TotalRevenue
from orders
where year(order_date) = 2023
group by month(order_date);


# 4. Thống kê những người dùng không mua hàng trong tháng 2/2023 (thông tin gồm tên khách
# hàng, địa chỉ , email và số điên thoại). [4 điểm]
select c.name    as CustomerName,
       c.address as Address,
       c.email   as Email,
       c.phone   as PhoneNumber
from customers c
where c.customer_id not in (select distinct o.customer_id
                            from orders o
                            where month(o.order_date) = 2
                              and year(o.order_date) = 2023);

# 5. Thống kê số lượng từng sản phẩm được bán ra trong tháng 3/2023 (thông tin bao gồm mã
# sản phẩm, tên sản phẩm và số lượng bán ra). [4 điểm]
select od.product_id, name, quantity
from orders_details od
         join products p on p.product_id = od.product_id
         join orders o on o.order_id = od.order_id
where month(order_date) = 3
  and year(order_date) = 2023
group by od.product_id, name, quantity;

# 6. Thống kê tổng chi tiêu của từng khách hàng trong năm 2023 sắp xếp giảm dần theo mức chi
# tiêu (thông tin bao gồm mã khách hàng, tên khách hàng và mức chi tiêu). [5 điểm]

select o.customer_id       as CustomerID,
       c.name              as CustomerName,
       sum(o.total_amount) as TotalSpending
from orders o
         join
     customers c on o.customer_id = c.customer_id
where year(o.order_date) = 2023
group by o.customer_id, c.name
order by TotalSpending desc;

# 7. Thống kê những đơn hàng mà tổng số lượng sản phẩm mua từ 5 trở lên (thông tin bao gồm
# tên người mua, tổng tiền , ngày tạo hoá đơn, tổng số lượng sản phẩm) . [5 điểm]

select c.name           as CustomerName,
       o.total_amount   as TotalAmount,
       o.order_date     as OrderDate,
       sum(od.quantity) as TotalQuantity
from orders o
         join
     customers c on o.customer_id = c.customer_id
         join
     orders_details od on o.order_id = od.order_id
group by o.order_id, c.name, o.total_amount, o.order_date
having sum(od.quantity) >= 5;

# Bài 4: Tạo View, Procedure [30 điểm]:
# 1. Tạo VIEW lấy các thông tin hoá đơn bao gồm : Tên khách hàng, số điện thoại, địa chỉ, tổng
# tiền và ngày tạo hoá đơn . [3 điểm]
create view order_info as
select c.name, c.phone, c.address, total_amount, order_date
from orders
         join customers c on orders.customer_id = c.customer_id
group by c.name;
# 2. Tạo VIEW hiển thị thông tin khách hàng gồm : tên khách hàng, địa chỉ, số điện thoại và tổng
# số đơn đã đặt. [3 điểm]

create view CustomerOrderSummary as
SELECT c.name            as CustomerName,
       c.address         as Address,
       c.phone           as PhoneNumber,
       count(o.order_id) as TotalOrders
from customers c
         join
     orders o on c.customer_id = o.customer_id
group by c.customer_id;


# 3. Tạo VIEW hiển thị thông tin sản phẩm gồm: tên sản phẩm, mô tả, giá và tổng số lượng đã
# bán ra của mỗi sản phẩm.

create view ProductSalesSummary as
SELECT p.name           as ProductName,
       p.description    as Description,
       p.price          as Price,
       sum(od.quantity) as TotalQuantitySold
from products p
         join
     orders_details od on p.product_id = od.product_id
group by p.product_id;

# 4. Đánh Index cho trường `phone` và `email` của bảng Customer. [3 điểm]
create index phoneNumber on customers (phone);
create index email on customers (email);

# 5. Tạo PROCEDURE lấy tất cả thông tin của 1 khách hàng dựa trên mã số khách hàng.[3 điểm]
delimiter //
create procedure pro_customerinfobyId(
    in customerIdProc varchar(4))
begin
    select *
    from customers
    where customer_id = customerIdProc;
end
//
delimiter ;
call pro_customerinfobyId('C001');


# 6. Tạo PROCEDURE lấy thông tin của tất cả sản phẩm. [3 điểm]
delimiter //
create procedure GetAllProducts()
begin
    select * from products;
end//
delimiter ;

# 7. Tạo PROCEDURE hiển thị danh sách hoá đơn dựa trên mã người dùng. [3 điểm]
delimiter //
create procedure GetOrdersByCustomerId(in customerId varchar(4))
begin
    select o.order_id,
           o.order_date,
           o.total_amount,
           c.name AS customer_name
    from orders o
             join
         customers c on o.customer_id = c.customer_id
    where o.customer_id = customerId;
end//
delimiter ;

# 8. Tạo PROCEDURE tạo mới một đơn hàng với các tham số là mã khách hàng, tổng
# tiền và ngày tạo hoá đơn, và hiển thị ra mã hoá đơn vừa tạo. [3 điểm]

delimiter //

create procedure CreateNewOrder(
    IN p_customer_id VARCHAR(4),
    IN p_total_amount DOUBLE,
    IN p_order_date DATE,
    OUT p_order_id VARCHAR(4)
)
BEGIN
    DECLARE v_order_id INT;

    -- Tìm mã đơn hàng lớn nhất và tăng lên 1 để tạo mã mới
    SELECT COALESCE(MAX(CAST(SUBSTRING(order_id, 2) AS UNSIGNED)), 0) + 1 INTO v_order_id FROM orders;

    -- Tạo mã đơn hàng mới
    SET p_order_id = CONCAT('H', LPAD(v_order_id, 3, '0'));

    -- Thêm đơn hàng mới vào bảng ORDERS
    INSERT INTO orders (order_id, customer_id, order_date, total_amount)
    VALUES (p_order_id, p_customer_id, p_order_date, p_total_amount);

    -- Trả về mã đơn hàng vừa tạo
    SELECT p_order_id;
END //

delimiter ;
# call AddNewOrder('S008',10,'2023-05-06');

# 9. Tạo PROCEDURE thống kê số lượng bán ra của mỗi sản phẩm trong khoảng
# thời gian cụ thể với 2 tham số là ngày bắt đầu và ngày kết thúc. [3 điểm]
delimiter //
create procedure CountProductSoldBetweenDates(
    in startDate date,
    in endDate date
)
begin
    select product_id,
           sum(quantity) as total_quantity_sold
    from orders_details
    where order_id in (select order_id
                       from orders
                       where order_date between startDate and endDate)
    group by product_id;
end;
delimiter //

# 10. Tạo PROCEDURE thống kê số lượng của mỗi sản phẩm được bán ra theo thứ tự
# giảm dần của tháng đó với tham số vào là tháng và năm cần thống kê. [3 điểm]
delimiter //
create procedure CountProductSoldByMonth(
    in month INT,
    in year INT
)
begin
    select p.name           as product_name,
           SUM(od.quantity) as total_quantity_sold
    from products p
             left join
         orders_details od on p.product_id = od.product_id
             left join
         orders o on od.order_id = o.order_id
    where MONTH(o.order_date) = month
      and YEAR(o.order_date) = year
    group by p.product_id
   order by total_quantity_sold desc ;
end;
delimiter //







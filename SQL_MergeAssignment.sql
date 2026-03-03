/*Creating customers master and update table*/
CREATE TABLE customers_master (customer_id INT PRIMARY KEY,customer_name VARCHAR(255),phone VARCHAR(20));
CREATE TABLE customers_updates (customer_id INT PRIMARY KEY,customer_name VARCHAR(255),phone VARCHAR(20));

/*Inserting values to master table*/
INSERT INTO customers_master (customer_id, customer_name, phone)
VALUES 
    (101, 'Alice', '111-111'),
    (102, 'Bob', '222-222'),
    (103, 'Charlie', '333-333'),
    (104, 'David', '444-444');
    
 /* Insert new update data to customer update table*/
INSERT INTO customers_updates (customer_id, customer_name, phone)
VALUES 
    (101, 'Alice M', '111-999'),
    (103, 'Charlie', '333-333'),
    (105, 'Eva', '555-555');
    
/*Printing data from both the tables*/
select * from customers_master;
select * from customers_updates;

/*Merge statement*/
MERGE INTO customers_master target
USING customers_updates source
ON (target.customer_id = source.customer_id)
WHEN MATCHED THEN
    UPDATE SET 
        target.customer_name = source.customer_name,
        target.phone = source.phone
    WHERE (target.customer_name <> source.customer_name OR target.phone <> source.phone)    
WHEN NOT MATCHED THEN
    INSERT (customer_id, customer_name, phone)
    VALUES (source.customer_id, source.customer_name, source.phone);
DELETE FROM customers_master WHERE customer_id NOT IN (SELECT customer_id FROM customers_updates);
/*After Merge*/
select * from customers_master;
select * from customers_updates;







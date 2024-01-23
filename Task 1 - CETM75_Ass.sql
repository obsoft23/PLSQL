
DROP TABLE IF EXISTS stock_movements;
DROP TABLE IF EXISTS stock;
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS delivery_times;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS stores;
DROP TABLE IF EXISTS warehouse;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS roles;



CREATE TABLE warehouse(
    warehouse_id  VARCHAR(3) PRIMARY KEY,
    warehouse_name VARCHAR(100)  NOT NULL,
    warehouse_address VARCHAR(255)  NOT NULL,
    warehouse_phone VARCHAR(20)  NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE stores (
    store_id VARCHAR(3) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    store_address VARCHAR(255) NOT NULL,
    store_phone_contact VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE customers (
    customer_id VARCHAR(3) PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    home_address VARCHAR(255) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    telephone_number VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    bank_name VARCHAR(100) NOT NULL,
    bank_address VARCHAR(255) NOT NULL,
    sort_code VARCHAR(10) NOT NULL,
    account_number VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE products (
    product_id VARCHAR(3) PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cost DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE stock (
    stock_id VARCHAR(3) PRIMARY KEY,
    product_id VARCHAR(3) REFERENCES products(product_id),
    store_id VARCHAR(3) REFERENCES stores(store_id),
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE delivery_times (
    delivery_time_id VARCHAR(3) PRIMARY KEY,
    estimated_delivery_time TIMESTAMP NOT NULL,
    actual_delivery_time TIMESTAMP,
    delivery_status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transactions (
    transaction_id VARCHAR(3) PRIMARY KEY,
    customer_id VARCHAR(3) REFERENCES customers(customer_id) NOT NULL,
    store_id VARCHAR(3) REFERENCES stores(store_id) NOT NULL,
    product_id VARCHAR(3) REFERENCES products(product_id) NOT NULL,
    quantity VARCHAR(3) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    delivery_time_id VARCHAR(3) REFERENCES delivery_times(delivery_time_id) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE stock_movements (
    movement_id VARCHAR(3) PRIMARY KEY,
    product_id VARCHAR(3) REFERENCES products(product_id) NOT NULL,
    from_store_id VARCHAR(3) REFERENCES stores(store_id) NOT NULL,
    to_store_id VARCHAR(3) REFERENCES stores(store_id) NOT NULL,
    quantity VARCHAR(3) NOT NULL,
    movement_datetime TIMESTAMP NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles(
    role_id VARCHAR(3) PRIMARY KEY,
    role_description VARCHAR(50) NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE staff(
    staff_id VARCHAR(3) PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(100) UNIQUE NOT NULL,
    home_address VARCHAR(255) ,
    telephone_number VARCHAR(20),
    role_id VARCHAR(3) REFERENCES roles(role_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



INSERT INTO warehouse (warehouse_id, warehouse_name, warehouse_address, warehouse_phone)
VALUES (1, 'Main Warehouse', '10 Warehouse St', '07787654453'),
       (2, 'Warehouse 2', '20 Storage St', '077876543211');

INSERT INTO stores (store_id, store_name, store_address, store_phone_contact)
VALUES (1, 'Store I', '34e Dalton St', '0780012324'),
       (2, 'Store 2', '4d Lane St', '0780012325'),
       (3, 'Store 3', '22 Ainsle St', '0783312325')
       
;

INSERT INTO customers (customer_id, last_name, first_name, home_address, email_address, telephone_number, date_of_birth, bank_name, bank_address, sort_code, account_number)
VALUES (1, 'Kirsie', 'James', '45b Almond St', 'james0912@email.com', '0448855', '1995-03-15', 'Monzo Bank', '13d Arrigton St', '123456', '07787654321'),
       (2, 'Argie', 'Ben', '31c Settle St', 'argie334@email.com', '689021', '2002-06-11', 'Barclays Bank', '44c Hedoc St', '654321', '07787654323');

INSERT INTO products (product_id, type, name, description, cost)
VALUES (1, 'printed music', 'music', 'music', 49.99),
       (2, 'Hymn book', 'Songs of praise', 'HYymn Tips', 21.99),
       (3, 'Grand organ keyboard', 'Piano', 'Automatic keyboard plays', 10.99);


INSERT INTO stock (stock_id, product_id, store_id, quantity)
VALUES (1, 1, 1, 103),
       (2, 2, 2, 50),
       (3, 3, 3, 98);


INSERT INTO delivery_times (delivery_time_id, estimated_delivery_time, actual_delivery_time, delivery_status)
VALUES
    (1, '2024-01-06 18:58:00', '2024-01-06 11:55:00', 'Awaiting Delivery'),
    (2, '2024-01-06 18:58:00', '2024-01-06 11:55:00', 'Delivered');


INSERT INTO transactions (transaction_id, customer_id, store_id, delivery_time_id, product_id, quantity, price ) 
VALUES  
  (1, 1, 1, 1, 1, 1, 49.99),
  (2, 2, 2, 2, 2, 1, 21.99);


INSERT INTO stock_movements (movement_id, product_id, from_store_id, to_store_id, quantity, movement_datetime)
VALUES (1, 1, 1, 2, 5, '2023-01-12 08:00:00'),
       (2, 2, 2, 3, 10, '2023-01-14 10:30:00');


INSERT INTO roles (role_id, role_description, role_name)
VALUES (1, 'Manager', 'Store Manager'),
       (2, 'Clerk', 'Sales Clerk');

INSERT INTO staff (staff_id, last_name, first_name, email_address, home_address, telephone_number, role_id)
VALUES (1, 'Kelvin', 'Adam', 'kevadam@gmail.com', '123 Staff St', '0788001111', 1),
       (2, 'Enoch', 'George', 'enoch0224@gmail.com', '456 Staff St', '0797733222', 2);


CREATE OR REPLACE PROCEDURE register_customer(
    p_customer_id VARCHAR(3),
    p_last_name VARCHAR(100),
    p_first_name VARCHAR(100),
    p_home_address VARCHAR(255),
    p_email_address VARCHAR(100),
    p_telephone_number VARCHAR(20),
    p_date_of_birth DATE,
    p_bank_name VARCHAR(100),
    p_bank_address VARCHAR(255),
    p_sort_code VARCHAR(10),
    p_account_number VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customers (
        customer_id,
        last_name,
        first_name,
        home_address,
        email_address,
        telephone_number,
        date_of_birth,
        bank_name,
        bank_address,
        sort_code,
        account_number
    )
    VALUES (
        p_customer_id,
        p_last_name,
        p_first_name,
        p_home_address,
        p_email_address,
        p_telephone_number,
        p_date_of_birth,
        p_bank_name,
        p_bank_address,
        p_sort_code,
        p_account_number
    );

END;
$$;

CALL register_customer('3', 'Anu', 'Malkeet', '20 Streamer St', 'lerum.k@email.com', '07034656500', '1994-06-07', 'Revoult Bank', '31g Tell St', '654321', '22338651');



CREATE OR REPLACE PROCEDURE customer_purchase(
    p_transaction_id VARCHAR(3),
    p_customer_id VARCHAR(3),
    p_store_id VARCHAR(3),
    p_product_id VARCHAR(3),
    p_quantity INT,
    p_delivery_time_id VARCHAR(3),
    p_estimated_delivery_time TIMESTAMP
) LANGUAGE plpgsql AS $$
DECLARE
    available_stock_quantity INT;
BEGIN
    
    IF NOT EXISTS (SELECT 1 FROM products WHERE product_id = p_product_id) THEN
        RAISE NOTICE 'Error: Product does not exist.';
        RETURN;
    END IF;

    
    IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = p_customer_id) THEN
        RAISE NOTICE 'Error: Customer does not exist.';
        RETURN;
    END IF;



    SELECT quantity INTO available_stock_quantity
    FROM stock
    WHERE product_id = p_product_id
      AND quantity >= p_quantity;

    IF available_stock_quantity IS NULL THEN
        RAISE NOTICE 'Error: Not enough stock.';
        RETURN;
    END IF;



    UPDATE stock
    SET quantity = quantity - p_quantity
    WHERE product_id = p_product_id;


     INSERT INTO delivery_times (
        delivery_time_id,
        estimated_delivery_time,
        delivery_status
    ) VALUES (
        p_delivery_time_id,
        p_estimated_delivery_time,
        'Scheduled'
    );

    INSERT INTO transactions (
        transaction_id,
        customer_id,
        store_id,
        product_id,
        quantity,
        price,
        delivery_time_id
    ) VALUES (
        p_transaction_id,
        p_customer_id,
        p_store_id,
        p_product_id,
        p_quantity,
        (SELECT cost FROM products WHERE product_id = p_product_id) * p_quantity,
        p_delivery_time_id
    );

    RAISE NOTICE 'Purchase successful. Estimated delivery scheduled.';
END;
$$;


CALL customer_purchase('3', '3', '1', '1', 2, '3', TIMESTAMP '2023-08-12 12:30:00');

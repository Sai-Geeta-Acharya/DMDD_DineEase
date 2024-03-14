set SERVEROUTPUT on;

DECLARE
    customers_exists NUMBER;
BEGIN
    SELECT 
        COUNT(*) INTO customers_exists
    FROM
        user_tables
    WHERE
        table_name = 'Customers';
        
    IF customers_exists = 0 THEN
        EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
            customer_id    INTEGER NOT NULL,
            phone_number   VARCHAR2(20),
            reservation_id NUMBER NOT NULL,
            street         VARCHAR2(255),
            city           VARCHAR2(100),
            state          VARCHAR2(100),
            zip            VARCHAR2(10),
            country        VARCHAR2(100),
            CONSTRAINT customer_pk PRIMARY KEY (customer_id)
        )';
        dbms_output.put_line('Customers table created successfully.');
    ELSE
        dbms_output.put_line('Customers table already exists.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error creating table Customers: ' || sqlerrm);
END;


ALTER TABLE Customers
ADD CONSTRAINT unique_phone_number UNIQUE (phone_number);

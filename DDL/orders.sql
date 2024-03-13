set SERVEROUTPUT on;

DECLARE
    table_exists NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO table_exists
    FROM
        user_tables
    WHERE
        table_name = 'ORDERS';

    IF table_exists = 0 THEN
        EXECUTE IMMEDIATE '
        CREATE TABLE ORDERS (
    order_id     INTEGER NOT NULL,
    order_date   DATE,
    order_amount NUMBER(10, 2),
    order_type   VARCHAR2(45),
    order_status VARCHAR2(45),
    employee_id  INTEGER NOT NULL,
    customer_id  INTEGER NOT NULL,
    CONSTRAINT orders_pk PRIMARY KEY ( order_id )
        )';
        dbms_output.put_line('ORDERS table created successfully.');
    ELSE
        dbms_output.put_line('ORDERS table already exists.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error creating table ORDERS: ' || sqlerrm);
END;
-- Create Order Status View
DECLARE
    v_count NUMBER;
BEGIN
    -- Check if the view exists
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        user_views
    WHERE
        view_name = 'ORDER_STATUS';

    -- Drop the view if it exists
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP VIEW ORDER_STATUS';
    END IF;

   -- Recreate the view
    EXECUTE IMMEDIATE '
    CREATE OR REPLACE VIEW order_status AS
    SELECT
        o.order_id,
        o.order_date,
        o.order_amount,
        o.order_status,
        e.fname || '' '' || e.lname AS employee_name,
        c.customer_id,
        c.phone_number
    FROM
        orders o
    JOIN
        employees e ON o.employee_id = e.employee_id
    JOIN
        customers c ON o.customer_id = c.customer_id';
END;
/



select * from ORDERS;



SELECT uc.constraint_name, ucc.column_name, uc.constraint_type
FROM user_constraints uc
JOIN user_cons_columns ucc ON uc.constraint_name = ucc.constraint_name
WHERE uc.constraint_type = 'U';


SELECT  text
FROM user_errors
WHERE name = 'UNIQUE_SSN';




BEGIN
  -- Attempt to insert duplicate data
  INSERT INTO customers 
  VALUES (203, '1234567890', 101, '123 Main St', 'Cityville', 'Stateville', '12345', 'Countryland');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    -- Print the error message and code
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    DBMS_OUTPUT.PUT_LINE(SQLCODE);
END;



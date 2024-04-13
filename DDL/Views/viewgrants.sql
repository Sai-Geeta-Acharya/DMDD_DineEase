GRANT SELECT ON order_status TO manager_role ;

GRANT SELECT ON order_status TO service_crew_role ;

GRANT SELECT ON order_status TO customer_role ;



GRANT SELECT ON RESERVATION_DETAILS TO manager_role ;

GRANT SELECT ON RESERVATION_DETAILS TO service_crew_role ;

GRANT SELECT ON RESERVATION_DETAILS TO customer_role ;


GRANT SELECT ON SALES_PERFORMANCE_ANALYSIS TO manager_role ;

GRANT SELECT ON SALES_PERFORMANCE_ANALYSIS TO manager_role ;



GRANT SELECT ON TOTAL_AMOUNT_DUE TO manager_role ;

GRANT SELECT ON TOTAL_AMOUNT_DUE TO customer_role ;

GRANT SELECT ON TOTAL_AMOUNT_DUE TO cashier_role ;

set serveroutput on;
-- Create roles
DECLARE
    role_name VARCHAR2(30);
BEGIN
    -- Create roles if they don't exist
    role_name := 'MANAGER_ROLE';
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
        DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1921 THEN
                DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' already exists. Skipping...');
            ELSE
                RAISE;
            END IF;
    END;

    role_name := 'SERVICE_CREW_ROLE';
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
        DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1921 THEN
                DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' already exists. Skipping...');
            ELSE
                RAISE;
            END IF;
    END;

    role_name := 'CASHIER_ROLE';
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
        DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1921 THEN
                DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' already exists. Skipping...');
            ELSE
                RAISE;
            END IF;
    END;
    
    role_name := 'KITCHEN_CREW_ROLE';
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
        DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1921 THEN
                DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' already exists. Skipping...');
            ELSE
                RAISE;
            END IF;
    END;
    
    role_name := 'CUSTOMER_ROLE';
    BEGIN
        EXECUTE IMMEDIATE 'CREATE ROLE ' || role_name;
        DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' created successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -1921 THEN
                DBMS_OUTPUT.PUT_LINE('Role ' || role_name || ' already exists. Skipping...');
            ELSE
                RAISE;
            END IF;
    END;

END;
/



--Customer_role:

GRANT INSERT, SELECT ON orders TO customer_role; -- place orders and view their own orders
GRANT INSERT ON service_reviews TO customer_role; -- provide feedback on their order experience

--Employees:
--SERVICE_CREW_ROLE
GRANT SELECT, INSERT, UPDATE ON reservations TO service_crew_role;--TO TAKE AND UPDATE RESERVATION DETAILS
GRANT SELECT, UPDATE, INSERT ON orders TO service_crew_role;--TO TAKE AND UPDATE ORDER/ORDER_STATUS
GRANT SELECT, UPDATE ON customers TO service_crew_role;--TO UPDATE RESERVATION_ID
GRANT SELECT, UPDATE ON inventory TO service_crew_role;-- Permission to view and update inventory status

--CASHIER_ROLE
GRANT SELECT ON order_details TO cashier_role; -- view order details for invoicing
GRANT SELECT, UPDATE ON orders TO cashier_role; -- mark orders as paid

--KITCHEN_CREW_ROLE
GRANT SELECT ON orders TO kitchen_crew_role; --view orders for preparing dishes
GRANT SELECT, UPDATE ON inventory TO kitchen_crew_role; --update inventory stock levels
GRANT SELECT, UPDATE ON order_details TO kitchen_crew_role; --view and update order details

--MANAGER_ROLE
GRANT SELECT ON ratings TO manager_role;

GRANT SELECT, UPDATE ON orders TO manager_role;

GRANT SELECT ON service_reviews TO manager_role;

GRANT SELECT, UPDATE ON employees TO manager_role; --CAN UPDATE EMPLOYEE DETAILS

GRANT SELECT ON customers TO manager_role;

GRANT SELECT, UPDATE ON reservations TO manager_role;

GRANT SELECT, UPDATE ON items TO manager_role;

GRANT SELECT, UPDATE, INSERT ON inventory TO manager_role;

GRANT SELECT, UPDATE ON order_details TO manager_role;

GRANT cashier_role TO RESTAURANT_CASHIER;
GRANT SELECT ON CURRENT_INVENTORY_STATUS TO manager_role ;
GRANT SELECT ON CURRENT_INVENTORY_STATUS TO service_crew_role;
GRANT SELECT ON CURRENT_INVENTORY_STATUS TO kitchen_crew_role;

GRANT SELECT ON CUSTOMER_ORDER_DETAILS TO manager_role ;
GRANT SELECT ON CUSTOMER_ORDER_DETAILS TO service_crew_role;
GRANT SELECT ON CUSTOMER_ORDER_DETAILS TO kitchen_crew_role;
GRANT SELECT ON CUSTOMER_ORDER_DETAILS TO cashier_role;
GRANT SELECT ON CUSTOMER_ORDER_DETAILS TO customer_role;

GRANT SELECT ON EMPLOYEE_PERFORMANCE_MONITORING TO manager_role ;

GRANT SELECT ON  ITEM_RATINGS_ANALYSIS TO manager_role ;
GRANT SELECT ON  ITEM_RATINGS_ANALYSIS TO customer_role;

GRANT SELECT ON  ORDER_HISTORY TO manager_role ;
GRANT SELECT ON  ORDER_HISTORY TO customer_role;

GRANT EXECUTE ON user_management TO customer_role;








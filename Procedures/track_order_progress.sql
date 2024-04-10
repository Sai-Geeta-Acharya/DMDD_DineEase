CREATE OR REPLACE PROCEDURE track_order_progress (
    p_order_id IN NUMBER
) AS
    v_order_status VARCHAR2(50);
BEGIN
    -- Retrieve the current status of the order
    SELECT order_status INTO v_order_status
    FROM orders
    WHERE order_id = p_order_id;

    -- Display the current status
    DBMS_OUTPUT.PUT_LINE('Order ID: ' || p_order_id || ', Current Status: ' || v_order_status);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Custom message for order not found
        DBMS_OUTPUT.PUT_LINE('Order ID ' || p_order_id || ' not found.');
    WHEN OTHERS THEN
        -- Custom message for other errors
        DBMS_OUTPUT.PUT_LINE('An error occurred while tracking the order status.');
END;
/

---Execution
set serveroutput on;
BEGIN
    track_order_progress(p_order_id => 6);
END;
/

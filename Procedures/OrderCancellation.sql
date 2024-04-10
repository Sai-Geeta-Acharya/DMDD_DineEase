CREATE OR REPLACE PROCEDURE cancel_order (
    p_order_id IN NUMBER
) AS
    v_order_status VARCHAR2(20);
BEGIN
    -- Check if the order exists and retrieve its status
    SELECT order_status INTO v_order_status
    FROM orders
    WHERE order_id = p_order_id;
    
    -- Check if the order status allows cancellation
    IF v_order_status = 'Pending' THEN
        -- Update the order status to 'Cancelled'
        UPDATE orders
        SET order_status = 'Cancelled'
        WHERE order_id = p_order_id;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Order with ID ' || p_order_id || ' has been successfully cancelled.');
    ELSE
        RAISE_APPLICATION_ERROR(-20004, 'Cannot cancel order. Order status is ' || v_order_status);
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Order ID ' || p_order_id || ' not found.');
    WHEN OTHERS THEN
        -- Handle any other exceptions
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20006, 'Error cancelling order: ' || SQLERRM);
END;
/


---Execution
BEGIN
    cancel_order(p_order_id => 234567);
END;
/

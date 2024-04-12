/*
    This procedure updates the status of an order in the 'Orders' table to indicate that it has been cancelled.
    
    Input:
    - p_order_id: The ID of the order to be cancelled.
    
    Exceptions:
    - NO_DATA_FOUND: Raised if the specified order ID is not found.
    - OTHERS: Handles any other exceptions and raises an error indicating that an error occurred while cancelling the order.
    */
    CREATE OR REPLACE PROCEDURE cancelorder (
        p_order_id IN NUMBER
    ) AS
        v_order_status VARCHAR2(20);
    BEGIN
            -- Check if the order exists and retrieve its status
        SELECT
            order_status
        INTO v_order_status
        FROM
            orders
        WHERE
            order_id = p_order_id;
            
            -- Check if the order status allows cancellation
        IF v_order_status = 'Pending' THEN
                -- Update the order status to 'Cancelled'
            UPDATE orders
            SET
                order_status = 'Cancelled'
            WHERE
                order_id = p_order_id;

            COMMIT;
            dbms_output.put_line('Order with ID '
                                 || p_order_id
                                 || ' has been successfully cancelled.');
        ELSE
        -- Custom message for order status other than 'Pending'
            dbms_output.put_line('Cannot cancel order. Order with ID '
                                 || p_order_id
                                 || ' is already '
                                 || v_order_status);
        END IF;

    EXCEPTION
        WHEN no_data_found THEN
            raise_application_error(-20005, 'Order ID '
                                            || p_order_id
                                            || ' not found.');
        WHEN OTHERS THEN
                -- Handle any other exceptions
            ROLLBACK;
            raise_application_error(-20006, 'Error cancelling order: ' || sqlerrm);
    END cancelorder;
    /
    
    --EXECUTION
    SET SERVEROUTPUT ON;
    -- Execute the cancel order procedure
BEGIN
    cancelorder(p_order_id => 17); -- Specify the order ID
END;
/
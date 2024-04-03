/**
 * This stored procedure updates the status of an order in the 'Orders' table to indicate that it has been provided to the kitchen crew.
 * 
 * Input:
 * - p_order_id: The ID of the order to be updated.
 * 
 * Exceptions:
 * - NO_DATA_FOUND: Raised if the specified order ID is not found.
 * - OTHERS: Handles any other exceptions and raises an error indicating that an error occurred while updating the order status.
 */
CREATE OR REPLACE PROCEDURE UpdateOrderStatus (
    p_order_id IN NUMBER,
    p_new_status IN VARCHAR2
) AS
BEGIN
    -- Update the order status to the new status provided
    UPDATE Orders
    SET order_status = p_new_status
    WHERE order_id = p_order_id;
    
    COMMIT; -- Commit the transaction
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Order ID not found.');
    WHEN OTHERS THEN
        ROLLBACK; -- Rollback the transaction
        RAISE_APPLICATION_ERROR(-20003, 'An error occurred while updating the order status.');
END;
/

---Execute the procedure
BEGIN
    -- Call the procedure with the order ID and new status parameters
    UpdateOrderStatus(p_order_id => 7, p_new_status => 'Processing');
    DBMS_OUTPUT.PUT_LINE('Order status updated successfully.');
END;
/


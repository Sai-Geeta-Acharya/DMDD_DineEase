/**
 * This function calculates the total amount due and itemized costs for a given order.
 * 
 * Input Parameters:
 * - p_order_id: The ID of the order for which the total amount due is calculated.
 * 
 * Output:
 * - Total Amount Due: The total amount due for the specified order, including item costs, taxes, and any additional charges.
 * 
 * Purpose:
 * Calculate the total amount due for the specified order, including item costs, taxes, and any additional charges.
 */
CREATE OR REPLACE FUNCTION CalculateTotalAmountDue (
    p_order_id IN NUMBER
) RETURN NUMBER AS
    v_total_amount NUMBER := 0;
BEGIN
    -- Calculate itemized costs for the specified order
    SELECT SUM(od.quantity * od.price_per_item) INTO v_total_amount
    FROM Order_Details od
    WHERE od.order_id = p_order_id;
    
    -- Include taxes or any additional charges if applicable
    
    -- Update the orders table with the total amount due
    UPDATE Orders
    SET order_amount = v_total_amount
    WHERE order_id = p_order_id;
    
    -- Commit the transaction
    COMMIT;

    -- Return the total amount due
    RETURN v_total_amount;

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback the transaction if an error occurs
        ROLLBACK;
        RAISE;
END;
/


---Execute the function
DECLARE
    v_total_due NUMBER;
BEGIN
    -- Call the function with the order ID parameter
    v_total_due := CalculateTotalAmountDue(p_order_id => 7); 
    -- Output the result
    DBMS_OUTPUT.PUT_LINE('Total Amount Due: ' || v_total_due);
END;
/


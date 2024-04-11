

-- Execute the placeorderforfood function
DECLARE
    v_order_id NUMBER;
BEGIN
    v_order_id := OrderManagement.placeorderforfood(
        p_customer_id => 228,
                    p_order_type => 'Reservation',
                    p_selected_items => 'pizza-1' -- Specify the selected items in the format 'item_name-quantity', also can list more items with comma ","
                );
    -- Output the order ID
    DBMS_OUTPUT.PUT_LINE('Order ID: ' || v_order_id);
END;
/

set serveroutput on;
-- Execute the preparedishesfororder procedure
BEGIN
    OrderManagement.preparedishesfororder(p_order_id => 18); -- Specify the order ID
END;
/

-- Execute the calculatetotalamountdue function
DECLARE
    v_total_amount NUMBER;
BEGIN
    v_total_amount := OrderManagement.calculatetotalamountdue(p_order_id => 18); -- Specify the order ID
    DBMS_OUTPUT.PUT_LINE('Total Amount Due: ' || v_total_amount);
END;
/

-- Execute the updateorderstatus procedure
BEGIN
    OrderManagement.updateorderstatus(
        p_order_id => 18, -- Specify the order ID
        p_new_status => 'Completed' -- Specify the new status
    );
END;
/

-- Execute the cancelorder procedure
BEGIN
    OrderManagement.cancelorder(p_order_id => 17); -- Specify the order ID
END;
/

-- Execute the trackorderprogress procedure
BEGIN
    OrderManagement.trackorderprogress(p_order_id => 18); -- Specify the order ID
END;
/

-- Execute the processpayment procedure
DECLARE
    v_change NUMBER;
BEGIN
    OrderManagement.processpayment(
        p_order_id => 18, -- Specify the order ID
        p_payment_amount => 50, -- Specify the payment amount
        p_payment_method => 'Cash', -- Specify the payment method
        p_payment_status => 'Paid', -- Specify the payment status
        p_change => v_change -- Output parameter for change
    );
    DBMS_OUTPUT.PUT_LINE('Change: ' || v_change);
END;
/


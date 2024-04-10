/*
This procedure process payments for orders, updating payment information in the Payments table and the status of the order in the Orders table. 
It also calculates and returns change if the payment amount exceeds the total amount due.
*/
CREATE OR REPLACE PROCEDURE ProcessPayment (
    p_order_id IN NUMBER,
    p_payment_amount IN NUMBER,
    p_payment_method IN VARCHAR2,
    p_payment_status IN VARCHAR2,
    p_change OUT NUMBER
) AS
    v_total_due NUMBER;
    v_payment_exists NUMBER; -- Flag to check if payment exists
    v_remaining_due NUMBER;
BEGIN
    -- Check if payment for the order ID already exists
    SELECT COUNT(*) INTO v_payment_exists
    FROM Payments
    WHERE order_id = p_order_id;

    IF v_payment_exists > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Order amount for order ID ' || p_order_id || ' is already cleared.');
        p_change := 0;
        RETURN; -- Exit the procedure
    END IF;

    -- Retrieve the total amount due for the order
    SELECT order_amount INTO v_total_due
    FROM Orders
    WHERE order_id = p_order_id;

    -- Check if the payment amount is less than or equal to 0
    IF p_payment_amount <= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Invalid payment amount.');
        p_change := 0; -- Set change to 0
        RETURN; -- Exit 
    END IF;

     -- Check if the payment amount is less than the total amount due
    IF p_payment_amount < v_total_due THEN
        v_remaining_due := v_total_due - p_payment_amount;
        DBMS_OUTPUT.PUT_LINE('Insufficient payment amount. Please provide an additional $' || v_remaining_due || '.');
        p_change := 0; -- Set change to 0
        RETURN; -- Exit the procedure gracefully
    END IF;

    -- Calculate change if the payment amount exceeds the total amount due
    IF p_payment_amount > v_total_due THEN
        p_change := p_payment_amount - v_total_due;
        DBMS_OUTPUT.PUT_LINE('Change Due: ' || p_change);
    ELSE
        p_change := 0;
    END IF;

    -- Begin transaction
    BEGIN
        -- Insert payment information into the Payments table
        INSERT INTO Payments (
            payment_id,
            order_id,
            payment_method,
            payment_status,
            total_payment_amount,
            change_returned,
            actual_order_amount
        )
        VALUES (
            payment_id_seq.NEXTVAL, -- Get the next payment ID
            p_order_id,
            p_payment_method,
            p_payment_status,
            p_payment_amount, -- Total payment amount
            p_change, -- Insert the calculated change
            v_total_due -- Insert the total due amount
        );
        
        -- Update the Orders table with the status 'Paid'
        UPDATE Orders
        SET order_status = 'Paid'
        WHERE order_id = p_order_id;
        
        -- Commit the transaction
        COMMIT;
    EXCEPTION
         WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Order ID ' || p_order_id || ' not found.');
        ROLLBACK; -- Rollback the transaction if an error occurs
        WHEN DUP_VAL_ON_INDEX THEN
            -- Rollback the transaction if an error occurs
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Order ' || p_order_id || ' is already paid.');
        WHEN OTHERS THEN
            -- Rollback the transaction if an error occurs
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
    END;
END;
/




---EXECUTION OF PROCEDURE
set serveroutput on;

DECLARE
    v_change NUMBER;
BEGIN
    ProcessPayment(
        p_order_id => 6, -- Provide the order ID for which payment is being made
        p_payment_amount => 190, -- Provide the payment amount
        p_payment_method => 'Cash', -- Provide the payment method
        p_payment_status => 'Paid', -- Update the status
        p_change => v_change -- Capture the change returned in this parameter
    );
END;
/



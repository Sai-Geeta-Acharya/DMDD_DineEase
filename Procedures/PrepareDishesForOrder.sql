CREATE OR REPLACE PROCEDURE PrepareDishesForOrder (
    p_order_id IN NUMBER
) AS
    v_order_status VARCHAR2(20);
BEGIN
    -- Check if the order exists
    SELECT order_status INTO v_order_status
    FROM Orders
    WHERE order_id = p_order_id;

    -- Check if the order status is valid for preparing dishes
    IF v_order_status = 'Pending' THEN
        -- Update the order status to 'Processing' as the kitchen crew starts working on it
        UPDATE Orders
        SET order_status = 'Processing'
        WHERE order_id = p_order_id;
        
        COMMIT; -- Commit the transaction
        DECLARE
        v_item_count Number;
        v_item_id Number;
        v_invoice_id Number;
        BEGIN
        select o.item_count, o.item_id, i.invoice_id into v_item_count, v_item_id, v_invoice_id from order_details o, items i where o.item_id=i.item_id;
        UPDATE inventory
        SET quantity = quantity - v_item_count
        WHERE invoice_id = v_invoice_id;
        END;

        COMMIT;
        -- Your logic to prepare dishes for the given order_id goes here
        -- This procedure might involve updating tables, checking inventory, etc.
        
        -- For demonstration purposes, let's assume dishes are prepared successfully
        DBMS_OUTPUT.PUT_LINE('Dishes for Order ' || p_order_id || ' have been prepared successfully.');
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'Cannot prepare dishes for order ' || p_order_id || '. Order status is not Pending.');
    END IF;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'Order ID ' || p_order_id || ' not found.');
    WHEN OTHERS THEN
        -- Handle exceptions if any
        DBMS_OUTPUT.PUT_LINE('Error occurred while preparing dishes: ' || SQLERRM);
        ROLLBACK; -- Rollback the transaction
END;
/


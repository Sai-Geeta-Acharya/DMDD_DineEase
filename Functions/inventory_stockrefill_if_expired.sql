CREATE OR REPLACE FUNCTION RefillStock(Item_ID IN NUMBER) RETURN VARCHAR2 IS
    v_current_status VARCHAR2(10);
BEGIN
    -- Retrieve the current status of the item
    SELECT Item_Status INTO v_current_status
    FROM Inventory
    WHERE Item_ID = RefillStock.Item_ID;

    -- Check if the item status is 'expired'
    IF v_current_status = 'expired' THEN
        -- Refill stock by adding 3 to the quantity and updating the status
        UPDATE Inventory
        SET Quantity = Quantity + 3,
            Item_Status = 'fresh'
        WHERE Item_ID = RefillStock.Item_ID;

        -- Return a message indicating the stock refill
        RETURN 'Stock for item ' || Item_ID || ' has been automatically refilled.';
    ELSE
        -- Return a message indicating that the stock is not expired
        RETURN 'Stock for item ' || Item_ID || ' is not expired. No refill needed.';
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Handle the case when the item with the specified ID does not exist
        RETURN 'Item with ID ' || Item_ID || ' not found in inventory.';
END;
/

DECLARE
    v_message VARCHAR2(100);
BEGIN
    v_message := RefillStock(9); -- Replace 123 with the actual Item_ID
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/
commit;

select * from inventory;
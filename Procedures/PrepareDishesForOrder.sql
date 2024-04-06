create or replace procedure PREPAREDISHESFORORDER (
    P_ORDER_ID in number
) as
    V_ORDER_STATUS varchar2(20);
    V_ITEM_COUNT number;
    V_ITEM_ID number;
    V_INVOICE_ID varchar2(50);
    V_ITEM_NAME varchar2(100);
    V_QUANTITY number;
    
begin
    -- Check if the order exists
    select ORDER_STATUS into V_ORDER_STATUS
    from ORDERS
    where ORDER_ID = P_ORDER_ID;

    -- Check if the order status is valid for preparing dishes
    if  V_ORDER_STATUS = 'Pending' then
        -- Update the order status to 'Processing' as the kitchen crew starts working on it
        update ORDERS
        set ORDER_STATUS = 'Processing'
        where ORDER_ID = P_ORDER_ID;
        
        -- Retrieve item details from order_details and items tables
        select o.QUANTITY, o.ITEM_ID, i.INVOICE_ID , i.ITEM_NAME   , inv.QUANTITY
        into V_ITEM_COUNT, V_ITEM_ID, V_INVOICE_ID , V_ITEM_NAME, V_QUANTITY
        from ORDER_DETAILS o join ITEMS i on o.ITEM_ID = i.ITEM_ID
        join INVENTORY inv on i.ITEM_ID=inv.ITEM_ID
        where o.ORDER_ID = P_ORDER_ID;

   
        -- Update inventory table
        if V_QUANTITY <= 0
            then 
            DBMS_OUTPUT.PUT_LINE('Refill the stock with ' || V_ITEM_NAME );
            else
            update INVENTORY
            set QUANTITY = QUANTITY - V_ITEM_COUNT
            where ITEM_ID = V_ITEM_ID;
    
            -- Commit the transaction
            commit;
            DBMS_OUTPUT.PUT_LINE('Dishes for Order ' || P_ORDER_ID || ' have been prepared successfully.');
        end if;

        -- Your logic to prepare dishes for the given order_id goes here
        -- This procedure might involve updating tables, checking inventory, etc.
        
        -- For demonstration purposes, let's assume dishes are prepared successfully
        
    else
        RAISE_APPLICATION_ERROR(-20001, 'Cannot prepare dishes for order ' || P_ORDER_ID || '. Order status is not Pending.');
    end if;
    
exception
    when NO_DATA_FOUND then
        RAISE_APPLICATION_ERROR(-20002, 'Order ID ' || P_ORDER_ID || ' not found.');
    when others then
        -- Handle exceptions if any
        DBMS_OUTPUT.PUT_LINE('Error occurred while preparing dishes: ' || SQLERRM);
        rollback; -- Rollback the transaction
end;
/
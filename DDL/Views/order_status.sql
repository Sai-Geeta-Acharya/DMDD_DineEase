-- Create Order Status View
DECLARE
    v_count NUMBER;
BEGIN
    -- Check if the view exists
    SELECT
        COUNT(*)
    INTO v_count
    FROM
        user_views
    WHERE
        view_name = 'ORDER_STATUS';

    -- Drop the view if it exists
    IF v_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP VIEW ORDER_STATUS';
    END IF;

    -- Recreate the view
    EXECUTE IMMEDIATE '
   CREATE VIEW order_status AS
    SELECT
        order_id,
        order_date,
        order_amount,
        order_status
    FROM
        orders';
END;
/
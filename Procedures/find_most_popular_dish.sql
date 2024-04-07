CREATE OR REPLACE PROCEDURE find_most_popular_dish (
    V_ORDER_ID in number ) AS
    V_ITEM_ID number;
    V_FOOD_RATING FLOAT;
    V_ITEM_COUNT number;
    V_ITEM_NAME varchar2(100);
BEGIN

    -- Calculate average ratings for each item and insert into items table

    -- Find the item with the highest average rating
    SELECT r.item_id INTO V_ITEM_ID
    FROM RATINGS r
    JOIN ITEMS i ON r.item_id = i.item_id
    WHERE r.food_rating = (SELECT MAX(food_rating) FROM RATINGS);


    -- Display the most popular item
    DBMS_OUTPUT.PUT_LINE('The most popular dish is: ' || v_item_name);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No ratings found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
Exec find_most_popular_dish(6);

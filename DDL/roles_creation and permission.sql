-- Create roles
CREATE ROLE manager_role;

CREATE ROLE service_crew_role;

CREATE ROLE cashier_role;

CREATE ROLE kitchen_crew_role;

CREATE ROLE customer_role;

--Customer_role:

GRANT INSERT, SELECT ON orders TO customer_role; -- place orders and view their own orders
GRANT INSERT ON service_reviews TO customer_role; -- provide feedback on their order experience

--Employees:
--SERVICE_CREW_ROLE
GRANT SELECT, INSERT, UPDATE ON reservations TO service_crew_role;--TO TAKE AND UPDATE RESERVATION DETAILS
GRANT SELECT, UPDATE, INSERT ON orders TO service_crew_role;--TO TAKE AND UPDATE ORDER/ORDER_STATUS
GRANT SELECT, UPDATE ON customers TO service_crew_role;--TO UPDATE RESERVATION_ID
GRANT SELECT, UPDATE ON inventory TO service_crew_role;-- Permission to view and update inventory status

--CASHIER_ROLE
GRANT SELECT ON order_details TO cashier_role; -- view order details for invoicing
GRANT SELECT, UPDATE ON orders TO cashier_role; -- mark orders as paid

--KITCHEN_CREW_ROLE
GRANT SELECT ON orders TO kitchen_crew_role; --view orders for preparing dishes
GRANT SELECT, UPDATE ON inventory TO kitchen_crew_role; --update inventory stock levels
GRANT SELECT, UPDATE ON order_details TO kitchen_crew_role; --view and update order details

--MANAGER_ROLE
GRANT SELECT ON ratings TO manager_role;

GRANT SELECT, UPDATE ON orders TO manager_role;

GRANT SELECT ON service_reviews TO manager_role;

GRANT SELECT, UPDATE ON employees TO manager_role; --CAN UPDATE EMPLOYEE DETAILS

GRANT SELECT ON customers TO manager_role;

GRANT SELECT, UPDATE ON reservations TO manager_role;

GRANT SELECT, UPDATE ON items TO manager_role;

GRANT SELECT, UPDATE, INSERT ON inventory TO manager_role;

GRANT SELECT, UPDATE ON order_details TO manager_role;
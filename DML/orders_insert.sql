-- Inserting data into the ORDERS table
INSERT INTO ORDERS (order_id, order_date, order_amount, order_type, order_status, employee_id, customer_id)
VALUES (123456, TO_DATE('2024-03-15', 'YYYY-MM-DD'), 100.00, 'Reservation', 'Pending', 101, 201);

INSERT INTO ORDERS (order_id, order_date, order_amount, order_type, order_status, employee_id, customer_id)
VALUES (654321, TO_DATE('2024-03-16', 'YYYY-MM-DD'), 150.50, 'Dine-in', 'Completed', 102, 202);

INSERT INTO ORDERS (order_id, order_date, order_amount, order_type, order_status, employee_id, customer_id)
VALUES (234567, TO_DATE('2024-03-17', 'YYYY-MM-DD'), 75.25, 'Reservation', 'Pending', 103, 203);

INSERT INTO ORDERS (order_id, order_date, order_amount, order_type, order_status, employee_id, customer_id)
VALUES (324511, TO_DATE('2024-03-18', 'YYYY-MM-DD'), 200.00, 'Delivery', 'Processing', 104, 204);

INSERT INTO ORDERS (order_id, order_date, order_amount, order_type, order_status, employee_id, customer_id)
VALUES (987654, TO_DATE('2024-03-19', 'YYYY-MM-DD'), 50.75, 'Walk-in', 'Completed', 105, 205);

commit;

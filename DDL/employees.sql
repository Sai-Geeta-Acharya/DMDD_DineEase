set SERVEROUTPUT on;

DECLARE
    table_exists NUMBER;
BEGIN
    SELECT
        COUNT(*)
    INTO table_exists
    FROM
        user_tables
    WHERE
        table_name = 'EMPLOYEES';
        
    IF table_exists = 0 THEN
        EXECUTE IMMEDIATE '
        CREATE TABLE EMPLOYEES (
            employee_id INTEGER NOT NULL,
            fname       VARCHAR2(25),
            lname       VARCHAR2(25),
            street      VARCHAR2(255),
            city        VARCHAR2(100),
            state       VARCHAR2(100),
            zip         VARCHAR2(10),
            country     VARCHAR2(100),
            salary      NUMBER(10, 2),
            gender      CHAR(1),
            ssn         VARCHAR2(11),
            start_date  DATE,
            end_date    DATE,
            role  VARCHAR2(45),
            CONSTRAINT employees_pk PRIMARY KEY (employee_id)
        )';
        dbms_output.put_line('EMPLOYEES table created successfully.');
    ELSE
        dbms_output.put_line('EMPLOYEES table already exists.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('Error creating table EMPLOYEES: ' || sqlerrm);
END;
/**

create user restaurant_admin identified by DineEase2024;
grant connect to restaurant_admin;
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER, CREATE USER TO restaurant_admin WITH ADMIN OPTION;
GRANT CONNECT TO restaurant_admin WITH ADMIN OPTION;
GRANT CREATE ROLE TO restaurant_admin WITH ADMIN OPTION;
GRANT UNLIMITED TABLESPACE TO restaurant_admin;
GRANT CREATE VIEW TO restaurant_admin;

**/

set serveroutput on;
Declare
    user_exists NUMBER;
    grant_error EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO user_exists
    FROM dba_users
    WHERE username = 'RESTAURANT_ADMIN';

    IF user_exists = 0 THEN
        EXECUTE IMMEDIATE 'CREATE USER restaurant_admin IDENTIFIED BY DineEase2024';
        DBMS_OUTPUT.PUT_LINE('User created successfully.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('User already exists.');
    END IF;

    BEGIN
        EXECUTE IMMEDIATE 'GRANT CONNECT TO restaurant_admin';
        EXECUTE IMMEDIATE 'GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE, CREATE PROCEDURE, CREATE TRIGGER, CREATE USER TO restaurant_admin WITH ADMIN OPTION';
        EXECUTE IMMEDIATE 'GRANT CONNECT TO restaurant_admin WITH ADMIN OPTION';
        EXECUTE IMMEDIATE 'GRANT CREATE ROLE TO restaurant_admin WITH ADMIN OPTION';
        EXECUTE IMMEDIATE 'GRANT UNLIMITED TABLESPACE TO restaurant_admin';
        EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO restaurant_admin';
    EXCEPTION
        WHEN grant_error THEN
            NULL; 
    END;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

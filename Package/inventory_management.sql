CREATE OR REPLACE PACKAGE InventoryManagement AS
    PROCEDURE RefillStock(Item_ID IN NUMBER);
END InventoryManagement;
/
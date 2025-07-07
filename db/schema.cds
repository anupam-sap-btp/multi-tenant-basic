using { managed } from '@sap/cds/common';
namespace explore.db;

entity Products: managed {
    key ID: Integer;
    name: String(40);
    type: String(10);
    stock: Integer;
    unit: String(5);
    price: Integer;
    currency: String(5);
    virtual desc: String(20); 
}
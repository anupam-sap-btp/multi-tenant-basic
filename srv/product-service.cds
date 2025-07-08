using { explore.db as db } from '../db/schema';

service ProductService  {
    @odata.draft.enabled: true
    entity Products as projection on db.Products

    actions { @requires: ['admin']
        action AddStock(stock: Integer)  returns String;
    }
    function test() returns array of Products;

    // type jwtRet { jwt: String, cookie: String }
    function getjwt() returns String; //{ jwt: String; cookie: String };
}

annotate ProductService.Products with @(
    UI: {
        HeaderInfo  : {
            $Type : 'UI.HeaderInfoType',
            TypeName : 'Product',
            TypeNamePlural : 'Products',
            
        },
        SelectionFields  : [
            ID, name, type
        ],
        LineItem  : [
            { $Type: 'UI.DataField', Value: ID },
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value: type },
            { $Type: 'UI.DataField', Value: price },
            { $Type: 'UI.DataField', Value: stock},
            // { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.FieldGroup#Stock', Label: 'Stock'},
            { $Type: 'UI.DataField', Value: unit}
        ],
        HeaderFacets  : [
            { $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#Header', Label: 'Product Information'}
        ],
        Facets  : [
            { $Type: 'UI.ReferenceFacet', Target: '@UI.FieldGroup#General', Label: 'General'}
        ],
        // FieldGroup #Stock : {
        //     Data: [
        //         { $Type: 'UI.DataField', Value: stock},
        //         {
        //             $Type : 'UI.DataFieldForAction',
        //             Label : '{desc}',
        //             Action : 'ProductService.AddStock',
        //             Inline : true
        //         },
        //     ]
        // },        
        FieldGroup #Header : {
            Data: [
                { $Type: 'UI.DataField', Value: ID },
                { $Type: 'UI.DataField', Value: name },
                { $Type: 'UI.DataField', Value: type },
            ]  
        },
        FieldGroup #General : {
            Data: [
                { $Type: 'UI.DataField', Value: stock },
                { $Type: 'UI.DataField', Value: unit },
                { $Type: 'UI.DataField', Value: price },
            ]  
        },
    }
) {
    ID @( Common: { Label : 'Product ID' } );
    name @( Common: { Label : 'Description' } );
    type @(Common: {Label : 'Category',});
    price @(Common: {Label : 'Price',});
    stock @(Common: {Label : 'Available Stock',});
    unit @(Common: {Label : 'Unit',});
};
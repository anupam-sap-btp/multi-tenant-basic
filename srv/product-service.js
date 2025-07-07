const cds = require('@sap/cds');
module.exports = cds.service.impl( (srv) => {

    srv.on('AddStock', add_stock);

    srv.after('READ', 'Products', (lines) => { 
        if(Array.isArray(lines)) {
        lines.map((line) => { line.desc = line.ID + ' test' }) }
        else {
            lines.desc = lines.ID + ' test';
        }
    });
});

async function add_stock(req) {
    console.log("test action");

}
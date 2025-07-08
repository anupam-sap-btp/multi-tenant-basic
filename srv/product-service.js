const cds = require('@sap/cds');
const { executeHttpRequest } = require('@sap-cloud-sdk/http-client')
const { getDestination, retrieveJwt } = require('@sap-cloud-sdk/connectivity');

module.exports = cds.service.impl((srv) => {

    srv.on('AddStock', add_stock);

    srv.on('getjwt', async (req) => {
        const jwt = retrieveJwt(req);
        const cookieHeader = req.headers["cookie"] ?? req.headers["Cookie"];
        return JSON.stringify(req);
        return {jwt: jwt, cookie: cookieHeader};
    });

    srv.on('test', async () => {
        const response = (await cds.connect.to('test-dest')).send({
            method: 'get', path: '/odata/v4/product/Products'
        });
        console.log(response);
        return response;
    });

    srv.after('READ', 'Products', (lines) => {
        if (Array.isArray(lines)) {
            lines.map((line) => { line.desc = line.ID + ' test' })
        }
        else {
            lines.desc = lines.ID + ' test';
        }
    });
});

async function add_stock(req) {
    console.log("test action");

}
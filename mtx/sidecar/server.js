const cds = require('@sap/cds');

const xsenv = require('@sap/xsenv');
cds.on('served', async () => {
    console.log("Served!!!");
  const { 'cds.xt.SaasProvisioningService':provisioning } = cds.services
    await provisioning.prepend(() => {
      provisioning.on('dependencies', async (req, next) => {
        console.log("Dependencies!!!");
        await next()
        const services = xsenv.getServices({
          dest: { label: 'destination' }
        })
        console.log('Services>>>',services);
        let dependencies = [
          {
            xsappname: services.dest.xsappname
          }
        ]
        console.log("Dependencies>>>>>", dependencies);
        return dependencies
      })
    })
})

module.exports = cds.server;
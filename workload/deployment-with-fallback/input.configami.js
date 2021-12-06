/**
 * Template function processor
 * 
 * @param {ConfigamiContext} cg 
 * @param {Object} input 
 */
module.exports = function(cg, input) {
    // Lets map over some settings to the ingress object
    let ingress = input.ingress;

    // Parameter remapping
    ingress.name = ingress.name || input.name;
    ingress.namespace = ingress.namespace || input.namespace;

    ingress.serviceName = ingress.serviceName || (input.name+"-service-lb");
    ingress.servicePort = ingress.servicePort || 80;
}
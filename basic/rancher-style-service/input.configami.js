/**
 * Does the filtering of inputs, and applying its various fallbacks
 */
module.exports = function(cg, input) {
	//
	// Normalize clusterIP = none -> None
	//
	if( input.clusterIP == "none" ) {
        input.clusterIP = "None"
    }
    
	// Return the final input
	return input;
}
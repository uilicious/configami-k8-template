/**
 * Does the filtering of inputs, and applying its various fallbacks
 */
module.exports = function(cg, input) {
	//
	// Default fallbacks of volume settings
	//
	if( !input.volumes ) {
        input.volumes = input._default.volumes;
	}
	if( !input.volumeMounts ) {
        input.volumeMounts = input._default.volumeMounts;
	}

	// Return the final input
	return input;
}
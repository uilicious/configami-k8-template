/**
 * Does the filtering of inputs, and applying its various fallbacks
 */
module.exports = function(cg, input) {

	// Data object, to rencode if needed
	let dataObj = Object.assign( {}, input.data );

	// Re-encode?
	if ( input.encode_base64 == true ) {
		for (const key in dataObj) {
			dataObj[key] = Buffer.from(dataObj[key]).toString("base64");
		}
	}

	//
	// Custom handling of data wrapping
	//
	input._dataWrap = { data: dataObj }

	// Return the final input
	return input;
}
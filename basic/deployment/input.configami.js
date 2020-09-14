/**
 * Does the filtering of inputs, and applying its various fallbacks
 */
module.exports = function(cg, input) {
	//
	// Custom handling of enviornment variables
	//
	if( input.env || input.environment ) {
		// Get the various input
		const eObj = input.env || input.environment;
		const eKeys = Object.keys( eObj )
		const _enviornmentArr = [];

		// For each key remap it
		for(const key of eKeys) {
			_enviornmentArr.push({
				name: key,
				value: eObj[key]
			})
		}

		// Write the json obj (for use in template)
		if(_enviornmentArr.length > 0) {
			input._enviornmentJSON = { env:_enviornmentArr };
		}
	}

	//
	// setupTmpDir option
	//
	if( input.setupTmpDir ) {
		// Normalize volume/mounts
		input.volumes = input.volumes || [];
		input.volumeMounts = input.volumeMounts || [];

		// Add in the required volume
		let tmpVol = {
			name: "tmp-dir",
			emptyDir: {}
		};
		if( input.setupTmpDir_medium == "Memory" ) {
			tmpVol.emptyDir.medium = "Memory";
		}
		if( input.setupTmpDir_sizeLimit ) {
			tmpVol.emptyDir.sizeLimit = input.setupTmpDir_sizeLimit;
		}
		input.volumes.push(tmpVol);

		// And mount it
		input.volumeMounts.push({
			"mountPath": "/tmp",
			"name": "tmp-dir"
		})
	}

	//
	// Configure healthcheckProbe
	//
	if( input.healthcheckProbe ) {
		input.readinessProbe = input.readinessProbe || input.healthcheckProbe;
		input.livenessProbe = JSON.parse(JSON.stringify(input.livenessProbe || input.healthcheckProbe));
	}

	// Normalize livenessProbe successThreshold to 1 (according to k8 spec)
	if( input.livenessProbe && input.livenessProbe.successThreshold ) {
		input.livenessProbe.successThreshold = 1;
	}

	// Return the final input
	return input;
}
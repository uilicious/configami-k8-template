/**
 * Does the filtering of inputs, and applying its various fallbacks
 */
module.exports = function(cg, input) {
    
    //
    // Compute the auth file
    //
    if( input.basicHttpAuth.enable ) {

        // The auth file data
        let authFileData = ""

        // Get the user map (to iterate)
        const userMap = input.basicHttpAuth.userMap;
        for(const key in userMap) {
            authFileData += key+":{PLAIN}"+userMap[key]+"\n";
        }

        // Base64 encode the auth-file
        let authFileBuff = new Buffer(authFileData);
        input._authFileB64 = authFileBuff.toString('base64');
    
    }

	// Return the final input
	return input;
}
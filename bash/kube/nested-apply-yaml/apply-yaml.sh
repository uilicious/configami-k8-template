#!/bin/bash

# Get the current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

##############################################################
#
# For each subdir yaml - apply it
#
##############################################################

{{#if subdirArray}}
{{#each subdirArray}}

# Calling for {{this}}/apply-yaml.sh
#-----------------------------------------

# Reset the dir path
cd $SCRIPT_DIR
cd "{{this}}"

# Run the script
./apply-yaml.sh

{{/each}}
{{/if}}
#!/bin/bash

# Get the current script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

##############################################################
#
# Apply the various yaml files
#
##############################################################

# Setup the yaml files
if [ -z "$1" ]
then
    cd "$SCRIPT_DIR"
    ./kubectl.sh apply -f ./

    {{#if rancherProjectID}}
    # Rancher ID to use
    NAMESPACE_PROJECT_ID="{{rancherProjectID}}"
    NAMESPACE_PROJECT_LABEL="field.cattle.io/projectId=$NAMESPACE_PROJECT_ID"

    # Setup the projectID for various namespaces
    {{#each namespaceArray}}
    ./kubectl.sh annotate namespace "{{this}}" "$NAMESPACE_PROJECT_LABEL" 2> /dev/null
    {{/each}}
    {{/if}}
else
    ./kubectl.sh apply -f "$@"
fi

#!/bin/bash

##############################################################################
#
#  Wait for the given resource to be in a ready state
#
#  ./service-wait-ready.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE> 
#
##############################################################################

NAMESPACE="$1"
RESOURCE_NAME="$2"
RESOURCE_TYPE="$3"

if [[ -z "$RESOURCE_TYPE" ]]; then
    RESOURCE_TYPE="deployment"
fi

if [[ -z "$NAMESPACE" || -z "$RESOURCE_NAME" || -z "$RESOURCE_TYPE" ]]; then
	echo "Missing valid parameter"
	echo "Example : ./service-wait-ready.sh <NAMESPACE> <RESOURCE_NAME> [<RESOURCE_TYPE:deployment>]"
	exit;
fi

# Get the current script directory, and navigate to it
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPT_DIR"

# Wait for ready rollout status
# https://stackoverflow.com/questions/37448357/ensure-kubernetes-deployment-has-completed-and-all-pods-are-updated-and-availabl
./kubectl.sh rollout status $RESOURCE_TYPE --namespace "$NAMESPACE" "$RESOURCE_NAME"

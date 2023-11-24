#!/bin/bash

##############################################################################
#
#  Does a restart for given resource
#
#  ./service-restart.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE> 
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
	echo "Example : ./service-restart.sh <NAMESPACE> <RESOURCE_NAME> [<RESOURCE_TYPE:deployment>]"
	exit;
fi

# Get the current script directory, and navigate to it
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPT_DIR"

# Previously we did an env hack to do a restart
# https://github.com/rancher/rancher/issues/13389
#
# Now we use the rollout command instead
# https://medium.com/faun/how-to-restart-kubernetes-pod-7c702ca984c1
./kubectl.sh -n service rollout restart $RESOURCE_TYPE --namespace "$NAMESPACE" "$RESOURCE_NAME"

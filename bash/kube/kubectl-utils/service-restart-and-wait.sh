#!/bin/bash

##############################################################################
#
#  Does a restart for given resource, and wait for it to complete
#
#  ./service-restart-and-wait.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE> 
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
	echo "Example : ./service-restart-and-wait.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE>"
	exit;
fi

# Get the current script directory, and navigate to it
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$SCRIPT_DIR"

# Perform the restart
./service-restart.sh $NAMESPACE $RESOURCE_NAME $RESOURCE_TYPE

# Lets wait a minimum of 10 second (this resolve some restart race conditions)
sleep 10

# Wait for restart completion
./service-wait-ready.sh $NAMESPACE $RESOURCE_NAME $RESOURCE_TYPE

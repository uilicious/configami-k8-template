#!/bin/bash

##############################################################################
#
#  Does a restart for given resource, and wait for it to complete
#
#  ./restart-and-wait.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE> 
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
	echo "Example : ./restart-and-wait.sh <NAMESPACE> <RESOURCE_NAME> <RESOURCE_TYPE>"
	exit;
fi

./restart.sh $NAMESPACE $RESOURCE_NAME $RESOURCE_TYPE
./wait-ready.sh $NAMESPACE $RESOURCE_NAME $RESOURCE_TYPE
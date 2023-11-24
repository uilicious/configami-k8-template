#!/bin/bash

# Get the current working directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Kubeconfig path handling
KUBECONFIG_PATH="{{KUBECONFIG_PATH}}"
KUBECTL_BIN="$SCRIPT_DIR/{{KUBECTL_PATH}}"

# Run kubectl with custom kubeconfig (if set)
if [ -f "$KUBECONFIG_PATH" ]; then
	"$KUBECTL_BIN" --kubeconfig "$KUBECONFIG_PATH" "${@}"
else
	"$KUBECTL_BIN" "${@}"
fi

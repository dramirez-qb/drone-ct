#!/bin/bash
#Create project variable called CI_DEBUG and assing it "true" (case insensitive) to enable bash debug mode or "verbose" for verbose debug mode
if [ "${CI_DEBUG,,}" == "true" ]; then set -x ;elif [ "${CI_DEBUG,,}" == "verbose" ]; then set -xv; fi

set -o errexit
set -o nounset
set -o pipefail

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")

/usr/local/bin/ct "$@"

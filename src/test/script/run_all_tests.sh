#!/usr/bin/env bash

# Script setup, in case of error will exit immediately
set -o errexit
set -o pipefail

# run git_helper_test.sh
cd git
chmod 755 git_helper_test.sh
./git_helper_test.sh


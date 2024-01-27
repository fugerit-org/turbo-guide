#!/usr/bin/env bash

# Script setup, in case of error will exit immediately
set -o errexit
set -o pipefail

rm -fr fj-*

TEST_FILE=fj-doc/pom.xml

REPO_SUBSET=../../../../src/main/script/git/repo-subset.json

SCRIPT=../../../../src/main/script/git/git_helper.sh 

# built in command : clone
${SCRIPT} -k clone -s core -j ${REPO_SUBSET}
# built in command : fetch, checkout develop, pull
${SCRIPT} -k checkout -b develop -s core -j ${REPO_SUBSET}
# custom command : git log -3
${SCRIPT} -c 'git log -3'  -s core -j ${REPO_SUBSET}

if [[ -f ${TEST_FILE} ]]; then
	echo "${TEST_FILE} exists! test OK"
	rm -fr fj-*
	exit 0
else
	echo "${TEST_FILE} does not exists! test KO"
	exit 1
fi

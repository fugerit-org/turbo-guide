#!/usr/bin/env bash

rm -fr fj-*

TEST_FILE=fj-doc/pom.xml

../../../../src/main/script/git/git_helper.sh -k clone -s core -j ../../../../src/main/script/git/repo-subset.json

if [[ -f ${TEST_FILE} ]]; then
	echo "${TEST_FILE} exists! test OK"
	rm -fr fj-*
	exit 0
else
	echo "${TEST_FILE} does not exists! test KO"
	exit 1
fi

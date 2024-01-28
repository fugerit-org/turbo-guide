#!/usr/bin/env bash

# Run the same script on multiple repositories
#
# Author:
#	Matteo Franci <mttfranci@gmail.com>
#
# See : https://github.com/fugerit-org/turbo-guide/blob/main/src/main/shell/git/git_helper.md

# Script setup, in case of error will exit immediately
set -o errexit
set -o pipefail

# Script will show commands ran
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

# logging level
declare -i LOG_ERROR='0' # Error - 10
declare -i LOG_WARN='1' # Warning - 20
declare -i LOG_INFO='2' # Info - 30
declare -i LOG_DEBUG='3' # Debug - 40
declare -i LOG_TRACE='4' # Trace - 50
declare -i LOG_CURRENT='3' # Current log level
declare -a LOG_DESC=(ERROR WARN INFO DEBUG TRACE)

# Guida d'aiuto per l'uso dello script
help() {

	cat <<HERE

$@

Usage: ./git_helper.sh [options]
Options marked with * are required.

Sample usage : 
./git_helper.sh -k clone -s core -j repo-subset.json

Options:
--folder, -f
  Setup the base folder ${FOLDER}, default : current folder (${PWD}
--json, -j
  Path to json configuration, default: ${FOLDER}/repo-subset.json
--branch, -b
  Set the ${BRANCH} variable. 
  Search order ${BRANCH} : command line parameter, proprietà ansc-repo-subset.json "${subsetId}[].${repo}.branch" and "options.banch"
--kommand, -k
  Built in command to use :
    1) list - print list of repo and branch that would be processed for the given subset 
    2) checkout - checkout of all repositories to a give branch
    3) showhead - print head (git rev-parse HEAD)
    4) showbranch - print branch (git branch --show-current)
    5) showlog1 - print last entry of git log (git log -1)
    6) clone - clone all repository using json.options.clone_base_url if set
--command, -c
  Execute custom command on all repos
--help
	Show this help
HERE
	exit 1
}

function log() {
   	if [[ "${1}" -lt "${LOG_CURRENT}" ]]; then
   		echo "[${LOG_DESC[$1]}] - ${2}"
   	fi
}

function kommand_checkout() {
    set +e
    git checkout ${1}
    RET=${?}
    if [[ "${RET}" != "0" ]]; then
    	log "${LOG_WARN}" "Checkout of branch : ${1} failed, trying alternative : ${2}"
 		git checkout ${2}
 		RET=${?}
	fi
	set -e
	return ${RET}
}

# Read json configuration
read_json_config() {
  local json_file="${JSON_CONFIG}"
  # get options from json
  JSON_OPT_BRANCH=$(jq -r '.options.branch // ""' "$json_file" <<< "$i")
  CLONE_BASE_URL=$(jq -r '.options.clone_base_url // ""' "$json_file" <<< "$i")
  # "Read json configuration, config phase : ${json_file}, subset : ${SUBSET}"
  jq --arg SUBSET "$SUBSET" -c '.[$SUBSET].list[]' "$json_file" | while read -r i; do
  	local current_repo_folder=$(jq -c -r '.folder' <<< "$i")
  	local current_repo_branch=$(jq -c -r '.branch // ""' <<< "$i")
  	# env setup
  	REPO_PATH="${FOLDER}/${current_repo_folder}"
  	CURRENT_REPO_BRANCH="${current_repo_branch:=$JSON_OPT_BRANCH}"
  	BRANCH="${OPT_BRANCH:=$CURRENT_REPO_BRANCH}"
  	# built in : list
  	if [[ "${OPT_KOMMAND}" == "list" ]]; then
  		echo "option current_repo_folder : ${current_repo_folder}, current_repo_branch : ${current_repo_branch}, REPO_PATH : ${REPO_PATH}, BRANCH : ${BRANCH}"
  	# build in : checkout
  	elif [[ "${OPT_KOMMAND}" == "checkout" ]]; then
  		cd ${REPO_PATH}
  		git fetch	
  		kommand_checkout ${BRANCH} ${CURRENT_REPO_BRANCH}
  		CURR_EXIT=${?}
  		if [[ "${CURR_EXIT}" != "0" ]]; then
  			exit ${CURR_EXIT}
  		fi
  		git pull
   	elif [[ "${OPT_KOMMAND}" == "showhead" ]]; then
  		cd ${REPO_PATH}
  		git rev-parse HEAD
    elif [[ "${OPT_KOMMAND}" == "clone" ]]; then
    	local CURR_REPO_URL=${CLONE_BASE_URL}${current_repo_folder}
    	log "${LOG_INFO}" "Cloning repository : '${CURR_REPO_URL}'"
  		git clone ${CURR_REPO_URL}
    elif [[ "${OPT_KOMMAND}" == "showbranch" ]]; then
  		cd ${REPO_PATH}
  		git branch --show-current
    elif [[ "${OPT_KOMMAND}" == "showlog1" ]]; then
  		cd ${REPO_PATH}
  		git log -1
  	elif [[ "${OPT_COMMAND}" != "" ]]; then
  		log "${LOG_INFO}" "Running custom command on repo '${current_repo_folder}' : '${OPT_COMMAND}'"
  		cd ${REPO_PATH}
  		${OPT_COMMAND}
  	fi
  done
}

# Main entry point
main() {

	# Check runtime requirements
	# 1. jq per elaborare i file JSON
    # 2. git per clonare i repository
    
	if ! [ -x "$(command -v jq)" ]; then
		echo "Unable to locate 'jq' executable"
		echo "This is a necessary tool for parsing json configuration"
		echo "To install it, follow this link : https://stedolan.github.io/jq/download/"
		echo "On a windows system, if git bash is available it is possible to just execute the following command : "
		echo "curl -L -o /usr/bin/jq.exe https://github.com/stedolan/jq/releases/latest/download/jq-win64.exe"
		exit 2
	fi

  if ! [ -x "$(command -v git)" ]; then
    echo "Unable to locate 'git' executable"
    echo "This is a necessary tool for managing git repositories"
    echo "To install it, follow this link : https://git-scm.com/downloads"
    echo "On a windows system, it is possible to install the GitBash : https://gitforwindows.org/"
    exit 3
  fi
  
  FOLDER="${OPT_FOLDER:=$PWD}"
  log "${LOG_INFO}" "Base folder : ${FOLDER}"
  
  JSON_CONFIG="${OPT_JSON:=$FOLDER/repo-subset.json}"
  log "${LOG_INFO}" "Json config : ${JSON_CONFIG}"
  
  SUBSET="${OPT_SUBSET:=default}"
  log "${LOG_INFO}" "Subset id : ${SUBSET}"
  
  if [[ (("${OPT_KOMMAND}" == "") && ("${OPT_COMMAND}" == "")) || (("${OPT_KOMMAND}" != "") && ("${OPT_COMMAND}" != "")) ]]; then
    echo "ERROR: choose exactly one option, -k or -c"
    exit 4
  fi
  
  read_json_config
  exit ${?}
}

# Read command line arguments

POSITIONAL_ARGS=()

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-s | subset)
		OPT_SUBSET="$2"
		shift # past argument
    shift # past value
		;;
	-b | --branch)
		OPT_BRANCH="$2"
		shift # past argument
    shift # past value
		;;
	-j | --json)
		OPT_JSON="$2"
		shift # past argument
    shift # past value
		;;
	-f | --folder)
		OPT_FOLDER="$2"
		shift # past argument
    shift # past value
		;;
	-c | --command)
		OPT_COMMAND="$2"
		shift # past argument
    shift # past value
		;;
	-k | --kommand)
		OPT_KOMMAND="$2"
		shift # past argument
    shift # past value
		;;
	*)
		POSITIONAL_ARGS+=("$1") # save positional arg
		echo "Invalid parameter: $1"
		shift # past argument
		help "${@}"
		;;
	esac
done

# Run
main "${@}"
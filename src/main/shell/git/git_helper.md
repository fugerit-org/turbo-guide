# git_helper.sh script

Run the same script on multiple repositories.

Resources :
 
1. [bash script](git_helper.sh)
2. [json config sample](repo_subset.json) 

## Usate

``` 
Usage: ./git_helper.sh [options]
Options marked with * are required.

Sample usage :
./git_helper.sh -k clone -s core -j repo-subset.json

Options:
--folder, -f
  Setup the base folder , default : current folder (/Users/mttfranci/git/fug/turbo-guide/src/main/script/git
--json, -j
  Path to json configuration, default: /repo-subset.json
--branch, -b
  Set the  variable.
  Search order  : command line parameter, proprietà ansc-repo-subset.json "[]..branch" and "options.banch"
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
```

## Sample configuration file : 

```json
{
	"options":{
		"branch":"develop",
		"clone_base_url":"https://github.com/fugerit-org/"
	},
	"default": {
		"desription":"fugerit universe repositories",
		"list":[
		{ "folder":"fj-bom" },
		{ "folder":"fj-lib" },
		{ "folder":"fj-doc" },
		{ "folder":"fj-daogen" },
		{ "folder":"query-export-tool" },
		{ "folder":"yaml-doc-tool" },
		{ "folder":"github-issue-export" }
	]},
	"core": {
		"desription":"fugerit core repositories",
		"list":[
		{ "folder":"fj-bom" },
		{ "folder":"fj-lib" },
		{ "folder":"fj-doc" },
		{ "folder":"fj-daogen" }
	]}
}
``` 
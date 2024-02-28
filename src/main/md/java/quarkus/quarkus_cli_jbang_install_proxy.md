# Install quarkus-cli behind a proxy

*Abstract* : Trying to install and use quarkus cli behind a proxy.

On a windows computer behind a proxy, using the git bash, I was able to install the quarkus-cli just following the official instructions : 

[BUILDING QUARKUS APPS WITH QUARKUS COMMAND LINE INTERFACE (CLI)](https://quarkus.io/guides/cli-tooling)

Using the JBang method, and adding the following environment, as for [JBang configuration guide](https://www.jbang.dev/documentation/guide/latest/configuration.html) : 

`export JAVA_TOOL_OPTIONS="-Dhttp.proxyHost=$host -Dhttp.proxyPort=$port -Dhttp.proxyUser=$user -Dhttp.proxyPassword=$pass -Dhttps.proxyHost=$host -Dhttps.proxyPort=$port -Dhttps.proxyUser=$user -Dhttps.proxyPassword=$pass"`

curl too needs to be configured for proxy access, for instance with variable :

`export HTTPS_PROXY="$user:$pass@$host:$port"`

NOTE: maven too should be able to access external repository, via proxy or other means. (settings.xml)

## Tested on 

Windows, with git bash, using git basic authentication method

Warning : still not working with NTLM auth

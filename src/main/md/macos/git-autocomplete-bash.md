# MacOS : add git auto completion to bash

[index](index.md)

Download : 

```
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```
Add this code to .bash_profile

```
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
```

Make it executable :

`chmod +x ~/.git-completion.bash`

Reload the profile

`. ~/.bash_profile`

Credits : thanks to [Matt Cone](https://www.macinstruct.com/tutorials/how-to-enable-git-tab-autocomplete-on-your-mac/)


# gpg-git-windows.md

This document is based on the post : [Use GPG Signing Keys with Git (and GitHub) on Windows 10](https://medium.com/@ryanmillerc/use-gpg-signing-keys-with-git-on-windows-10-github-4acbced49f68)

1. Download [gpg4win](https://www.gpg4win.org/get-gpg4win.html)

2. Create a gpg key

3. Find the path of the gpg program (i.e. with where.exe)

4. set git config --user gpg.program [PATH_HERE] (or --global)
# git-clone-makepkg-updater
pulls git repos for foreign pacman packages and installs them via `makepkg -sic`
I made this because I needed it
Works on Arch, untested on everything else

If you clone git repositories to acquire foreign packages, there's a chance you'll find the script useful


### installation
You need to have all your cloned repos in one folder, or this won't work
#### 1: obtain the bash script
Click on `updater.sh` above and download the raw file.
Alternatively, you can `git clone` the repo, but you'll have to take the script out of its directory regardless
#### 2: move the bash script to the directory with the repo clones
`mv /download/path/updater.sh /repo/clones/direcory/updater.sh`
#### 3: make it executable
`chmod u+x /repo/clones/direcory/updater.sh`
#### 4: run it
`/repo/clones/direcory/updater.sh`



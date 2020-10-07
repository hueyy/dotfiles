# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export DISPLAY=127.0.0.1:0.0
#export DOCKER_HOST=tcp://localhost:2375

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# NPM
PATH="$HOME/.npm-global/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias youtube-dl="youtube-dl -f best --add-metadata --all-subs --embed-subs --embed-thumbnail"

export GPG_TTY=$(tty)

ocr() {
  ocrmypdf -l eng --rotate-pages --deskew --jobs 4 $1 $1
} 

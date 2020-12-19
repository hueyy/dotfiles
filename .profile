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

if [ -z "$SSH_AUTH_SOCK" ]; then
	# Check for a currently running instance of the agent
	RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
	if [ "$RUNNING_AGENT" = "0" ]; then
		# Launch a new instance of the agent
		ssh-agent -s &> .ssh/ssh-agent
       	fi
	#eval `cat .ssh/ssh-agent`
fi

# start tmux on startup
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

export DISPLAY=192.168.10.96:0.0
export LIBGL_ALWAYS_INDIRECT=1

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

destreamer() {
  pushd ~/.bin/destreamer/ && ./destreamer.sh -k --cc -o ~/Desktop/ -i "$@" && popd
}

decodeFont() {
  base64 --decode $1.txt 2> /dev/null > $1.bin
}

alias bfg="java -jar ~/.bin/bfg.jar"

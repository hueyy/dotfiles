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
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
#fi

# set PATH so it includes user's private bin directories
PATH="$HOME/.bin:$HOME/.local/bin:$PATH"

export LIBGL_ALWAYS_INDIRECT=1

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# NPM
PATH="$HOME/.npm-global/bin:$PATH"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export GPG_TTY=$(tty)

export DENO_INSTALL="/home/huey/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source "$HOME/.aliases"

eval "$(zoxide init zsh)"

export PATH="$HOME/.poetry/bin:$PATH"

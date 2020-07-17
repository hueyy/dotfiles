export DISPLAY=127.0.0.1:0.0

# NPM
PATH="$HOME/.npm-global/bin:$PATH"

# PYENV
export PYENV_ROOT="$HOME/.pyenv"
PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

alias youtube-dl="youtube-dl -f best --add-metadata --all-subs --embed-subs --embed-thumbnail"

export GPG_TTY=$(tty)

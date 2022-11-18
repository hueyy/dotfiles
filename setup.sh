# assume git clone to ~
sudo add-apt-repository -yn deb https://gitsecret.jfrog.io/artifactory/git-secret-deb git-secret main
wget -qO - 'https://gitsecret.jfrog.io/artifactory/api/gpg/key/public' | sudo apt-key add -
sudo add-apt-repository -yn deb https://deb.volian.org/volian/ scar main
wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg > /dev/null
sudo apt update && sudo apt install -y nala && sudo nala install -y git vim nano ncdu zsh git-secret nala bat
mkdir -p ~/.bin

ln -s ~/.dotfiles/.ssh ~
ln -s ~/.dotfiles/.vim ~
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.oh-my-zsh ~
ln -s ~/.dotfiles/.profile ~/.profile
ln -s ~/.dotfiles/.aliases ~/.aliases
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.tmux ~

chsh -s $(which zsh)

DOWNLOADS_FOLDER=~/Downloads

# lsd
LSD_FILENAME=lsd-musl_0.22.0_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/Peltoche/lsd/releases/download/0.22.0/$LSD_FILENAME"
sudo nala install -y $DOWNLOADS_FOLDER/$LSD_FILENAME
rm $DOWNLOADS_FOLDER/$LSD_FILENAME

# delta
DELTA_FILENAME=git-delta_0.13.0_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/dandavison/delta/releases/download/0.13.0/$DELTA_FILENAME"
sudo nala install -y $DOWNLOADS_FOLDER/$DELTA_FILENAME
rm $DOWNLOADS_FOLDER/$DELTA_FILENAME

# duf
DUF_FILENAME=duf_0.8.1_linux_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/muesli/duf/releases/download/v0.8.1/$DUF_FILENAME"
sudo nala install -y $DOWNLOADS_FOLDER/$DUF_FILENAME
rm $DOWNLOADS_FOLDER/$DUF_FILENAME

# curlie
CURLIE_FILENAME=curlie_1.6.9_linux_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/rs/curlie/releases/download/v1.6.9/$CURLIE_FILENAME"
sudo nala install -y $DOWNLOADS_FOLDER/$CURLIE_FILENAME
rm $DOWNLOADS_FOLDER/$CURLIE_FILENAME

# install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
nvm install --lts=gallium
nvm use gallium

# zoxide
curl -sS https://webinstall.dev/zoxide | bash

npm i -g gtop tldr

curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
exec $SHELL

pyenv install 3.10

# golang
wget https://go.dev/dl/go1.19.2.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.19.2.linux-amd64.tar.gz
rm go1.19.2.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

source ~/.profile

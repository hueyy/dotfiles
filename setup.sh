# assume git clone to ~
sudo sh -c "echo 'deb https://gitsecret.jfrog.io/artifactory/git-secret-deb git-secret main' >> /etc/apt/sources.list"
wget -qO - 'https://gitsecret.jfrog.io/artifactory/api/gpg/key/public' | sudo apt-key add -
sudo apt update && sudo apt install git vim nano ncdu zsh git-secret -y
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
LSD_FILENAME=lsd-musl_0.20.1_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/Peltoche/lsd/releases/download/0.20.1/$LSD_FILENAME"
sudo apt install -y $DOWNLOADS_FOLDER/$LSD_FILENAME
rm $DOWNLOADS_FOLDER/$LSD_FILENAME

# delta
DELTA_FILENAME=git-delta_0.8.2_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/dandavison/delta/releases/download/0.8.2/$DELTA_FILENAME"
sudo apt install -y $DOWNLOADS_FOLDER/$DELTA_FILENAME
rm $DOWNLOADS_FOLDER/$DELTA_FILENAME

# duf
DUF_FILENAME=duf_0.6.2_linux_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/muesli/duf/releases/download/v0.6.2/$DUF_FILENAME"
sudo apt install -y $DOWNLOADS_FOLDER/$DUF_FILENAME
rm $DOWNLOADS_FOLDER/$DUF_FILENAME

# curlie
CURLIE_FILENAME=curlie_1.6.0_linux_amd64.deb
wget -P $DOWNLOADS_FOLDER "https://github.com/rs/curlie/releases/download/v1.6.0/$CURLIE_FILENAME"
sudo apt install -y $DOWNLOADS_FOLDER/$CURLIE_FILENAME
rm $DOWNLOADS_FOLDER/$CURLIE_FILENAME

# install node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts=fermium

# zoxide
curl -sS https://webinstall.dev/zoxide | bash

npm i -g tldr gtop commitizen

source ~/.profile
